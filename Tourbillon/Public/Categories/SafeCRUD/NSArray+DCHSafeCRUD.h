//
//  NSArray+DCHSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHCommonConstants.h"

#ifndef DCH_NSArray_DCHSafeCRUD_DEFINE
#define DCH_NSArray_DCHSafeCRUD_DEFINE

#define DCHArraySafeRead(ary, idx, rs) DCHConditionalRunBlock((ary && idx < ary.count), {rs = [ary objectAtIndex:idx];})

#define DCHArraySafeIndexOfObject(ary, obj, rs) DCHConditionalRunBlock((ary && obj), {rs = [ary indexOfObject:obj];})

#define DCHArraySafeIndexOfObjectInRange(ary, obj, range, rs) DCHConditionalRunBlock((ary && obj && range.length != 0 && range.location <= ary.count && (range.location + range.length) <= ary.count), {rs = [ary indexOfObject:obj inRange:range];})

#define DCHArraySafeIndexOfObjectIdenticalTo(ary, obj, rs) DCHConditionalRunBlock((ary && obj), {rs = [ary indexOfObjectIdenticalTo:obj];})

#define DCHArraySafeIndexOfObjectIdenticalToInRange(ary, obj, range, rs) DCHConditionalRunBlock((ary && obj && range.length != 0 && range.location <= ary.count && (range.location + range.length) <= ary.count), {rs = [ary indexOfObjectIdenticalTo:obj inRange:range];})

#endif  // DCH_NSArray_DCHSafeCRUD_DEFINE

@interface NSArray (DCHSafeCRUD)

- (id)DCH_safe_objectAtIndex:(NSUInteger)index;
- (NSUInteger)DCH_safe_indexOfObject:(id)anObject;
- (NSUInteger)DCH_safe_indexOfObject:(id)anObject inRange:(NSRange)range;
- (NSUInteger)DCH_safe_indexOfObjectIdenticalTo:(id)anObject;
- (NSUInteger)DCH_safe_indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range;

@end
