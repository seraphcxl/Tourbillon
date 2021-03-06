//
//  NSMutableDictionary+DCHThreadSafe.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSMutableDictionary+DCHThreadSafe.h"
#import "NSDictionary+DCHSafeCRUD.h"
#import "NSMutableDictionary+DCHSafeCRUD.h"

@implementation NSMutableDictionary (DCHThreadSafe)

#pragma mark NSDictionary
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

- (id)dch_threadSafe_objectForKey:(id)aKey {
    __block id result = nil;
    do {
        if (!aKey) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            DCHDictionarySafeRead(self, aKey, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSArray *)dch_threadSafe_allKeys {
    __block NSArray *result = nil;
    do {
        if (![self dch_threadSafe_QueueSync:^{
            result = [self allKeys];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSArray *)dch_threadSafe_allKeysForObject:(id)anObject {
    __block NSArray *result = nil;
    do {
        if (!anObject) {
            break;
        }
        if (![self dch_threadSafe_QueueSync:^{
            DCHDictionarySafeAllKeysForObject(self, anObject, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSArray *)dch_threadSafe_allValues {
    __block NSArray *result = nil;
    do {
        if (![self dch_threadSafe_QueueSync:^{
            result = [self allValues];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (void)dch_threadSafe_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block {
    do {
        if (!block) {
            break;
        }
        if (![self dch_threadSafe_QueueBarrierSync:^{
            [self enumerateKeysAndObjectsUsingBlock:block];
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block {
    do {
        if (!block) {
            break;
        }
        if (![self dch_threadSafe_QueueBarrierSync:^{
            [self enumerateKeysAndObjectsWithOptions:opts usingBlock:block];
        }]) {
            break;
        }
    } while (NO);
}

#pragma mark NSMutableDictionary
- (void)dch_threadSafe_removeObjectForKey:(id)aKey {
    do {
        if (!aKey) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableDictionarySafeRemove(self, aKey);
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    do {
        if (!aKey || !anObject) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableDictionarySafeSet(self, aKey, anObject);
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

- (void)dch_threadSafe_removeObjectsForKeys:(NSArray *)keyArray {
    do {
        if (!keyArray || [keyArray count] == 0) {
            break;
        }
        if (![self threafSafe_Setting:^{
            [self removeObjectsForKeys:keyArray];
        }]) {
            break;
        }
    } while (NO);
}

- (void)dch_threadSafe_setDictionary:(NSDictionary *)otherDictionary {
    do {
        if (![self threafSafe_Setting:^{
            [self setDictionary:otherDictionary];
        }]) {
            break;
        }
    } while (NO);
}

@end
