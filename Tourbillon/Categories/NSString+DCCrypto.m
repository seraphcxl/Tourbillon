//
//  NSString+DCCrypto.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "NSString+DCCrypto.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (DCCrypto)

- (NSString *)md5 {
    NSString *result = nil;
    do {
        @synchronized(self) {
            NSData *stringBytes = [self dataUsingEncoding:NSUTF8StringEncoding];
            unsigned char md5Result[CC_MD5_DIGEST_LENGTH] = {0};
            if (CC_MD5([stringBytes bytes], (CC_LONG)[stringBytes length], md5Result)) {
                NSMutableString *returnString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
                for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
                    [returnString appendFormat:@"%02x", md5Result[i]];
                }
                result = [NSString stringWithString:returnString];
            }
        }
    } while (NO);
    return result;
}

- (NSString *)sha1 {
    NSString *result = nil;
    do {
        @synchronized(self) {
            NSData *stringBytes = [self dataUsingEncoding:NSUTF8StringEncoding];
            unsigned char sha1Result[CC_SHA1_DIGEST_LENGTH] = {0};
            if (CC_SHA1([stringBytes bytes], (CC_LONG)[stringBytes length], sha1Result)) {
                NSMutableString *returnString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
                for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; ++i) {
                    [returnString appendFormat:@"%02x", sha1Result[i]];
                }
                result =  [NSString stringWithString:returnString];
            }
        }
    } while (NO);
    return result;
}

@end
