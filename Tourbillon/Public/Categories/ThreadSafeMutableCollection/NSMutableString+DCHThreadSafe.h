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
- (NSUInteger)dch_threadSafe_length;
- (unichar)dch_threadSafe_characterAtIndex:(NSUInteger)index;
- (NSString *)dch_threadSafe_substringFromIndex:(NSUInteger)from;
- (NSString *)dch_threadSafe_substringToIndex:(NSUInteger)to;
- (NSString *)dch_threadSafe_substringWithRange:(NSRange)range;
- (NSComparisonResult)dch_threadSafe_compare:(NSString *)string;
- (NSComparisonResult)dch_threadSafe_caseInsensitiveCompare:(NSString *)string;
- (NSComparisonResult)dch_threadSafe_localizedCompare:(NSString *)string;
- (NSComparisonResult)dch_threadSafe_localizedCaseInsensitiveCompare:(NSString *)string;
- (BOOL)dch_threadSafe_isEqualToString:(NSString *)aString;
- (BOOL)dch_threadSafe_hasPrefix:(NSString *)aString;
- (BOOL)dch_threadSafe_hasSuffix:(NSString *)aString;
- (NSRange)dch_threadSafe_rangeOfString:(NSString *)aString;
- (NSString *)dch_threadSafe_stringByAppendingString:(NSString *)aString;
- (NSString *)dch_threadSafe_stringByAppendingFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (NSString *)dch_threadSafe_uppercaseString;
- (NSString *)dch_threadSafe_lowercaseString;
- (NSString *)dch_threadSafe_capitalizedString;
- (const char *)dch_threadSafe_UTF8String NS_RETURNS_INNER_POINTER;	// Convenience to return null-terminated UTF8 representation

#pragma mark - NSMutableString
- (void)dch_threadSafe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
- (void)dch_threadSafe_insertString:(NSString *)aString atIndex:(NSUInteger)loc;
- (void)dch_threadSafe_deleteCharactersInRange:(NSRange)range;
- (void)dch_threadSafe_appendString:(NSString *)aString;
- (void)dch_threadSafe_appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)dch_threadSafe_setString:(NSString *)aString;

@end
