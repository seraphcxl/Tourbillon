//
//  NSData+DCHash.h
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHashUtility.h"

@interface NSData (DCHash)

#pragma mark - MD5
- (NSString *)md5String;
- (NSData *)md5Data;

#pragma mark HMAC-MD5
- (NSString *)hmacMD5StringWithHmacKey:(NSString *)key;
- (NSData *)hmacMD5DataWithHmacKey:(NSString *)key;

#pragma mark - SHA
- (NSString *)shaStringWithType:(DCSHAType)type;
- (NSData *)shaDataWithType:(DCSHAType)type;

#pragma mark - HMAC-SHA
- (NSString *)hmacSHAStringWithType:(DCSHAType)type andHmacKey:(NSString *)key;
- (NSData *)hmacSHADataWithType:(DCSHAType)type andHmacKey:(NSString *)key;

@end
