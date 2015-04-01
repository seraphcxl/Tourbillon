//
//  DCHGZipCompressor.h
//  Tourbillon
//
//  Created by Derek Chen on 4/1/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kDCHGZipCompressorOption_Level;
extern NSString * const kDCHGZipCompressorOption_WindowSize;
extern NSString * const kDCHGZipCompressorOption_MemoryLevel;
extern NSString * const kDCHGZipCompressorOption_Strategy;

@interface DCHGZipCompressor : NSObject

+ (NSData *)compressData:(NSData *)rawData error:(NSError *__autoreleasing *)err;
+ (NSData *)compressData:(NSData *)rawData options:(NSDictionary *)options error:(NSError *__autoreleasing *)err;

+ (BOOL)compressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath error:(NSError *__autoreleasing *)err;
+ (BOOL)compressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath options:(NSDictionary *)options error:(NSError *__autoreleasing *)err;

+ (BOOL)compressDataFromStream:(NSInputStream *)sourceStream toStream:(NSOutputStream *)destinationStream error:(NSError *__autoreleasing *)err;
+ (BOOL)compressDataFromStream:(NSInputStream *)sourceStream toStream:(NSOutputStream *)destinationStream options:(NSDictionary *)options error:(NSError *__autoreleasing *)err;

@end
