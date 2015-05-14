//
//  NSMutableDictionary+DCHSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHCommonConstants.h"

#ifndef DCH_NSMutableDictionary_DCHSafeCRUD_DEFINE
#define DCH_NSMutableDictionary_DCHSafeCRUD_DEFINE

#define DCHMutableDictionarySafeRemove(mDict, key) DCHConditionalRunBlock((mDict && key), {[mDict removeObjectForKey:key];})

#define DCHMutableDictionarySafeSet(mDict, key, var) DCHConditionalRunBlock((mDict && key && var), {[mDict setObject:var forKey:key];})

#endif  // DCH_NSMutableDictionary_DCHSafeCRUD_DEFINE

@interface NSMutableDictionary (DCHSafeCRUD)

- (void)DCH_safe_removeObjectForKey:(id)aKey;
- (void)DCH_safe_setObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end
