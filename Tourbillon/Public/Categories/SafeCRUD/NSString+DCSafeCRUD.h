//
//  NSString+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCommonConstants.h"

#ifndef DC_NSString_DCSafeCRUD_DEFINE
#define DC_NSString_DCSafeCRUD_DEFINE

#define DCStringSafeCharacterAtIndex(src, idx, rs) DCConditionalRunBlock((src && idx < src.length), {rs = [src characterAtIndex:idx];})

#define DCStringSafeSubstringFromIndex(src, idx, rs) DCConditionalRunBlock((src && idx < src.length), {rs = [src substringFromIndex:idx];})

#define DCStringSafeSubstringToIndex(src, idx, rs) DCConditionalRunBlock((src && idx < src.length), {rs = [src substringToIndex:idx];})

#define DCStringSafeSubstringWithRange(src, range, rs) DCConditionalRunBlock((src && range.location <= src.length && (range.location + range.length) <= src.length), {rs = [src substringWithRange:range];})

#define DCStringSafeHasPrefix(src, prefix, rs) DCConditionalRunBlock((src && prefix), {rs = [src hasPrefix:prefix];})

#define DCStringSafeHasSuffix(src, suffix, rs) DCConditionalRunBlock((src && suffix), {rs = [src hasSuffix:suffix];})

#define DCStringSafeRangeOfString(src, str, rs) DCConditionalRunBlock((src && str), {rs = [src rangeOfString:str];})

#define DCStringSafeStringByAppendingString(src, str, rs) DCConditionalRunBlock((src && str), {rs = [src stringByAppendingString:str];})

#endif  // DC_NSString_DCSafeCRUD_DEFINE

@interface NSString (DCSafeCRUD)

@end
