//
//  DCGZipCompressor.h
//  Tourbillon
//
//  Created by Derek Chen on 7/12/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kDCGZipCompressorOption_Level;
extern NSString * const kDCGZipCompressorOption_WindowSize;
extern NSString * const kDCGZipCompressorOption_MemoryLevel;
extern NSString * const kDCGZipCompressorOption_Strategy;

@interface DCGZipCompressor : NSObject

+ (NSData *)compressData:(NSData *)rawData error:(NSError *__autoreleasing *)err;
+ (NSData *)compressData:(NSData *)rawData options:(NSDictionary *)options error:(NSError *__autoreleasing *)err;

+ (BOOL)compressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath error:(NSError *__autoreleasing *)err;
+ (BOOL)compressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath options:(NSDictionary *)options error:(NSError *__autoreleasing *)err;

+ (BOOL)compressDataFromStream:(NSInputStream *)sourceStream toStream:(NSOutputStream *)destinationStream error:(NSError *__autoreleasing *)err;
+ (BOOL)compressDataFromStream:(NSInputStream *)sourceStream toStream:(NSOutputStream *)destinationStream options:(NSDictionary *)options error:(NSError *__autoreleasing *)err;

@end
