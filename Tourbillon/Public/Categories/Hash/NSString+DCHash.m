//
//  NSString+DCHash.m
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSString+DCHash.h"

@implementation NSString (DCHash)

#pragma mark - MD5
- (NSString *)md5String {
    return [DCHashUtility md5StringForString:self];
}

- (NSData *)md5Data {
    return [DCHashUtility md5DataForString:self];
}

#pragma mark HMAC-MD5
- (NSString *)hmacMD5StringWithHmacKey:(NSString *)key {
    return [DCHashUtility hmacMd5StringForString:self withHmacKey:key];
}

- (NSData *)hmacMD5DataWithHmacKey:(NSString *)key {
    return [DCHashUtility hmacMd5DataForString:self withHmacKey:key];
}

#pragma mark - SHA
- (NSString *)shaStringWithType:(DCSHAType)type {
    return [DCHashUtility shaStringForString:self withSHAType:type];
}

- (NSData *)shaDataWithType:(DCSHAType)type {
    return [DCHashUtility shaDataForString:self withSHAType:type];
}

#pragma mark - HMAC-SHA
- (NSString *)hmacSHAStringWithType:(DCSHAType)type andHmacKey:(NSString *)key {
    return [DCHashUtility hmacSHAStringForString:self withSHAType:type andHmacKey:key];
}

- (NSData *)hmacSHADataWithType:(DCSHAType)type andHmacKey:(NSString *)key {
    return [DCHashUtility hmacSHADataForString:self withSHAType:type andHmacKey:key];
}

@end
