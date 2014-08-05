//
//  NSDictionary+DCSortable.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "NSDictionary+DCSortable.h"

@implementation NSDictionary (DCSortable)

- (NSArray *)sortedKeysUsingComparator:(NSComparator)comparator {
    NSArray *result = nil;
    do {
        if (!comparator) {
            break;
        }
        
        @synchronized(self) {
            result = [self.allKeys sortedArrayUsingComparator:comparator];
        }
    } while (NO);
    return result;
}

- (NSArray *)sortedValuesUsingKeyComparator:(NSComparator)comparator {
    NSMutableArray *result = nil;
    do {
        if (!comparator) {
            break;
        }
        
        @synchronized(self) {
            result = [NSMutableArray array];
            [self enumerateSortedKeysAndObjectsUsingComparator:comparator usingBlock:^(id key, id value, BOOL *stop) {
                [result addObject:value];
            }];
        }
    } while (NO);
    return result;
}

- (void)enumerateSortedKeysAndObjectsUsingComparator:(NSComparator)comparator usingBlock:(void (^)(id key, id value, BOOL *stop))block {
    do {
        if (!comparator || !block) {
            break;
        }
        @synchronized(self) {
            NSArray *sortedKeys = [self sortedKeysUsingComparator:comparator];
            [sortedKeys enumerateObjectsUsingBlock:^(id key, NSUInteger idx, BOOL *stop) {
                id value = [self objectForKey:key];
                block(key, value, stop);
            }];
        }
    } while (NO);
}

@end
