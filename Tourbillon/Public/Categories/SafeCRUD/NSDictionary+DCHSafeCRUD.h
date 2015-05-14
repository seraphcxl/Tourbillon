//
//  NSDictionary+DCHSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHCommonConstants.h"

#ifndef DCH_NSDictionary_DCHSafeCRUD_DEFINE
#define DCH_NSDictionary_DCHSafeCRUD_DEFINE

#define DCHDictionarySafeRead(dict, key, var) DCHConditionalRunBlock((dict && key), {var = [dict objectForKey:key];})

#define DCHDictionarySafeAllKeysForObject(dict, obj, rs) DCHConditionalRunBlock((dict && obj), {rs = [dict allKeysForObject:obj];})

#endif  // DCH_NSDictionary_DCHSafeCRUD_DEFINE

@interface NSDictionary (DCHSafeCRUD)

- (id)DCH_safe_objectForKey:(id)aKey;
- (NSArray *)DCH_safe_allKeysForObject:(id)anObject;

@end
