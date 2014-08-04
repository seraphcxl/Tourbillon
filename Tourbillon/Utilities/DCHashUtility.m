//
//  DCHashUtility.m
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCHashUtility.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import "DCLogger.h"
#import "NSData+DCHex.h"

@implementation DCHashUtility

#pragma mark - MD5
+ (NSString *)md5StringForString:(NSString *)string {
    NSString *result = nil;
    do {
        if (!string) {
            break;
        }
        NSData *md5Data = [DCHashUtility md5DataForData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        result = [md5Data hex];
    } while (NO);
    return result;
}

+ (NSData *)md5DataForString:(NSString *)string {
    NSData *result = nil;
    do {
        if (!string) {
            break;
        }
        result = [DCHashUtility md5DataForData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    } while (NO);
    return result;
}

+ (NSString *)md5StringForData:(NSData *)data {
    NSString *result = nil;
    do {
        if (!data) {
            break;
        }
        NSData *md5Data = [DCHashUtility md5DataForData:data];
        result = [md5Data hex];
    } while (NO);
    return result;
}

+ (NSData *)md5DataForData:(NSData *)data {
    NSData *result = nil;
    unsigned char *digest = NULL;
    do {
        if (!data) {
            break;
        }
        digest = malloc(CC_MD5_DIGEST_LENGTH);
        if (!digest) {
            break;
        }
        CC_MD5([data bytes], (CC_LONG)[data length], digest);
        result = [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    } while (NO);
    if (digest) {
        free(digest);
        digest = NULL;
    }
    return result;
}

#pragma mark HMAC-MD5
+ (NSString *)hmacMd5StringForString:(NSString *)string withHmacKey:(NSString *)key {
    NSString *result = nil;
    do {
        if (!string || !key) {
            break;
        }
        NSData *hmacMd5Data = [DCHashUtility hmacMd5DataForData:[string dataUsingEncoding:NSUTF8StringEncoding] withHmacKey:key];
        result = [hmacMd5Data hex];
    } while (NO);
    return result;
}

+ (NSData *)hmacMd5DataForString:(NSString *)string withHmacKey:(NSString *)key {
    NSData *result = nil;
    do {
        if (!string || !key) {
            break;
        }
        result = [DCHashUtility hmacMd5DataForData:[string dataUsingEncoding:NSUTF8StringEncoding] withHmacKey:key];
    } while (NO);
    return result;
}

+ (NSString *)hmacMd5StringForData:(NSData *)data withHmacKey:(NSString *)key {
    NSString *result = nil;
    do {
        if (!data || !key) {
            break;
        }
        NSData *hmacMd5Data = [DCHashUtility hmacMd5DataForData:data withHmacKey:key];
        result = [hmacMd5Data hex];
    } while (NO);
    return result;
}

+ (NSData *)hmacMd5DataForData:(NSData *)data withHmacKey:(NSString *)key {
    NSData *result = nil;
    unsigned char *digest = NULL;
    const char *cKey = NULL;
    do {
        if (!data || !key) {
            break;
        }
        digest = malloc(CC_MD5_DIGEST_LENGTH);
        if (!digest) {
            break;
        }
        cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
        CCHmac(kCCHmacAlgMD5, cKey, strlen(cKey), [data bytes], [data length], digest);
        result = [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    } while (NO);
    if (digest) {
        free(digest);
        digest = NULL;
    }
    cKey = NULL;
    return result;
}

#pragma mark - SHA
+ (NSString *)shaStringForString:(NSString *)string withSHAType:(DCSHAType)type {
    NSString *result = nil;
    do {
        if (!string) {
            break;
        }
        NSData *shaData = [DCHashUtility shaDataForData:[string dataUsingEncoding:NSUTF8StringEncoding] withSHAType:type];
        result = [shaData hexLower];
    } while (NO);
    return result;
}

+ (NSData *)shaDataForString:(NSString *)string withSHAType:(DCSHAType)type {
    NSData *result = nil;
    do {
        if (!string) {
            break;
        }
        result = [DCHashUtility shaDataForData:[string dataUsingEncoding:NSUTF8StringEncoding] withSHAType:type];
    } while (NO);
    return result;
}

+ (NSString *)shaStringForData:(NSData *)data withSHAType:(DCSHAType)type {
    NSString *result = nil;
    do {
        if (!data) {
            break;
        }
        NSData *shaData = [DCHashUtility shaDataForData:data withSHAType:type];
        result = [shaData hexLower];
    } while (NO);
    return result;
}

+ (NSData *)shaDataForData:(NSData *)data withSHAType:(DCSHAType)type {
    NSData *result = nil;
    unsigned char *digest = NULL;
    do {
        if (!data) {
            break;
        }
        
        switch (type) {
            case DCSHAType_SHA1:
            {
                digest = malloc(CC_SHA1_DIGEST_LENGTH);
                if (!digest) {
                    break;
                }
                CC_SHA1([data bytes], (CC_LONG)[data length], digest);
                result = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
            }
                break;
            case DCSHAType_SHA224:
            {
                digest = malloc(CC_SHA224_DIGEST_LENGTH);
                if (!digest) {
                    break;
                }
                CC_SHA224([data bytes], (CC_LONG)[data length], digest);
                result = [NSData dataWithBytes:digest length:CC_SHA224_DIGEST_LENGTH];
            }
                break;
            case DCSHAType_SHA256:
            {
                digest = malloc(CC_SHA256_DIGEST_LENGTH);
                if (!digest) {
                    break;
                }
                CC_SHA256([data bytes], (CC_LONG)[data length], digest);
                result = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
            }
                break;
            case DCSHAType_SHA384:
            {
                digest = malloc(CC_SHA384_DIGEST_LENGTH);
                if (!digest) {
                    break;
                }
                CC_SHA384([data bytes], (CC_LONG)[data length], digest);
                result = [NSData dataWithBytes:digest length:CC_SHA384_DIGEST_LENGTH];
            }
                break;
            case DCSHAType_SHA512:
            {
                digest = malloc(CC_SHA512_DIGEST_LENGTH);
                if (!digest) {
                    break;
                }
                CC_SHA512([data bytes], (CC_LONG)[data length], digest);
                result = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
            }
                break;
            default:
            {
                DCAssert(0, @"Unkonwn SHA type!");
            }
                break;
        }
    } while (NO);
    if (digest) {
        free(digest);
        digest = NULL;
    }
    return result;
}

#pragma mark - HMAC-SHA
+ (NSString *)hmacSHAStringForString:(NSString *)string withSHAType:(DCSHAType)type andHmacKey:(NSString *)key {
    NSString *result = nil;
    do {
        if (!string || !key) {
            break;
        }
        NSData *hmacSHAData = [DCHashUtility hmacSHADataForData:[string dataUsingEncoding:NSUTF8StringEncoding] withSHAType:type andHmacKey:key];
        result = [hmacSHAData hexLower];
    } while (NO);
    return result;
}

+ (NSData *)hmacSHADataForString:(NSString *)string withSHAType:(DCSHAType)type andHmacKey:(NSString *)key {
    NSData *result = nil;
    do {
        if (!string || !key) {
            break;
        }
        result = [DCHashUtility hmacSHADataForData:[string dataUsingEncoding:NSUTF8StringEncoding] withSHAType:type andHmacKey:key];
    } while (NO);
    return result;
}

+ (NSString *)hmacSHAStringForData:(NSData *)data withSHAType:(DCSHAType)type andHmacKey:(NSString *)key {
    NSString *result = nil;
    do {
        if (!data || !key) {
            break;
        }
        NSData *hmacSHAData = [DCHashUtility hmacSHADataForData:data withSHAType:type andHmacKey:key];
        result = [hmacSHAData hexLower];
    } while (NO);
    return result;
}

+ (NSData *)hmacSHADataForData:(NSData *)data withSHAType:(DCSHAType)type andHmacKey:(NSString *)key {
    NSData *result = nil;
    unsigned char *digest = NULL;
    const char *cKey = NULL;
    do {
        if (!data) {
            break;
        }
        cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
        switch (type) {
            case DCSHAType_SHA1:
            {
                digest = malloc(CC_SHA1_DIGEST_LENGTH);
                if (!digest) {
                    break;
                }
                CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), [data bytes], [data length], digest);
                result = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
            }
                break;
            case DCSHAType_SHA224:
            {
                digest = malloc(CC_SHA224_DIGEST_LENGTH);
                if (!digest) {
                    break;
                }
                CCHmac(kCCHmacAlgSHA224, cKey, strlen(cKey), [data bytes], [data length], digest);
                result = [NSData dataWithBytes:digest length:CC_SHA224_DIGEST_LENGTH];
            }
                break;
            case DCSHAType_SHA256:
            {
                digest = malloc(CC_SHA256_DIGEST_LENGTH);
                if (!digest) {
                    break;
                }
                CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), [data bytes], [data length], digest);
                result = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
            }
                break;
            case DCSHAType_SHA384:
            {
                digest = malloc(CC_SHA384_DIGEST_LENGTH);
                if (!digest) {
                    break;
                }
                CCHmac(kCCHmacAlgSHA384, cKey, strlen(cKey), [data bytes], [data length], digest);
                result = [NSData dataWithBytes:digest length:CC_SHA384_DIGEST_LENGTH];
            }
                break;
            case DCSHAType_SHA512:
            {
                digest = malloc(CC_SHA512_DIGEST_LENGTH);
                if (!digest) {
                    break;
                }
                CCHmac(kCCHmacAlgSHA512, cKey, strlen(cKey), [data bytes], [data length], digest);
                result = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
            }
                break;
            default:
            {
                DCAssert(0, @"Unkonwn SHA type!");
            }
                break;
        }
    } while (NO);
    if (digest) {
        free(digest);
        digest = NULL;
    }
    cKey = NULL;
    return result;
}

@end
