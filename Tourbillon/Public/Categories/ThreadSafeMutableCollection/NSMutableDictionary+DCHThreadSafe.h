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
- (NSUInteger)threadSafe_count;
- (id)threadSafe_objectForKey:(id)aKey;
- (NSArray *)threadSafe_allKeys;
- (NSArray *)threadSafe_allKeysForObject:(id)anObject;
- (NSArray *)threadSafe_allValues;

- (void)threadSafe_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)threadSafe_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);

#pragma mark - NSMutableDictionary
- (void)threadSafe_removeObjectForKey:(id)aKey;
- (void)threadSafe_setObject:(id)anObject forKey:(id <NSCopying>)aKey;
- (void)threadSafe_removeAllObjects;
- (void)threadSafe_removeObjectsForKeys:(NSArray *)keyArray;
- (void)threadSafe_setDictionary:(NSDictionary *)otherDictionary;

@end
