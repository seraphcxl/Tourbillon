//
//  NSData+DCHHash.h
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHHashUtility.h"

@interface NSData (DCHHash)

#pragma mark - MD5
- (NSString *)md5String;
- (NSData *)md5Data;

#pragma mark HMAC-MD5
- (NSString *)hmacMD5StringWithHmacKey:(NSString *)key;
- (NSData *)hmacMD5DataWithHmacKey:(NSString *)key;

#pragma mark - SHA
- (NSString *)shaStringWithType:(DCHSHAType)type;
- (NSData *)shaDataWithType:(DCHSHAType)type;

#pragma mark - HMAC-SHA
- (NSString *)hmacSHAStringWithType:(DCHSHAType)type andHmacKey:(NSString *)key;
- (NSData *)hmacSHADataWithType:(DCHSHAType)type andHmacKey:(NSString *)key;

@end
