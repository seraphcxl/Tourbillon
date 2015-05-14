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
- (NSUInteger)DCH_threadSafe_count;
- (id)DCH_threadSafe_objectForKey:(id)aKey;
- (NSArray *)DCH_threadSafe_allKeys;
- (NSArray *)DCH_threadSafe_allKeysForObject:(id)anObject;
- (NSArray *)DCH_threadSafe_allValues;

- (void)DCH_threadSafe_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)DCH_threadSafe_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);

#pragma mark - NSMutableDictionary
- (void)DCH_threadSafe_removeObjectForKey:(id)aKey;
- (void)DCH_threadSafe_setObject:(id)anObject forKey:(id <NSCopying>)aKey;
- (void)DCH_threadSafe_removeAllObjects;
- (void)DCH_threadSafe_removeObjectsForKeys:(NSArray *)keyArray;
- (void)DCH_threadSafe_setDictionary:(NSDictionary *)otherDictionary;

@end
