//
//  NSMutableSet+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCommonConstants.h"

#ifndef DC_NSMutableSet_DCSafeCRUD_DEFINE
#define DC_NSMutableSet_DCSafeCRUD_DEFINE

#define DCMutableSetSafeAdd(mSet, obj) DCConditionalRunBlock((mSet && obj), {[mSet addObject:obj];})

#define DCMutableSetSafeRemove(mSet, obj) DCConditionalRunBlock((mSet && obj), {[mSet removeObject:obj];})

#endif  // DC_NSMutableSet_DCSafeCRUD_DEFINE

@interface NSMutableSet (DCSafeCRUD)

@end
