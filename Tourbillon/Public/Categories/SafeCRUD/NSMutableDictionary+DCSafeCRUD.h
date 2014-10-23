//
//  NSMutableDictionary+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DC_NSMutableDictionary_DCSafeCRUD_DEFINE
#define DC_NSMutableDictionary_DCSafeCRUD_DEFINE
#define DCMutableDictionarySafeRemove(mutableDictionary, key) if (mutableDictionary && key) { [mutableDictionary removeObjectForKey:key]; }
#define DCMutableDictionarySafeSet(mutableDictionary, key, value) if (mutableDictionary && key && value) { [mutableDictionary setObject:value forKey:key]; }
#endif  // DC_NSMutableDictionary_DCSafeCRUD_DEFINE

@interface NSMutableDictionary (DCSafeCRUD)

@end
