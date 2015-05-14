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
- (NSUInteger)DCH_threadSafe_count;
- (id)DCH_threadSafe_member:(id)object;
- (NSArray *)DCH_threadSafe_allObjects;
- (BOOL)DCH_threadSafe_containsObject:(id)anObject;
- (BOOL)DCH_threadSafe_intersectsSet:(NSSet *)otherSet;
- (BOOL)DCH_threadSafe_isEqualToSet:(NSSet *)otherSet;
- (BOOL)DCH_threadSafe_isSubsetOfSet:(NSSet *)otherSet;
- (void)DCH_threadSafe_makeObjectsPerformSelector:(SEL)aSelector;
- (void)DCH_threadSafe_makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument;
- (NSSet *)DCH_threadSafe_setByAddingObject:(id)anObject NS_AVAILABLE(10_5, 2_0);
- (NSSet *)DCH_threadSafe_setByAddingObjectsFromSet:(NSSet *)other NS_AVAILABLE(10_5, 2_0);
- (NSSet *)DCH_threadSafe_setByAddingObjectsFromArray:(NSArray *)other NS_AVAILABLE(10_5, 2_0);
- (void)DCH_threadSafe_enumerateObjectsUsingBlock:(void (^)(id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)DCH_threadSafe_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);

#pragma mark - NSMutableSet
- (void)DCH_threadSafe_addObject:(id)object;
- (void)DCH_threadSafe_removeObject:(id)object;
- (void)DCH_threadSafe_addObjectsFromArray:(NSArray *)array;
- (void)DCH_threadSafe_intersectSet:(NSSet *)otherSet;
- (void)DCH_threadSafe_minusSet:(NSSet *)otherSet;
- (void)DCH_threadSafe_removeAllObjects;
- (void)DCH_threadSafe_unionSet:(NSSet *)otherSet;
- (void)DCH_threadSafe_setSet:(NSSet *)otherSet;

@end
