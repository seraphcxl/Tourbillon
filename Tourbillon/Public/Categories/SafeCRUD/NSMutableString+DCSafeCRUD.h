//
//  NSMutableString+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCommonConstants.h"

#ifndef DC_NSMutableString_DCSafeCRUD_DEFINE
#define DC_NSMutableString_DCSafeCRUD_DEFINE

#define DCMutableSetSafeReplaceCharactersInRange(src, range, str) DCConditionalRunBlock((src && str && range.location <= src.length && (range.location + range.length) <= src.length), {[src replaceCharactersInRange:range withString:str];})

#define DCMutableStringSafeInsert(src, str, loc) DCConditionalRunBlock((src && str && loc <= src.length), {[src insertString:str atIndex:loc];})

#define DCMutableSetSafeDeleteInRange(src, range) DCConditionalRunBlock((src && range.length != 0 && range.location <= src.length && (range.location + range.length) <= src.length), {[src deleteCharactersInRange:range];})

#define DCMutableStringSafeAppend(src, str) DCConditionalRunBlock((src && str), {[src appendString:str];})

#define DCMutableStringSafeSet(src, str) DCConditionalRunBlock((src && str), {[src setString:str];})

#endif  // DC_NSMutableString_DCSafeCRUD_DEFINE

@interface NSMutableString (DCSafeCRUD)

@end
