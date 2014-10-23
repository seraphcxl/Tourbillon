//
//  NSMutableString+DCSafeCRUD.h
//  Tourbillon
//
//  Created by Derek Chen on 10/23/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DC_NSMutableString_DCSafeCRUD_DEFINE
#define DC_NSMutableString_DCSafeCRUD_DEFINE
#define DCMutableSetSafeReplaceCharactersInRange(mutableString, range, anotherString) if (mutableString && anotherString && range.location <= mutableString.length && (range.location + range.length) <= mutableString.length) { [mutableString replaceCharactersInRange:range withString:anotherString]; }
#define DCMutableStringSafeInsert(mutableString, string, loc) if (mutableString && string && loc <= mutableString.length) { [mutableString insertString:string atIndex:loc]; }
#define DCMutableSetSafeDeleteInRange(mutableString, range) if (mutableString && range.length != 0 && range.location <= mutableString.length && (range.location + range.length) <= mutableString.length) { [mutableString deleteCharactersInRange:range]; }
#define DCMutableStringSafeAppend(mutableString, string) if (mutableString && string) { [mutableString appendString:string]; }
#define DCMutableStringSafeSet(mutableString, string) if (mutableString && string) { [mutableString setString:string]; }
#endif  // DC_NSMutableString_DCSafeCRUD_DEFINE

@interface NSMutableString (DCSafeCRUD)

@end
