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
- (NSUInteger)DCH_threadSafe_count;
- (id)DCH_threadSafe_objectAtIndex:(NSUInteger)index;
- (NSUInteger)DCH_threadSafe_indexOfObject:(id)anObject;
- (id)DCH_threadSafe_firstObject NS_AVAILABLE(10_6, 4_0);
- (id)DCH_threadSafe_lastObject;
#if NS_BLOCKS_AVAILABLE
- (NSArray *)DCH_threadSafe_sortedArrayUsingComparator:(NSComparator)cmptr;
- (NSArray *)DCH_threadSafe_sortedArrayWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
#endif

- (BOOL)DCH_threadSafe_contentEqualTo:(NSArray *)otherArray;

- (void)DCH_threadSafe_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)DCH_threadSafe_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)DCH_threadSafe_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);

#pragma mark - NSMutableArray
- (void)DCH_threadSafe_addObject:(id)anObject;
- (void)DCH_threadSafe_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)DCH_threadSafe_removeLastObject;
- (void)DCH_threadSafe_removeObjectAtIndex:(NSUInteger)index;
- (void)DCH_threadSafe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)DCH_threadSafe_addObjectsFromArray:(NSArray *)otherArray;
- (void)DCH_threadSafe_removeAllObjects;
- (void)DCH_threadSafe_removeObject:(id)anObject inRange:(NSRange)range;
- (void)DCH_threadSafe_removeObject:(id)anObject;
- (void)DCH_threadSafe_removeObjectsInArray:(NSArray *)otherArray;
- (void)DCH_threadSafe_removeObjectsInRange:(NSRange)range;
#if NS_BLOCKS_AVAILABLE
- (void)DCH_threadSafe_sortUsingComparator:(NSComparator)cmptr;
- (void)DCH_threadSafe_sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
#endif

@end
