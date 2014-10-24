//
//  NSDictionary+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCommonConstants.h"

#ifndef DC_NSDictionary_DCSafeCRUD_DEFINE
#define DC_NSDictionary_DCSafeCRUD_DEFINE

#define DCDictionarySafeRead(dict, key, var) DCConditionalRunBlock((dict && key), {var = [dict objectForKey:key];})

#define DCDictionarySafeAllKeysForObject(dict, obj, rs) DCConditionalRunBlock((dict && obj), {rs = [dict allKeysForObject:obj];})

#endif  // DC_NSDictionary_DCSafeCRUD_DEFINE

@interface NSDictionary (DCSafeCRUD)

@end
