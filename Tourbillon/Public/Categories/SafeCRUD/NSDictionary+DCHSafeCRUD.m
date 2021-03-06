//
//  NSDictionary+DCHSafeCRUD.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSDictionary+DCHSafeCRUD.h"

@implementation NSDictionary (DCHSafeCRUD)

- (id)dch_safe_objectForKey:(id)aKey {
    id result = nil;
    do {
        if (DCH_IsEmpty(aKey)) {
            break;
        }
        result = [self objectForKey:aKey];
    } while (NO);
    return result;
}

- (NSArray *)dch_safe_allKeysForObject:(id)anObject {
    NSArray *result = nil;
    do {
        if (DCH_IsEmpty(anObject)) {
            break;
        }
        result = [self allKeysForObject:anObject];
    } while (NO);
    return result;
}

@end
