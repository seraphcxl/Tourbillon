//
//  NSArray+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCommonConstants.h"

#ifndef DC_NSArray_DCSafeCRUD_DEFINE
#define DC_NSArray_DCSafeCRUD_DEFINE

#define DCArraySafeRead(ary, idx, rs) DCConditionalRunBlock((ary && idx < ary.count), {rs = [ary objectAtIndex:idx];})

#define DCArraySafeIndexOfObject(ary, obj, rs) DCConditionalRunBlock((ary && obj), {rs = [ary indexOfObject:obj];})

#define DCArraySafeIndexOfObjectInRange(ary, obj, range, rs) DCConditionalRunBlock((ary && obj && range.length != 0 && range.location <= ary.count && (range.location + range.length) <= ary.count), {rs = [ary indexOfObject:obj inRange:range];})

#define DCArraySafeIndexOfObjectIdenticalTo(ary, obj, rs) DCConditionalRunBlock((ary && obj), {rs = [ary indexOfObjectIdenticalTo:obj];})

#define DCArraySafeIndexOfObjectIdenticalToInRange(ary, obj, range, rs) DCConditionalRunBlock((ary && obj && range.length != 0 && range.location <= ary.count && (range.location + range.length) <= ary.count), {rs = [ary indexOfObjectIdenticalTo:obj inRange:range];})

#endif  // DC_NSArray_DCSafeCRUD_DEFINE

@interface NSArray (DCSafeCRUD)

@end
