//
//  NSObject+DCHSwizzle.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

extern BOOL DCHReplaceMethodWithBlock(Class c, SEL origSEL, SEL newSEL, id block);

@interface NSObject (DCHSwizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSelector withNewSelector:(SEL)newSelector;

@end
