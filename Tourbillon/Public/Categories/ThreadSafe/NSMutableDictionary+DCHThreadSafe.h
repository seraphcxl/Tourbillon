//
//  NSMutableDictionary+DCHThreadSafe.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DCHThreadSafe.h"

@interface NSMutableDictionary (DCHThreadSafe)

#pragma mark - NSDictionary
- (NSUInteger)dch_threadSafe_count;
- (id)dch_threadSafe_objectForKey:(id)aKey;
- (NSArray *)dch_threadSafe_allKeys;
- (NSArray *)dch_threadSafe_allKeysForObject:(id)anObject;
- (NSArray *)dch_threadSafe_allValues;

- (void)dch_threadSafe_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)dch_threadSafe_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);

#pragma mark - NSMutableDictionary
- (void)dch_threadSafe_removeObjectForKey:(id)aKey;
- (void)dch_threadSafe_setObject:(id)anObject forKey:(id <NSCopying>)aKey;
- (void)dch_threadSafe_removeAllObjects;
- (void)dch_threadSafe_removeObjectsForKeys:(NSArray *)keyArray;
- (void)dch_threadSafe_setDictionary:(NSDictionary *)otherDictionary;

@end
