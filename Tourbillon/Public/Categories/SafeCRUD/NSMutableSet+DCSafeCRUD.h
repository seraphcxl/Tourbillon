//
//  NSMutableSet+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DC_NSMutableSet_DCSafeCRUD_DEFINE
#define DC_NSMutableSet_DCSafeCRUD_DEFINE
#define DCMutableSetSafeAdd(mutableSet, object) if (mutableSet && object) { [mutableSet addObject:object]; }
#define DCMutableSetSafeRemove(mutableSet, object) if (mutableSet && object) { [mutableSet removeObject:object]; }
#endif  // DC_NSMutableSet_DCSafeCRUD_DEFINE

@interface NSMutableSet (DCSafeCRUD)

@end
