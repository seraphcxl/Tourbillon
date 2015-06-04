//
//  NSMutableDictionary+DCHSafeCRUD.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSMutableDictionary+DCHSafeCRUD.h"

@implementation NSMutableDictionary (DCHSafeCRUD)

- (void)dch_safe_removeObjectForKey:(id)aKey {
    do {
        if (DCH_IsEmpty(aKey)) {
            break;
        }
        [self removeObjectForKey:aKey];
    } while (NO);
}

- (void)dch_safe_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    do {
        if (DCH_IsEmpty(aKey) || DCH_IsEmpty(anObject)) {
            break;
        }
        [self setObject:anObject forKey:aKey];
    } while (NO);
}

@end
