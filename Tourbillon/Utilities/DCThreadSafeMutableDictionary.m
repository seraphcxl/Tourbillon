//
//  DCThreadSafeMutableDictionary.m
//  Tourbillon
//
//  Created by Chen XiaoLiang on 10/13/13.
//  Copyright (c) 2013 CaptainSolid Studio. All rights reserved.
//

#import "DCThreadSafeMutableDictionary.h"
#import <libkern/OSAtomic.h>

@implementation DCThreadSafeMutableDictionary {
    OSSpinLock _lock;
    NSMutableDictionary *_dictionary; // Class Cluster
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

- (id)init {
    return [self initWithCapacity:0];
}

- (id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys {
    if ((self = [self initWithCapacity:objects.count])) {
        [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [_dictionary setObject:obj forKey:[keys objectAtIndex:idx]];
        }];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity {
    if ((self = [super init])) {
        _dictionary = [[NSMutableDictionary alloc] initWithCapacity:capacity];
        _lock = OS_SPINLOCK_INIT;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSMutableDictionary

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    OSSpinLockLock(&_lock);
    [_dictionary setObject:anObject forKey:aKey];
    OSSpinLockUnlock(&_lock);
}

- (void)removeObjectForKey:(id)aKey {
    OSSpinLockLock(&_lock);
    [_dictionary removeObjectForKey:aKey];
    OSSpinLockUnlock(&_lock);
}

- (NSUInteger)count {
    OSSpinLockLock(&_lock);
    NSUInteger count = _dictionary.count;
    OSSpinLockUnlock(&_lock);
    return count;
}

- (id)objectForKey:(id)aKey {
    OSSpinLockLock(&_lock);
    id obj = [_dictionary objectForKey:aKey];
    OSSpinLockUnlock(&_lock);
    return obj;
}

- (NSEnumerator *)keyEnumerator {
    OSSpinLockLock(&_lock);
    NSEnumerator *keyEnumerator = [_dictionary keyEnumerator];
    OSSpinLockUnlock(&_lock);
    return keyEnumerator;
}

@end
