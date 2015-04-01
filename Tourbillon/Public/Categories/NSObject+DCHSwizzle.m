//
//  NSObject+DCHSwizzle.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSObject+DCHSwizzle.h"
#import <objc/runtime.h>
#import "DCHCommonConstants.h"

BOOL DCHReplaceMethodWithBlock(Class c, SEL origSEL, SEL newSEL, id block) {
    BOOL result = NO;
    do {
        DCHAssert(c && origSEL && newSEL && block);
        Method origMethod = class_getInstanceMethod(c, origSEL);
        if (!origMethod) {
            break;
        }
        const char *encoding = method_getTypeEncoding(origMethod);
        
        // Add the new method.
        IMP impl = nil;
#if TARGET_OS_IPHONE
        impl = imp_implementationWithBlock(block);
#else
        impl = imp_implementationWithBlock(block);
#endif
        if (!class_addMethod(c, newSEL, impl, encoding)) {
            NSLog(@"Failed to add method: %@ on %@", NSStringFromSelector(newSEL), c);
            break;
        } else {
            // Ensure the new selector has the same parameters as the existing selector.
            Method newMethod = class_getInstanceMethod(c, newSEL);
            DCHAssert(strcmp(method_getTypeEncoding(origMethod), method_getTypeEncoding(newMethod)) == 0, @"Encoding must be the same.");
            
            // If original doesn't implement the method we want to swizzle, create it.
            if (class_addMethod(c, origSEL, method_getImplementation(newMethod), encoding)) {
                class_replaceMethod(c, newSEL, method_getImplementation(origMethod), encoding);
            } else {
                method_exchangeImplementations(origMethod, newMethod);
            }
        }
        result = YES;
    } while (NO);
    return result;
}

@implementation NSObject (DCHSwizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSelector withNewSelector:(SEL)newSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    BOOL methodAdded = class_addMethod([self class], originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    
    if (methodAdded) {
        class_replaceMethod([self class], newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@end
