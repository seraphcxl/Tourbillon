//
//  NSMutableSet+DCHSafeCRUD.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSMutableSet+DCHSafeCRUD.h"

@implementation NSMutableSet (DCHSafeCRUD)

- (void)DCH_safe_addObject:(id)object {
    do {
        if (DCH_IsEmpty(object)) {
            break;
        }
        [self addObject:object];
    } while (NO);
}

- (void)DCH_safe_removeObject:(id)object {
    do {
        if (DCH_IsEmpty(object)) {
            break;
        }
        [self removeObject:object];
    } while (NO);
}

@end
