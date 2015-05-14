//
//  NSMutableString+DCHSafeCRUD.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSMutableString+DCHSafeCRUD.h"

@implementation NSMutableString (DCHSafeCRUD)

- (void)DCH_safe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    do {
        if (!DCH_IsEmpty(aString) && range.location <= self.length && (range.location + range.length) <= self.length) {
            [self replaceCharactersInRange:range withString:aString];
        }
    } while (NO);
}

- (void)DCH_safe_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    do {
        if (!DCH_IsEmpty(aString) && loc <= self.length) {
            [self insertString:aString atIndex:loc];
        }
    } while (NO);
}

- (void)DCH_safe_deleteCharactersInRange:(NSRange)range {
    do {
        if (range.location <= self.length && (range.location + range.length) <= self.length) {
            [self deleteCharactersInRange:range];
        }
    } while (NO);
}

- (void)DCH_safe_appendString:(NSString *)aString {
    do {
        if (DCH_IsEmpty(aString)) {
            break;
        }
        [self appendString:aString];
    } while (NO);
}

- (void)DCH_safe_setString:(NSString *)aString {
    do {
        if (DCH_IsEmpty(aString)) {
            break;
        }
        [self setString:aString];
    } while (NO);
}

@end
