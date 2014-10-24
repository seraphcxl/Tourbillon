//
//  NSMutableDictionary+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCommonConstants.h"

#ifndef DC_NSMutableDictionary_DCSafeCRUD_DEFINE
#define DC_NSMutableDictionary_DCSafeCRUD_DEFINE

#define DCMutableDictionarySafeRemove(mDict, key) DCConditionalRunBlock((mDict && key), {[mDict removeObjectForKey:key];})

#define DCMutableDictionarySafeSet(mDict, key, var) DCConditionalRunBlock((mDict && key && var), {[mDict setObject:var forKey:key];})

#endif  // DC_NSMutableDictionary_DCSafeCRUD_DEFINE

@interface NSMutableDictionary (DCSafeCRUD)

@end
