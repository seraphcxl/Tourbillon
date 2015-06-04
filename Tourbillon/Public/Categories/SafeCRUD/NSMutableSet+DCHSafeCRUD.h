//
//  NSMutableSet+DCHSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHCommonConstants.h"

#ifndef DCH_NSMutableSet_DCHSafeCRUD_DEFINE
#define DCH_NSMutableSet_DCHSafeCRUD_DEFINE

#define DCHMutableSetSafeAdd(mSet, obj) DCHConditionalRunBlock((mSet && obj), {[mSet addObject:obj];})

#define DCHMutableSetSafeRemove(mSet, obj) DCHConditionalRunBlock((mSet && obj), {[mSet removeObject:obj];})

#endif  // DCH_NSMutableSet_DCHSafeCRUD_DEFINE

@interface NSMutableSet (DCHSafeCRUD)

- (void)dch_safe_addObject:(id)object;
- (void)dch_safe_removeObject:(id)object;

@end
