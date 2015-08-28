//
//  NSMutableArray+DCHThreadSafe.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DCHThreadSafe.h"

@interface NSMutableArray (DCHThreadSafe)

#pragma mark - NSArray
- (NSUInteger)dch_threadSafe_count;
- (id)dch_threadSafe_objectAtIndex:(NSUInteger)index;
- (NSUInteger)dch_threadSafe_indexOfObject:(id)anObject;
- (id)dch_threadSafe_firstObject NS_AVAILABLE(10_6, 4_0);
- (id)dch_threadSafe_lastObject;
#if NS_BLOCKS_AVAILABLE
- (NSArray *)dch_threadSafe_sortedArrayUsingComparator:(NSComparator)cmptr;
- (NSArray *)dch_threadSafe_sortedArrayWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
#endif

- (BOOL)dch_threadSafe_contentEqualTo:(NSArray *)otherArray;

- (void)dch_threadSafe_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)dch_threadSafe_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)dch_threadSafe_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);

#pragma mark - NSMutableArray
- (void)dch_threadSafe_addObject:(id)anObject;
- (void)dch_threadSafe_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)dch_threadSafe_removeLastObject;
- (void)dch_threadSafe_removeObjectAtIndex:(NSUInteger)index;
- (void)dch_threadSafe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)dch_threadSafe_addObjectsFromArray:(NSArray *)otherArray;
- (void)dch_threadSafe_removeAllObjects;
- (void)dch_threadSafe_removeObject:(id)anObject inRange:(NSRange)range;
- (void)dch_threadSafe_removeObject:(id)anObject;
- (void)dch_threadSafe_removeObjectsInArray:(NSArray *)otherArray;
- (void)dch_threadSafe_removeObjectsInRange:(NSRange)range;
#if NS_BLOCKS_AVAILABLE
- (void)dch_threadSafe_sortUsingComparator:(NSComparator)cmptr;
- (void)dch_threadSafe_sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
#endif

@end
