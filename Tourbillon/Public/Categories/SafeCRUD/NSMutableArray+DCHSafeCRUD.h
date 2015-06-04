//
//  NSMutableArray+DCHSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHCommonConstants.h"

#ifndef DCH_NSMutableArray_DCHSafeCRUD_DEFINE
#define DCH_NSMutableArray_DCHSafeCRUD_DEFINE

#define DCHMutableArraySafeAdd(mAry, obj) DCHConditionalRunBlock((mAry && obj), {[mAry addObject:obj];})

#define DCHMutableArraySafeInsert(mAry, idx, obj) DCHConditionalRunBlock((mAry && obj && idx <= mAry.count), {[mAry insertObject:obj atIndex:idx];})

#define DCHMutableArraySafeRemoveIndex(mAry, idx) DCHConditionalRunBlock((mAry && idx <= mAry.count), {[mAry removeObjectAtIndex:idx];})

#define DCHMutableArraySafeReplace(mAry, idx, obj) DCHConditionalRunBlock((mAry && obj), {[mAry replaceObjectAtIndex:idx withObject:obj];})

#define DCHMutableArraySafeRemoveObjectInRange(mAry, obj, range) DCHConditionalRunBlock((mAry && obj && range.length != 0 && range.location <= mAry.count && (range.location + range.length) <= mAry.count), {[mAry removeObject:obj inRange:range];})

#define DCHMutableArraySafeRemoveObject(mAry, obj) DCHConditionalRunBlock((mAry && obj), {[mAry removeObject:obj];})

#define DCHMutableArraySafeRemoveObjectIdenticalToInRange(mAry, obj, range) DCHConditionalRunBlock((mAry && obj && range.length != 0 && range.location <= mAry.count && (range.location + range.length) <= mAry.count), {[mAry removeObjectIdenticalTo:obj inRange:range];})

#define DCHMutableArraySafeRemoveObjectIdenticalTo(mAry, obj) DCHConditionalRunBlock((mAry && obj && idx <= mAry.count), {[mAry removeObjectIdenticalTo:obj];})

#define DCHMutableArraySafeRemoveObjectsInRange(mAry, range) DCHConditionalRunBlock((mAry && range.length != 0 && range.location <= mAry.count && (range.location + range.length) <= mAry.count), {[mAry removeObjectsInRange:range];})

#endif  // DCH_NSMutableArray_DCHSafeCRUD_DEFINE

@interface NSMutableArray (DCHSafeCRUD)

- (void)dch_safe_addObject:(id)anObject;
- (void)dch_safe_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)dch_safe_removeObjectAtIndex:(NSUInteger)index;
- (void)dch_safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)dch_safe_removeObject:(id)anObject inRange:(NSRange)range;
- (void)dch_safe_removeObject:(id)anObject;
- (void)dch_safe_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (void)dch_safe_removeObjectIdenticalTo:(id)anObject;
- (void)dch_safe_removeObjectsInRange:(NSRange)range;

@end
