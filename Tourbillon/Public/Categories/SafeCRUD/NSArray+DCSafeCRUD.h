//
//  NSArray+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DC_NSArray_DCSafeCRUD_DEFINE
#define DC_NSArray_DCSafeCRUD_DEFINE
#define DCArraySafeRead(array, index, result) if (array && index < array.count) { result = [array objectAtIndex:index]; }
#define DCArraySafeIndexOfObject(array, object, result) if (array && object) { result = [array indexOfObject:object]; }
#define DCArraySafeIndexOfObjectInRange(array, object, range, result) if (array && object && range.length != 0 && range.location <= array.count && (range.location + range.length) <= array.count) { result = [array indexOfObject:object inRange:range]; }
#define DCArraySafeIndexOfObjectIdenticalTo(array, object, result) if (array && object) { result = [array indexOfObjectIdenticalTo:object]; }
#define DCArraySafeIndexOfObjectIdenticalToInRange(array, object, range, result) if (array && object && range.length != 0 && range.location <= array.count && (range.location + range.length) <= array.count) { result = [array indexOfObjectIdenticalTo:object inRange:range]; }
#endif  // DC_NSArray_DCSafeCRUD_DEFINE

@interface NSArray (DCSafeCRUD)

@end
