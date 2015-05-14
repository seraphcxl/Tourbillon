//
//  NSString+DCHSafeCRUD.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSString+DCHSafeCRUD.h"

@implementation NSString (DCHSafeCRUD)

- (unichar)DCH_safe_characterAtIndex:(NSUInteger)index {
    unichar result = 0;
    do {
        if (index < self.length) {
            result = [self characterAtIndex:index];
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_safe_substringFromIndex:(NSUInteger)from {
    NSString *result = nil;
    do {
        if (from < self.length) {
            result = [self substringFromIndex:from];
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_safe_substringToIndex:(NSUInteger)to {
    NSString *result = nil;
    do {
        if (to < self.length) {
            result = [self substringToIndex:to];
        }
    } while (NO);
    return result;
}

- (NSString *)DCH_safe_substringWithRange:(NSRange)range {
    NSString *result = nil;
    do {
        if (range.location <= self.length && (range.location + range.length) <= self.length) {
            result = [self substringWithRange:range];
        }
    } while (NO);
    return result;
}

- (BOOL)DCH_safe_hasPrefix:(NSString *)aString {
    BOOL result = NO;
    do {
        if (DCH_IsEmpty(aString)) {
            break;
        }
        result = [self hasPrefix:aString];
    } while (NO);
    return result;
}

- (BOOL)DCH_safe_hasSuffix:(NSString *)aString {
    BOOL result = NO;
    do {
        if (DCH_IsEmpty(aString)) {
            break;
        }
        result = [self hasSuffix:aString];
    } while (NO);
    return result;
}

- (NSRange)DCH_safe_rangeOfString:(NSString *)aString {
    NSRange result = NSMakeRange(0, 0);
    do {
        if (DCH_IsEmpty(aString)) {
            break;
        }
        result = [self rangeOfString:aString];
    } while (NO);
    return result;
}

- (NSString *)DCH_safe_stringByAppendingString:(NSString *)aString {
    NSString *result = nil;
    do {
        if (DCH_IsEmpty(aString)) {
            result = [self stringByAppendingString:aString];
        }
    } while (NO);
    return result;
}

@end
