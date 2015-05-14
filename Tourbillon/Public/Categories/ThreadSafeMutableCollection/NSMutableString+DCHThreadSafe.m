//
//  NSMutableString+DCHThreadSafe.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSMutableString+DCHThreadSafe.h"
#import "NSString+DCHSafeCRUD.h"
#import "NSMutableString+DCHSafeCRUD.h"

@implementation NSMutableString (DCHThreadSafe)

#pragma mark NSString
- (NSUInteger)DCH_threadSafe_length {
    __block NSUInteger result = 0;
    do {
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self length];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (unichar)DCH_threadSafe_characterAtIndex:(NSUInteger)index {
    __block unichar result = 0;
    do {
        if (index >= [self DCH_threadSafe_length]) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            DCHStringSafeCharacterAtIndex(self, index, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_threadSafe_substringFromIndex:(NSUInteger)from {
    __block NSString *result = nil;
    do {
        if (from >= [self DCH_threadSafe_length]) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            DCHStringSafeSubstringFromIndex(self, from, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_threadSafe_substringToIndex:(NSUInteger)to {
    __block NSString *result = nil;
    do {
        if (to >= [self DCH_threadSafe_length]) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            DCHStringSafeSubstringToIndex(self, to, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_threadSafe_substringWithRange:(NSRange)range {
    __block NSString *result = nil;
    do {
        if (range.length == 0) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            DCHStringSafeSubstringWithRange(self, range, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSComparisonResult)DCH_threadSafe_compare:(NSString *)string {
    __block NSComparisonResult result = NSOrderedSame;
    do {
        if (!string) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self compare:string];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSComparisonResult)DCH_threadSafe_caseInsensitiveCompare:(NSString *)string {
    __block NSComparisonResult result = NSOrderedSame;
    do {
        if (!string) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self caseInsensitiveCompare:string];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSComparisonResult)DCH_threadSafe_localizedCompare:(NSString *)string {
    __block NSComparisonResult result = NSOrderedSame;
    do {
        if (!string) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self localizedCompare:string];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSComparisonResult)DCH_threadSafe_localizedCaseInsensitiveCompare:(NSString *)string {
    __block NSComparisonResult result = NSOrderedSame;
    do {
        if (!string) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self localizedCaseInsensitiveCompare:string];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)DCH_threadSafe_isEqualToString:(NSString *)aString {
    __block BOOL result = NO;
    do {
        if (!aString) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self isEqualToString:aString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)DCH_threadSafe_hasPrefix:(NSString *)aString {
    __block BOOL result = NO;
    do {
        if (!aString) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            DCHStringSafeHasPrefix(self, aString, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)DCH_threadSafe_hasSuffix:(NSString *)aString {
    __block BOOL result = NO;
    do {
        if (!aString) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            DCHStringSafeHasSuffix(self, aString, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSRange)DCH_threadSafe_rangeOfString:(NSString *)aString {
    __block NSRange result = NSMakeRange(0, 0);
    do {
        if (!aString) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            DCHStringSafeRangeOfString(self, aString, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_threadSafe_stringByAppendingString:(NSString *)aString {
    __block NSString *result = [self copy];
    do {
        if (!aString) {
            break;
        }
        if (![self DCH_threadSafe_QueueSync:^{
            DCHStringSafeStringByAppendingString(self, aString, result);
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_threadSafe_stringByAppendingFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) {
    __block NSString *result = [self copy];
    do {
        if (!format) {
            break;
        }
        va_list arglist;
        va_start(arglist, format);
        NSString *statement = [[NSString alloc] initWithFormat:format arguments:arglist];
        va_end(arglist);
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self stringByAppendingString:statement];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_threadSafe_uppercaseString {
    __block NSString *result = [self copy];
    do {
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self uppercaseString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_threadSafe_lowercaseString {
    __block NSString *result = [self copy];
    do {
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self lowercaseString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_threadSafe_capitalizedString {
    __block NSString *result = [self copy];
    do {
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self capitalizedString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (const char *)DCH_threadSafe_UTF8String {
    __block const char *result = nil;
    do {
        if (![self DCH_threadSafe_QueueSync:^{
            result = [self UTF8String];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

#pragma mark NSMutableString
- (void)DCH_threadSafe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    do {
        if (range.length == 0 || !aString) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableStringSafeReplaceCharactersInRange(self, range, aString);
        }]) {
            break;
        }
    } while (NO);
}

- (void)DCH_threadSafe_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    do {
        if (!aString || loc > [self DCH_threadSafe_length]) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableStringSafeInsert(self, aString, loc);
        }]) {
            break;
        }
    } while (NO);
}

- (void)DCH_threadSafe_deleteCharactersInRange:(NSRange)range {
    do {
        if (range.length == 0) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableSetSafeDeleteInRange(self, range);
        }]) {
            break;
        }
    } while (NO);
}

- (void)DCH_threadSafe_appendString:(NSString *)aString {
    do {
        if (!aString) {
            break;
        }
        if (![self threafSafe_Setting:^{
            DCHMutableStringSafeAppend(self, aString);
        }]) {
            break;
        }
    } while (NO);
}

- (void)DCH_threadSafe_appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) {
    do {
        if (!format) {
            break;
        }
        va_list arglist;
        va_start(arglist, format);
        NSString *statement = [[NSString alloc] initWithFormat:format arguments:arglist];
        va_end(arglist);
        if (![self threafSafe_Setting:^{
            [self appendString:statement];
        }]) {
            break;
        }
    } while (NO);
}

- (void)DCH_threadSafe_setString:(NSString *)aString {
    do {
        if (![self threafSafe_Setting:^{
            DCHMutableStringSafeSet(self, aString);
        }]) {
            break;
        }
    } while (NO);
}

@end
