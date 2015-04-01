//
//  NSData+DCHHash.m
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSData+DCHHash.h"

@implementation NSData (DCHHash)

#pragma mark - MD5
- (NSString *)md5String {
    return [DCHHashUtility md5StringForData:self];
}

- (NSData *)md5Data {
    return [DCHHashUtility md5DataForData:self];
}

#pragma mark HMAC-MD5
- (NSString *)hmacMD5StringWithHmacKey:(NSString *)key {
    return [DCHHashUtility hmacMd5StringForData:self withHmacKey:key];
}

- (NSData *)hmacMD5DataWithHmacKey:(NSString *)key {
    return [DCHHashUtility hmacMd5DataForData:self withHmacKey:key];
}

#pragma mark - SHA
- (NSString *)shaStringWithType:(DCHSHAType)type {
    return [DCHHashUtility shaStringForData:self withSHAType:type];
}

- (NSData *)shaDataWithType:(DCHSHAType)type {
    return [DCHHashUtility shaDataForData:self withSHAType:type];
}

#pragma mark - HMAC-SHA
- (NSString *)hmacSHAStringWithType:(DCHSHAType)type andHmacKey:(NSString *)key {
    return [DCHHashUtility hmacSHAStringForData:self withSHAType:type andHmacKey:key];
}

- (NSData *)hmacSHADataWithType:(DCHSHAType)type andHmacKey:(NSString *)key {
    return [DCHHashUtility hmacSHADataForData:self withSHAType:type andHmacKey:key];
}

@end
