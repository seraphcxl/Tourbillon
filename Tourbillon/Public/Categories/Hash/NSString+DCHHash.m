//
//  NSString+DCHHash.m
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSString+DCHHash.h"

@implementation NSString (DCHHash)

#pragma mark - MD5
- (NSString *)md5String {
    return [DCHHashUtility md5StringForString:self];
}

- (NSData *)md5Data {
    return [DCHHashUtility md5DataForString:self];
}

#pragma mark HMAC-MD5
- (NSString *)hmacMD5StringWithHmacKey:(NSString *)key {
    return [DCHHashUtility hmacMd5StringForString:self withHmacKey:key];
}

- (NSData *)hmacMD5DataWithHmacKey:(NSString *)key {
    return [DCHHashUtility hmacMd5DataForString:self withHmacKey:key];
}

#pragma mark - SHA
- (NSString *)shaStringWithType:(DCHSHAType)type {
    return [DCHHashUtility shaStringForString:self withSHAType:type];
}

- (NSData *)shaDataWithType:(DCHSHAType)type {
    return [DCHHashUtility shaDataForString:self withSHAType:type];
}

#pragma mark - HMAC-SHA
- (NSString *)hmacSHAStringWithType:(DCHSHAType)type andHmacKey:(NSString *)key {
    return [DCHHashUtility hmacSHAStringForString:self withSHAType:type andHmacKey:key];
}

- (NSData *)hmacSHADataWithType:(DCHSHAType)type andHmacKey:(NSString *)key {
    return [DCHHashUtility hmacSHADataForString:self withSHAType:type andHmacKey:key];
}

@end
