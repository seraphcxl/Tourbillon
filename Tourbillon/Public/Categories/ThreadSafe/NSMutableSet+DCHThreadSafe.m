//
//  NSMutableSet+DCHThreadSafe.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSMutableSet+DCHThreadSafe.h"
#import "NSMutableSet+DCHSafeCRUD.h"

@implementation NSMutableSet (DCHThreadSafe)

#pragma mark NSSet
- (NSUInteger)dch_threadSafe_count {
    __block NSUInteger result = 0;
    do {
        if (![self dch_threadSafe_QueueSync:^{
            result = [self count];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (id)dch_threadSafe_member:(id)object {
    __block id result = nil;
    do {
        if (!object) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            result = [self member:object];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSArray *)dch_threadSafe_allObjects {
    __block NSArray *result = nil;
    do {
        if (![self dch_threadSafe_QueueSync:^{
            result = [self allObjects];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)dch_threadSafe_containsObject:(id)anObject {
    __block BOOL result = NO;
    do {
        if (!anObject) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            result = [self containsObject:anObject];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)dch_threadSafe_intersectsSet:(NSSet *)otherSet {
    __block BOOL result = NO;
    do {
        if (!otherSet) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            result = [self intersectsSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)dch_threadSafe_isEqualToSet:(NSSet *)otherSet {
    __block BOOL result = NO;
    do {
        if (!otherSet) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            result = [self isEqualToSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)dch_threadSafe_isSubsetOfSet:(NSSet *)otherSet {
    __block BOOL result = NO;
    do {
        if (!otherSet) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            result = [self isSubsetOfSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (void)dch_threadSafe_makeObjectsPerformSelector:(SEL)aSelector {
    do {
        if (!aSelector) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            [self makeObjectsPerformSelector:aSelector];
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument {
    do {
        if (!aSelector || !argument) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            [self makeObjectsPerformSelector:aSelector withObject:argument];
        }]) {
            break;
        }
    } while (NO);
}

- (NSSet *)dch_threadSafe_setByAddingObject:(id)anObject {
    __block NSSet *result = nil;
    do {
        if (!anObject) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            result = [self setByAddingObject:anObject];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSSet *)dch_threadSafe_setByAddingObjectsFromSet:(NSSet *)other {
    __block NSSet *result = nil;
    do {
        if (!other) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            result = [self setByAddingObjectsFromSet:other];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSSet *)dch_threadSafe_setByAddingObjectsFromArray:(NSArray *)other {
    __block NSSet *result = nil;
    do {
        if (!other) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            result = [self setByAddingObjectsFromArray:other];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (void)dch_threadSafe_enumerateObjectsUsingBlock:(void (^)(id obj, BOOL *stop))block {
    do {
        if (!block) {
            break;
        }
        if (![self dch_threadSafe_QueueBarrierSync:^{
            [self enumerateObjectsUsingBlock:block];
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, BOOL *stop))block {
    do {
        if (!block) {
            break;
        }
        if (![self dch_threadSafe_QueueBarrierSync:^{
            [self enumerateObjectsWithOptions:opts usingBlock:block];
        }]) {
            break;
        }
    } while (NO);
}

#pragma mark NSMutableSet
- (void)dch_threadSafe_addObject:(id)object {
    do {
        if (!object) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableSetSafeAdd(self, object);
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_removeObject:(id)object {
    do {
        if (!object) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableSetSafeRemove(self, object);
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_addObjectsFromArray:(NSArray *)array {
    do {
        if (!array || [array count]) {
            break;
        }
        if (![self threafSafe_Setting:^{
            [self addObjectsFromArray:array];
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_intersectSet:(NSSet *)otherSet {
    do {
        if (!otherSet) {
            break;
        }
        if (![self threafSafe_Setting:^{
            [self intersectSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_minusSet:(NSSet *)otherSet {
    do {
        if (!otherSet) {
            break;
        }
        if (![self threafSafe_Setting:^{
            [self minusSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_removeAllObjects {
    do {
        if (![self threafSafe_Setting:^{
            [self removeAllObjects];
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_unionSet:(NSSet *)otherSet {
    do {
        if (!otherSet) {
            break;
        }
        if (![self threafSafe_Setting:^{
            [self minusSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_setSet:(NSSet *)otherSet {
    do {
        if (![self threafSafe_Setting:^{
            [self setSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
}

@end
