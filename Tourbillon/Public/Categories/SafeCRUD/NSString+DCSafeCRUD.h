//
//  NSString+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DC_NSString_DCSafeCRUD_DEFINE
#define DC_NSString_DCSafeCRUD_DEFINE
#define DCStringSafeCharacterAtIndex(string, index, result) if (string && index < string.length) { result = [string characterAtIndex:index]; }
#define DCStringSafeSubstringFromIndex(string, index, result) if (string && index < string.length) { result = [string substringFromIndex:index]; }
#define DCStringSafeSubstringToIndex(string, index, result) if (string && index < string.length) { result = [string substringToIndex:index]; }
#define DCStringSafeSubstringWithRange(string, range, result) if (string && range.location <= string.length && (range.location + range.length) <= string.length) { result = [string substringWithRange:range]; }
#define DCStringSafeHasPrefix(string, prefix, result) if (string && prefix) { result = [string hasPrefix:prefix]; }
#define DCStringSafeHasSuffix(string, suffix, result) if (string && suffix) { result = [string hasSuffix:suffix]; }
#define DCStringSafeRangeOfString(string, paramString, result) if (string && paramString) { result = [string rangeOfString:paramString]; }
#define DCStringSafeStringByAppendingString(string, anotherString, result) if (string && anotherString) { result = [string stringByAppendingString:anotherString]; }
#endif  // DC_NSString_DCSafeCRUD_DEFINE

@interface NSString (DCSafeCRUD)

@end
