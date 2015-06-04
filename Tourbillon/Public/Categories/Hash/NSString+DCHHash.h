//
//  NSString+DCHHash.h
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHHashUtility.h"

@interface NSString (DCHHash)

#pragma mark - MD5
- (NSString *)dch_md5String;
- (NSData *)dch_md5Data;

#pragma mark HMAC-MD5
- (NSString *)dch_hmacMD5StringWithHmacKey:(NSString *)key;
- (NSData *)dch_hmacMD5DataWithHmacKey:(NSString *)key;

#pragma mark - SHA
- (NSString *)dch_shaStringWithType:(DCHSHAType)type;
- (NSData *)dch_shaDataWithType:(DCHSHAType)type;

#pragma mark - HMAC-SHA
- (NSString *)dch_hmacSHAStringWithType:(DCHSHAType)type andHmacKey:(NSString *)key;
- (NSData *)dch_hmacSHADataWithType:(DCHSHAType)type andHmacKey:(NSString *)key;

@end
