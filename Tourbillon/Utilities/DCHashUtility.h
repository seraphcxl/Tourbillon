//
//  DCHashUtility.h
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DC_GOODHASHDef
#define DC_GOODHASHDef

#define DC_GOODPOWER 7
#define DC_GOODMASK ((1 << DC_GOODPOWER) - 1)
#define DC_GOODHASH(x) (((long)x >> 5) & DC_GOODMASK)

#endif

typedef NS_ENUM(NSUInteger, DCSHAType) {
    DCSHAType_SHA1,
    DCSHAType_SHA224,
    DCSHAType_SHA256,
    DCSHAType_SHA384,
    DCSHAType_SHA512,
};

@interface DCHashUtility : NSObject

#pragma mark - MD5
+ (NSString *)md5StringForString:(NSString *)string;
+ (NSData *)md5DataForString:(NSString *)string;
+ (NSString *)md5StringForData:(NSData *)data;
+ (NSData *)md5DataForData:(NSData *)data;
#pragma mark HMAC-MD5
+ (NSString *)hmacMd5StringForString:(NSString *)string withHmacKey:(NSString *)key;
+ (NSData *)hmacMd5DataForString:(NSString *)string withHmacKey:(NSString *)key;
+ (NSString *)hmacMd5StringForData:(NSData *)data withHmacKey:(NSString *)key;
+ (NSData *)hmacMd5DataForData:(NSData *)data withHmacKey:(NSString *)key;
#pragma mark - SHA
+ (NSString *)shaStringForString:(NSString *)string withSHAType:(DCSHAType)type;
+ (NSData *)shaDataForString:(NSString *)string withSHAType:(DCSHAType)type;
+ (NSString *)shaStringForData:(NSData *)data withSHAType:(DCSHAType)type;
+ (NSData *)shaDataForData:(NSData *)data withSHAType:(DCSHAType)type;
#pragma mark - HMAC-SHA
+ (NSString *)hmacSHAStringForString:(NSString *)string withSHAType:(DCSHAType)type andHmacKey:(NSString *)key;
+ (NSData *)hmacSHADataForString:(NSString *)string withSHAType:(DCSHAType)type andHmacKey:(NSString *)key;
+ (NSString *)hmacSHAStringForData:(NSData *)data withSHAType:(DCSHAType)type andHmacKey:(NSString *)key;
+ (NSData *)hmacSHADataForData:(NSData *)data withSHAType:(DCSHAType)type andHmacKey:(NSString *)key;

@end
