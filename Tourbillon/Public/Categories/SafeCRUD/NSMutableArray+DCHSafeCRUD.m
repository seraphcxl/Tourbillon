//
//  NSMutableArray+DCHSafeCRUD.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSMutableArray+DCHSafeCRUD.h"

@implementation NSMutableArray (DCHSafeCRUD)

- (void)DCH_safe_addObject:(id)anObject {
    do {
        if (DCH_IsEmpty(anObject)) {
            break;
        }
        [self addObject:anObject];
    } while (NO);
}

- (void)DCH_safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    do {
        if (DCH_IsEmpty(anObject) || index > self.count) {
            break;
        }
        [self insertObject:anObject atIndex:index];
    } while (NO);
}

- (void)DCH_safe_removeObjectAtIndex:(NSUInteger)index {
    do {
        if (index >= self.count) {
            break;
        }
        [self removeObjectAtIndex:index];
    } while (NO);
}

- (void)DCH_safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    do {
        if (DCH_IsEmpty(anObject) || index >= self.count) {
            break;
        }
        [self replaceObjectAtIndex:index withObject:anObject];
    } while (NO);
}

- (void)DCH_safe_removeObject:(id)anObject inRange:(NSRange)range {
    do {
        if (!DCH_IsEmpty(anObject) && range.length != 0 && range.location <= self.count && (range.location + range.length) <= self.count) {
            [self removeObject:anObject inRange:range];
        }
    } while (NO);
}

- (void)DCH_safe_removeObject:(id)anObject {
    do {
        if (DCH_IsEmpty(anObject)) {
            break;
        }
        [self removeObject:anObject];
    } while (NO);
}

- (void)DCH_safe_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    do {
        if (!DCH_IsEmpty(anObject) && range.length != 0 && range.location <= self.count && (range.location + range.length) <= self.count) {
            [self removeObjectIdenticalTo:anObject inRange:range];
        }
    } while (NO);
}

- (void)DCH_safe_removeObjectIdenticalTo:(id)anObject {
    do {
        if (!DCH_IsEmpty(anObject)) {
            [self removeObjectIdenticalTo:anObject];
        }
    } while (NO);
}

- (void)DCH_safe_removeObjectsInRange:(NSRange)range {
    do {
        if (range.length != 0 && range.location <= self.count && (range.location + range.length) <= self.count) {
            [self DCH_safe_removeObjectsInRange:range];
        }
    } while (NO);
}

@end
