//
//  NSData+DCHash.m
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSData+DCHash.h"

@implementation NSData (DCHash)

#pragma mark - MD5
- (NSString *)md5String {
    return [DCHashUtility md5StringForData:self];
}

- (NSData *)md5Data {
    return [DCHashUtility md5DataForData:self];
}

#pragma mark HMAC-MD5
- (NSString *)hmacMD5StringWithHmacKey:(NSString *)key {
    return [DCHashUtility hmacMd5StringForData:self withHmacKey:key];
}

- (NSData *)hmacMD5DataWithHmacKey:(NSString *)key {
    return [DCHashUtility hmacMd5DataForData:self withHmacKey:key];
}

#pragma mark - SHA
- (NSString *)shaStringWithType:(DCSHAType)type {
    return [DCHashUtility shaStringForData:self withSHAType:type];
}

- (NSData *)shaDataWithType:(DCSHAType)type {
    return [DCHashUtility shaDataForData:self withSHAType:type];
}

#pragma mark - HMAC-SHA
- (NSString *)hmacSHAStringWithType:(DCSHAType)type andHmacKey:(NSString *)key {
    return [DCHashUtility hmacSHAStringForData:self withSHAType:type andHmacKey:key];
}

- (NSData *)hmacSHADataWithType:(DCSHAType)type andHmacKey:(NSString *)key {
    return [DCHashUtility hmacSHADataForData:self withSHAType:type andHmacKey:key];
}

@end
