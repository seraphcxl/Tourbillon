//
//  NSData+DCHex.m
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSData+DCHex.h"

@implementation NSData (DCHex)

- (NSString *)hex {
    return [self hexUseLower:NO];
}

- (NSString *)hexLower {
    return [self hexUseLower:YES];
}

- (NSString *)hexUseLower:(BOOL)isOutputLower {
    NSString *result = nil;
    
    static const char NSData_DCHex_HexEncodeCharsLower[] = "0123456789abcdef";
    static const char NSData_DCHex_HexEncodeChars[] = "0123456789ABCDEF";
    
    char *resultData = NULL;
    unsigned char *sourceData = NULL;
    
    do {
        if (self.length == 0) {
            break;
        }
        resultData = malloc([self length] * 2 +1);
        sourceData = ((unsigned char *)[self bytes]);
        NSUInteger length = [self length];
        
        if (isOutputLower) {
            for (NSUInteger idx = 0; idx < length; ++idx) {
                resultData[idx * 2] = NSData_DCHex_HexEncodeCharsLower[(sourceData[idx] >> 4)];
                resultData[idx * 2 + 1] = NSData_DCHex_HexEncodeCharsLower[(sourceData[idx] % 0x10)];
            }
        } else {
            for (NSUInteger idx = 0; idx < length; ++idx) {
                resultData[idx * 2] = NSData_DCHex_HexEncodeChars[(sourceData[idx] >> 4)];
                resultData[idx * 2 + 1] = NSData_DCHex_HexEncodeChars[(sourceData[idx] % 0x10)];
            }
        }
        resultData[[self length] * 2] = 0;
        
        result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    } while (NO);
    sourceData = nil;
    if (resultData) {
        free(resultData);
        resultData = NULL;
    }
    return result;
}

@end
