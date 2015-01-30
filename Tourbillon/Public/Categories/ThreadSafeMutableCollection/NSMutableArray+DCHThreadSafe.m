//
//  NSMutableArray+DCHThreadSafe.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSMutableArray+DCHThreadSafe.h"
#import "NSObject+DCHThreadSafe.h"
#import "NSArray+DCHSafeCRUD.h"
#import "NSMutableArray+DCHSafeCRUD.h"

@implementation NSMutableArray (DCHThreadSafe)

#pragma mark - NSArray
- (NSUInteger)threadSafe_count {
    __block NSUInteger result = 0;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self count];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (id)threadSafe_objectAtIndex:(NSUInteger)index {
    __block id result = nil;
    do {
        if (index >= [self threadSafe_count]) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            DCHArraySafeRead(self, index, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSUInteger)threadSafe_indexOfObject:(id)anObject {
    __block NSUInteger result = 0;
    do {
        if (!anObject) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            DCHArraySafeIndexOfObject(self, anObject, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (id)threadSafe_firstObject {
    __block id result = nil;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self firstObject];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (id)threadSafe_lastObject {
    __block id result = nil;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self lastObject];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

#if NS_BLOCKS_AVAILABLE
- (NSArray *)threadSafe_sortedArrayUsingComparator:(NSComparator)cmptr {
    __block NSArray *result = nil;
    do {
        if (!cmptr) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self sortedArrayUsingComparator:cmptr];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSArray *)threadSafe_sortedArrayWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr {
    __block NSArray *result = nil;
    do {
        if (!cmptr) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self sortedArrayWithOptions:opts usingComparator:cmptr];
        }]) {
            break;
        }
    } while (NO);
    return result;
}
#endif

- (BOOL)threadSafe_contentEqualTo:(NSArray *)otherArray {
    __block BOOL result = NO;
    do {
        if (!otherArray) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            do {
                if (self.count != otherArray.count) {
                    break;
                }
                BOOL notFound = NO;
                for (id obj in otherArray) {
                    if ([self indexOfObject:obj] == NSNotFound) {
                        notFound = YES;
                        break;
                    }
                }
                if (!notFound) {
                    result = YES;
                }
            } while (NO);
        }]) {
            break;
        }
        
    } while (NO);
    return result;
}

#pragma mark - NSMutableArray
- (void)threadSafe_addObject:(id)anObject {
    do {
        if (!anObject) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableArraySafeAdd(self, anObject);
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    do {
        if (!anObject || index > [self threadSafe_count]) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableArraySafeInsert(self, index, anObject);
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeLastObject {
    do {
        if (![self threafSafe_Setting:^{
            [self removeLastObject];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObjectAtIndex:(NSUInteger)index {
    do {
        if (index >= [self threadSafe_count]) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableArraySafeRemoveIndex(self, index);
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    do {
        if (!anObject || index >= [self threadSafe_count]) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableArraySafeReplace(self, index, anObject);
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_addObjectsFromArray:(NSArray *)otherArray {
    do {
        if (!otherArray || [otherArray count] == 0) {
            break;
        }
        if (![self threafSafe_Setting:^{
            [self addObjectsFromArray:otherArray];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeAllObjects {
    do {
        if (![self threafSafe_Setting:^{
            [self removeAllObjects];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObject:(id)anObject inRange:(NSRange)range {
    do {
        if (!anObject) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableArraySafeRemoveObjectInRange(self, anObject, range);
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObject:(id)anObject {
    do {
        if (!anObject) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableArraySafeRemoveObject(self, anObject);
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObjectsInArray:(NSArray *)otherArray {
    do {
        if (!otherArray || [otherArray count] == 0) {
            break;
        }
        if (![self threafSafe_Setting:^{
            [self removeObjectsInArray:otherArray];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObjectsInRange:(NSRange)range {
    do {
        if (![self threafSafe_Setting:^{
            DCHMutableArraySafeRemoveObjectsInRange(self, range);
        }]) {
            break;
        }
    } while (NO);
}

#if NS_BLOCKS_AVAILABLE
- (void)threadSafe_sortUsingComparator:(NSComparator)cmptr {
    do {
        if (!cmptr) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            [self sortUsingComparator:cmptr];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr {
    do {
        if (!cmptr) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            [self sortedArrayWithOptions:opts usingComparator:cmptr];
        }]) {
            break;
        }
    } while (NO);
}
#endif

@end
