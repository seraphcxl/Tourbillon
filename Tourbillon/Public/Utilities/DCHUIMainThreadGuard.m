//
//  DCHUIMainThreadGuard.m
//  Tourbillon
//
//  Created by Derek Chen on 4/1/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "DCHUIMainThreadGuard.h"
#import "DCHCommonConstants.h"
#import "NSObject+DCHSwizzle.h"
#import <objc/message.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#endif

@interface DCHUIMainThreadGuard ()

@end

@implementation DCHUIMainThreadGuard

+ (void)assertIfNotMainThread {
    DCHAssert([NSThread isMainThread], @"\nERROR: All calls to UI need to happen on the main thread. You have a bug in your code. Use dispatch_async(dispatch_get_main_queue(), ^{ ... });\n\n%@\nStacktrace: %@", [NSThread currentThread], [NSThread callStackSymbols]);
}

+ (void)guarding {
#if DEBUG
    @autoreleasepool {
        do {
            for (NSString *selStr in @[PROPERTY(setNeedsLayout), PROPERTY(setNeedsDisplay), PROPERTY(setNeedsDisplayInRect:)]) {
                SEL selector = NSSelectorFromString(selStr);
                SEL newSelector = NSSelectorFromString([NSString stringWithFormat:@"DCH_%@", selStr]);
                if ([selStr hasSuffix:@":"]) {
#if TARGET_OS_IPHONE
                    DCHReplaceMethodWithBlock(UIView.class, selector, newSelector, ^(__unsafe_unretained UIView *_self, CGRect r) {
                        [DCHUIMainThreadGuard assertIfNotMainThread];
                        ((void ( *)(id, SEL, CGRect))objc_msgSend)(_self, newSelector, r);
                    });
#else
                    DCHReplaceMethodWithBlock(NSView.class, selector, newSelector, ^(__unsafe_unretained NSView *_self, CGRect r) {
                        [DCHUIMainThreadGuard assertIfNotMainThread];
                        ((void ( *)(id, SEL, CGRect))objc_msgSend)(_self, newSelector, r);
                    });
#endif
                    
                } else {
#if TARGET_OS_IPHONE
                    DCHReplaceMethodWithBlock(UIView.class, selector, newSelector, ^(__unsafe_unretained UIView *_self) {
                        [DCHUIMainThreadGuard assertIfNotMainThread];
                        ((void ( *)(id, SEL))objc_msgSend)(_self, newSelector);
                    });
#else
                    DCHReplaceMethodWithBlock(NSView.class, selector, newSelector, ^(__unsafe_unretained NSView *_self) {
                        [DCHUIMainThreadGuard assertIfNotMainThread];
                        ((void ( *)(id, SEL))objc_msgSend)(_self, newSelector);
                    });
#endif
                    
                }
            }
        } while (NO);
    }
#endif
}

@end
