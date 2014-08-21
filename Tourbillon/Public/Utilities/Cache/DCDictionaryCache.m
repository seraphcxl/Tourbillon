//
//  DCDictionaryCache.m
//  Tourbillon
//
//  Created by Derek Chen on 8/21/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCDictionaryCache.h"

static const NSUInteger DCDictionaryCache_DefaultCountLimit = 64;

@interface DCDictionaryCache () <NSCacheDelegate> {
}

@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation DCDictionaryCache

@synthesize cache = _cache;
@synthesize dict = _dict;

- (id)init {
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
        _cache.delegate = self;
        [_cache setCountLimit:DCDictionaryCache_DefaultCountLimit];
        
        self.dict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithCountLimit:(NSUInteger)lim {
    if (lim == 0) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
        _cache.delegate = self;
        [_cache setCountLimit:lim];
        
        self.dict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    do {
        @synchronized(self) {
            [_dict removeAllObjects];
            self.dict = nil;
            
            _cache.delegate = nil;
            [_cache removeAllObjects];
            self.cache = nil;
        }
    } while (NO);
}

- (void)setCountLimit:(NSUInteger)lim {
    do {
        @synchronized(self) {
            [_cache setCountLimit:lim];
        }
    } while (NO);
}

- (NSUInteger)countLimit {
    return _cache.countLimit;
}

- (id)objectForKey:(id)aKey {
    return [_dict objectForKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    do {
        if (!aKey || !anObject) {
            break;
        }
        @synchronized(self) {
            if (!_cache || !_dict) {
                break;
            }
            [_dict setObject:anObject forKey:aKey];
            [_cache setObject:aKey forKey:aKey];
        }
    } while (NO);
}

- (void)removeObjectForKey:(id)aKey {
    do {
        @synchronized(self) {
            if (!_cache || !_dict) {
                break;
            }
            [_dict removeObjectForKey:aKey];
            [_cache removeObjectForKey:aKey];
        }
    } while (NO);
}

- (NSArray *)allKeys {
    return [_dict allKeys];
}

- (NSArray *)allValues {
    return [_dict allValues];
}

- (void)removeAllObjects {
    do {
        @synchronized(self) {
            if (!_cache || !_dict) {
                break;
            }
            [_dict removeAllObjects];
            [_cache removeAllObjects];
        }
    } while (NO);
}

#pragma mark - NSCacheDelegate
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    do {
        if (!obj || !cache || cache != _cache) {
            break;
        }
        
        @synchronized(self) {
            [_dict removeObjectForKey:obj];
        }
    } while (NO);
}
@end
