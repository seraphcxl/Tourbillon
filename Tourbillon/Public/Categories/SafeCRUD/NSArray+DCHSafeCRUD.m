//
//  NSArray+DCHSafeCRUD.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSArray+DCHSafeCRUD.h"

@implementation NSArray (DCHSafeCRUD)

- (id)dch_safe_objectAtIndex:(NSUInteger)index {
    id result = nil;
    do {
        if (index < self.count) {
            result = [self objectAtIndex:index];
        }
    } while (NO);
    return result;
}

- (NSUInteger)dch_safe_indexOfObject:(id)anObject {
    NSUInteger result = 0;
    do {
        if (DCH_IsEmpty(anObject)) {
            break;
        }
        result = [self indexOfObject:anObject];
    } while (NO);
    return result;
}

- (NSUInteger)dch_safe_indexOfObject:(id)anObject inRange:(NSRange)range {
    NSUInteger result = 0;
    do {
        if (!DCH_IsEmpty(anObject) && range.length != 0 && range.location <= self.count && (range.location + range.length) <= self.count) {
            result = [self indexOfObject:anObject inRange:range];
        }
    } while (NO);
    return result;
}

- (NSUInteger)dch_safe_indexOfObjectIdenticalTo:(id)anObject {
    NSUInteger result = 0;
    do {
        if (DCH_IsEmpty(anObject)) {
            break;
        }
        result = [self indexOfObjectIdenticalTo:anObject];
    } while (NO);
    return result;
}

- (NSUInteger)dch_safe_indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    NSUInteger result = 0;
    do {
        if (!DCH_IsEmpty(anObject) && range.length != 0 && range.location <= self.count && (range.location + range.length) <= self.count) {
            result = [self indexOfObjectIdenticalTo:anObject inRange:range];
        }
    } while (NO);
    return result;
}

@end
