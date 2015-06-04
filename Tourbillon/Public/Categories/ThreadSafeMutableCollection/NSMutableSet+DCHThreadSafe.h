//
//  NSMutableSet+DCHThreadSafe.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DCHThreadSafe.h"

@interface NSMutableSet (DCHThreadSafe)

#pragma mark - NSSet
- (NSUInteger)dch_threadSafe_count;
- (id)dch_threadSafe_member:(id)object;
- (NSArray *)dch_threadSafe_allObjects;
- (BOOL)dch_threadSafe_containsObject:(id)anObject;
- (BOOL)dch_threadSafe_intersectsSet:(NSSet *)otherSet;
- (BOOL)dch_threadSafe_isEqualToSet:(NSSet *)otherSet;
- (BOOL)dch_threadSafe_isSubsetOfSet:(NSSet *)otherSet;
- (void)dch_threadSafe_makeObjectsPerformSelector:(SEL)aSelector;
- (void)dch_threadSafe_makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument;
- (NSSet *)dch_threadSafe_setByAddingObject:(id)anObject NS_AVAILABLE(10_5, 2_0);
- (NSSet *)dch_threadSafe_setByAddingObjectsFromSet:(NSSet *)other NS_AVAILABLE(10_5, 2_0);
- (NSSet *)dch_threadSafe_setByAddingObjectsFromArray:(NSArray *)other NS_AVAILABLE(10_5, 2_0);
- (void)dch_threadSafe_enumerateObjectsUsingBlock:(void (^)(id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)dch_threadSafe_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);

#pragma mark - NSMutableSet
- (void)dch_threadSafe_addObject:(id)object;
- (void)dch_threadSafe_removeObject:(id)object;
- (void)dch_threadSafe_addObjectsFromArray:(NSArray *)array;
- (void)dch_threadSafe_intersectSet:(NSSet *)otherSet;
- (void)dch_threadSafe_minusSet:(NSSet *)otherSet;
- (void)dch_threadSafe_removeAllObjects;
- (void)dch_threadSafe_unionSet:(NSSet *)otherSet;
- (void)dch_threadSafe_setSet:(NSSet *)otherSet;

@end
