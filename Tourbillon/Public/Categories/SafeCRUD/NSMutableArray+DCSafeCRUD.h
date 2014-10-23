//
//  NSMutableArray+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

//- (void)removeObject:(id)anObject inRange:(NSRange)range;
//- (void)removeObject:(id)anObject;
//- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
//- (void)removeObjectIdenticalTo:(id)anObject;
//- (void)removeObjectsInRange:(NSRange)range;

#ifndef DC_NSMutableArray_DCSafeCRUD_DEFINE
#define DC_NSMutableArray_DCSafeCRUD_DEFINE
#define DCMutableArraySafeAdd(mutableArray, object) if (mutableArray && object) { [mutableArray addObject:object]; }
#define DCMutableArraySafeInsert(mutableArray, index, object) if (mutableArray && object && index <= mutableArray.count) { [mutableArray insertObject:object atIndex:index]; }
#define DCMutableArraySafeRemoveIndex(mutableArray, index) if (mutableArray && index < mutableArray.count) { [mutableArray removeObjectAtIndex:index]; }
#define DCMutableArraySafeReplace(mutableArray, index, object) if (mutableArray && object && index < mutableArray.count) { [mutableArray replaceObjectAtIndex:index withObject:object]; }
#define DCMutableArraySafeRemoveObjectInRange(mutableArray, object, range) if (mutableArray && object && range.length != 0 && range.location <= mutableArray.count && (range.location + range.length) <= mutableArray.count) { [mutableArray removeObject:object inRange:range]; }
#define DCMutableArraySafeRemoveObject(mutableArray, object) if (mutableArray && object) { [mutableArray removeObject:object]; }
#define DCMutableArraySafeRemoveObjectIdenticalToInRange(mutableArray, object, range) if (mutableArray && object && range.length != 0 && range.location <= mutableArray.count && (range.location + range.length) <= mutableArray.count) { [mutableArray removeObjectIdenticalTo:object inRange:range]; }
#define DCMutableArraySafeRemoveObjectIdenticalTo(mutableArray, object) if (mutableArray && object) { [mutableArray removeObjectIdenticalTo:object]; }
#define DCMutableArraySafeRemoveObjectsInRange(mutableArray, range) if (mutableArray && range.length != 0 && range.location <= mutableArray.count && (range.location + range.length) <= mutableArray.count) { [mutableArray removeObjectsInRange:range]; }
#endif  // DC_NSMutableArray_DCSafeCRUD_DEFINE

@interface NSMutableArray (DCSafeCRUD)

@end
