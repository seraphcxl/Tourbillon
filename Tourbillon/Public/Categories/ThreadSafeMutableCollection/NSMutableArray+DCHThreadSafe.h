//
//  NSMutableArray+DCHThreadSafe.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (DCHThreadSafe)

#pragma mark - NSArray
- (NSUInteger)threadSafe_count;
- (id)threadSafe_objectAtIndex:(NSUInteger)index;
- (NSUInteger)threadSafe_indexOfObject:(id)anObject;
- (id)threadSafe_firstObject NS_AVAILABLE(10_6, 4_0);
- (id)threadSafe_lastObject;
#if NS_BLOCKS_AVAILABLE
- (NSArray *)threadSafe_sortedArrayUsingComparator:(NSComparator)cmptr;
- (NSArray *)threadSafe_sortedArrayWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
#endif

- (BOOL)threadSafe_contentEqualTo:(NSArray *)otherArray;

#pragma mark - NSMutableArray
- (void)threadSafe_addObject:(id)anObject;
- (void)threadSafe_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)threadSafe_removeLastObject;
- (void)threadSafe_removeObjectAtIndex:(NSUInteger)index;
- (void)threadSafe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)threadSafe_addObjectsFromArray:(NSArray *)otherArray;
- (void)threadSafe_removeAllObjects;
- (void)threadSafe_removeObject:(id)anObject inRange:(NSRange)range;
- (void)threadSafe_removeObject:(id)anObject;
- (void)threadSafe_removeObjectsInArray:(NSArray *)otherArray;
- (void)threadSafe_removeObjectsInRange:(NSRange)range;
#if NS_BLOCKS_AVAILABLE
- (void)threadSafe_sortUsingComparator:(NSComparator)cmptr;
- (void)threadSafe_sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
#endif

@end
