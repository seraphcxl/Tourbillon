//
//  NSArray+DCContentExtension.m
//  Tourbillon
//
//  Created by Derek Chen on 7/9/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSArray+DCContentExtension.h"

@implementation NSArray (DCContentExtension)

- (BOOL)contentEqualTo:(NSArray *)otherArray {
    BOOL result = NO;
    do {
        if (!otherArray) {
            break;
        }
        if (self.count != otherArray.count) {
            break;
        }
        BOOL notFound = NO;
        for (id obj in otherArray) {
            if ([self indexOfObject:obj] == NSNotFound) {
                notFound = YES;
                break;
            }
        }
        if (!notFound) {
            result = YES;
        }
    } while (NO);
    return result;
}

@end
