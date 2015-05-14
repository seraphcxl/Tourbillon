//
//  NSMutableString+DCHThreadSafe.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DCHThreadSafe.h"

@interface NSMutableString (DCHThreadSafe)

#pragma mark - NSString
- (NSUInteger)DCH_threadSafe_length;
- (unichar)DCH_threadSafe_characterAtIndex:(NSUInteger)index;
- (NSString *)DCH_threadSafe_substringFromIndex:(NSUInteger)from;
- (NSString *)DCH_threadSafe_substringToIndex:(NSUInteger)to;
- (NSString *)DCH_threadSafe_substringWithRange:(NSRange)range;
- (NSComparisonResult)DCH_threadSafe_compare:(NSString *)string;
- (NSComparisonResult)DCH_threadSafe_caseInsensitiveCompare:(NSString *)string;
- (NSComparisonResult)DCH_threadSafe_localizedCompare:(NSString *)string;
- (NSComparisonResult)DCH_threadSafe_localizedCaseInsensitiveCompare:(NSString *)string;
- (BOOL)DCH_threadSafe_isEqualToString:(NSString *)aString;
- (BOOL)DCH_threadSafe_hasPrefix:(NSString *)aString;
- (BOOL)DCH_threadSafe_hasSuffix:(NSString *)aString;
- (NSRange)DCH_threadSafe_rangeOfString:(NSString *)aString;
- (NSString *)DCH_threadSafe_stringByAppendingString:(NSString *)aString;
- (NSString *)DCH_threadSafe_stringByAppendingFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (NSString *)DCH_threadSafe_uppercaseString;
- (NSString *)DCH_threadSafe_lowercaseString;
- (NSString *)DCH_threadSafe_capitalizedString;
- (const char *)DCH_threadSafe_UTF8String NS_RETURNS_INNER_POINTER;	// Convenience to return null-terminated UTF8 representation

#pragma mark - NSMutableString
- (void)DCH_threadSafe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
- (void)DCH_threadSafe_insertString:(NSString *)aString atIndex:(NSUInteger)loc;
- (void)DCH_threadSafe_deleteCharactersInRange:(NSRange)range;
- (void)DCH_threadSafe_appendString:(NSString *)aString;
- (void)DCH_threadSafe_appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)DCH_threadSafe_setString:(NSString *)aString;

@end
