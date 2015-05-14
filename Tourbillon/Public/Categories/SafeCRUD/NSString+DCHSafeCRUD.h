//
//  NSString+DCHSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHCommonConstants.h"

#ifndef DCH_NSString_DCHSafeCRUD_DEFINE
#define DCH_NSString_DCHSafeCRUD_DEFINE

#define DCHStringSafeCharacterAtIndex(src, idx, rs) DCHConditionalRunBlock((src && idx < src.length), {rs = [src characterAtIndex:idx];})

#define DCHStringSafeSubstringFromIndex(src, idx, rs) DCHConditionalRunBlock((src && idx < src.length), {rs = [src substringFromIndex:idx];})

#define DCHStringSafeSubstringToIndex(src, idx, rs) DCHConditionalRunBlock((src && idx < src.length), {rs = [src substringToIndex:idx];})

#define DCHStringSafeSubstringWithRange(src, range, rs) DCHConditionalRunBlock((src && range.location <= src.length && (range.location + range.length) <= src.length), {rs = [src substringWithRange:range];})

#define DCHStringSafeHasPrefix(src, prefix, rs) DCHConditionalRunBlock((src && prefix), {rs = [src hasPrefix:prefix];})

#define DCHStringSafeHasSuffix(src, suffix, rs) DCHConditionalRunBlock((src && suffix), {rs = [src hasSuffix:suffix];})

#define DCHStringSafeRangeOfString(src, str, rs) DCHConditionalRunBlock((src && str), {rs = [src rangeOfString:str];})

#define DCHStringSafeStringByAppendingString(src, str, rs) DCHConditionalRunBlock((src && str), {rs = [src stringByAppendingString:str];})

#endif  // DCH_NSString_DCHSafeCRUD_DEFINE

@interface NSString (DCHSafeCRUD)

- (unichar)DCH_safe_characterAtIndex:(NSUInteger)index;
- (NSString *)DCH_safe_substringFromIndex:(NSUInteger)from;
- (NSString *)DCH_safe_substringToIndex:(NSUInteger)to;
- (NSString *)DCH_safe_substringWithRange:(NSRange)range;
- (BOOL)DCH_safe_hasPrefix:(NSString *)aString;
- (BOOL)DCH_safe_hasSuffix:(NSString *)aString;
- (NSRange)DCH_safe_rangeOfString:(NSString *)aString;
- (NSString *)DCH_safe_stringByAppendingString:(NSString *)aString;

@end
