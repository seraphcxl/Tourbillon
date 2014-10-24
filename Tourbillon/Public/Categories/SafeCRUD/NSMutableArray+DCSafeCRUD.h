//
//  NSMutableArray+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCommonConstants.h"

#ifndef DC_NSMutableArray_DCSafeCRUD_DEFINE
#define DC_NSMutableArray_DCSafeCRUD_DEFINE

#define DCMutableArraySafeAdd(mAry, obj) DCConditionalRunBlock((mAry && obj), {[mAry addObject:obj];})

#define DCMutableArraySafeInsert(mAry, idx, obj) DCConditionalRunBlock((mAry && obj && idx <= mAry.count), {[mAry insertObject:obj atIndex:idx];})

#define DCMutableArraySafeRemoveIndex(mAry, idx) DCConditionalRunBlock((mAry && idx <= mAry.count), {[mAry removeObjectAtIndex:idx];})

#define DCMutableArraySafeReplace(mAry, idx, obj) DCConditionalRunBlock((mAry && obj), {[mAry replaceObjectAtIndex:idx withObject:obj];})

#define DCMutableArraySafeRemoveObjectInRange(mAry, obj, range) DCConditionalRunBlock((mAry && obj && range.length != 0 && range.location <= mAry.count && (range.location + range.length) <= mAry.count), {[mAry removeObject:obj inRange:range];})

#define DCMutableArraySafeRemoveObject(mAry, obj) DCConditionalRunBlock((mAry && obj), {[mAry removeObject:obj];})

#define DCMutableArraySafeRemoveObjectIdenticalToInRange(mAry, obj, range) DCConditionalRunBlock((mAry && obj && range.length != 0 && range.location <= mAry.count && (range.location + range.length) <= mAry.count), {[mAry removeObjectIdenticalTo:obj inRange:range];})

#define DCMutableArraySafeRemoveObjectIdenticalTo(mAry, obj) DCConditionalRunBlock((mAry && obj && idx <= mAry.count), {[mAry removeObjectIdenticalTo:obj];})

#define DCMutableArraySafeRemoveObjectsInRange(mAry, range) DCConditionalRunBlock((mAry && range.length != 0 && range.location <= mAry.count && (range.location + range.length) <= mAry.count), {[mAry removeObjectsInRange:range];})

#endif  // DC_NSMutableArray_DCSafeCRUD_DEFINE

@interface NSMutableArray (DCSafeCRUD)

@end
