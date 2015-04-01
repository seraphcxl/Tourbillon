//
//  DCHHashUtility.h
//  Tourbillon
//
//  Created by Derek Chen on 4/1/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DCH_GOODHASHDef
#define DCH_GOODHASHDef

#define DCH_GOODPOWER 7
#define DCH_GOODMASK ((1 << DCH_GOODPOWER) - 1)
#define DCH_GOODHASH(x) (((long)x >> 5) & DCH_GOODMASK)  // x shoud be id

#endif

typedef NS_ENUM(NSUInteger, DCHSHAType) {
    DCHSHAType_SHA1,
    DCHSHAType_SHA224,
    DCHSHAType_SHA256,
    DCHSHAType_SHA384,
    DCHSHAType_SHA512,
};

@interface DCHHashUtility : NSObject

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
+ (NSString *)shaStringForString:(NSString *)string withSHAType:(DCHSHAType)type;
+ (NSData *)shaDataForString:(NSString *)string withSHAType:(DCHSHAType)type;
+ (NSString *)shaStringForData:(NSData *)data withSHAType:(DCHSHAType)type;
+ (NSData *)shaDataForData:(NSData *)data withSHAType:(DCHSHAType)type;

#pragma mark - HMAC-SHA
+ (NSString *)hmacSHAStringForString:(NSString *)string withSHAType:(DCHSHAType)type andHmacKey:(NSString *)key;
+ (NSData *)hmacSHADataForString:(NSString *)string withSHAType:(DCHSHAType)type andHmacKey:(NSString *)key;
+ (NSString *)hmacSHAStringForData:(NSData *)data withSHAType:(DCHSHAType)type andHmacKey:(NSString *)key;
+ (NSData *)hmacSHADataForData:(NSData *)data withSHAType:(DCHSHAType)type andHmacKey:(NSString *)key;

@end
