//
//  DCDictionaryCache.h
//  Tourbillon
//
//  Created by Derek Chen on 8/21/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCDictionaryCache : NSObject

- (instancetype)initWithCountLimit:(NSUInteger)lim;

- (void)setCountLimit:(NSUInteger)lim;
- (NSUInteger)countLimit;

- (id)objectForKey:(id)aKey;
- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey;
- (void)removeObjectForKey:(id)aKey;

- (NSArray *)allKeys;
- (NSArray *)allValues;
- (void)removeAllObjects;

@end
