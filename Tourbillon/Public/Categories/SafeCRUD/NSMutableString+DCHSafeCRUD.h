//
//  NSMutableString+DCHSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHCommonConstants.h"

#ifndef DCH_NSMutableString_DCHSafeCRUD_DEFINE
#define DCH_NSMutableString_DCHSafeCRUD_DEFINE

#define DCHMutableStringSafeReplaceCharactersInRange(src, range, str) DCHConditionalRunBlock((src && str && range.location <= src.length && (range.location + range.length) <= src.length), {[src replaceCharactersInRange:range withString:str];})

#define DCHMutableStringSafeInsert(src, str, loc) DCHConditionalRunBlock((src && str && loc <= src.length), {[src insertString:str atIndex:loc];})

#define DCHMutableSetSafeDeleteInRange(src, range) DCHConditionalRunBlock((src && range.length != 0 && range.location <= src.length && (range.location + range.length) <= src.length), {[src deleteCharactersInRange:range];})

#define DCHMutableStringSafeAppend(src, str) DCHConditionalRunBlock((src && str), {[src appendString:str];})

#define DCHMutableStringSafeSet(src, str) DCHConditionalRunBlock((src && str), {[src setString:str];})

#endif  // DCH_NSMutableString_DCHSafeCRUD_DEFINE

@interface NSMutableString (DCHSafeCRUD)

- (void)DCH_safe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
- (void)DCH_safe_insertString:(NSString *)aString atIndex:(NSUInteger)loc;
- (void)DCH_safe_deleteCharactersInRange:(NSRange)range;
- (void)DCH_safe_appendString:(NSString *)aString;
- (void)DCH_safe_setString:(NSString *)aString;

@end
