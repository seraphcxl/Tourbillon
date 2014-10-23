//
//  NSDictionary+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DC_NSDictionary_DCSafeCRUD_DEFINE
#define DC_NSDictionary_DCSafeCRUD_DEFINE
#define DCDictionarySafeRead(dictionary, key, value) if (dictionary && key) { value = [dictionary objectForKey:key]; }
#define DCDictionarySafeAllKeysForObject(dictionary, object, result) if (dictionary && object) { result = [dictionary allKeysForObject:object]; }
#endif  // DC_NSDictionary_DCSafeCRUD_DEFINE

@interface NSDictionary (DCSafeCRUD)

@end
