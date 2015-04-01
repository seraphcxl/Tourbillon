//
//  DCHGZipDecompressor.h
//  Tourbillon
//
//  Created by Derek Chen on 7/12/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kDCHGZipDecompressorOption_WindowSize;

@interface DCHGZipDecompressor : NSObject

+ (NSData *)decompressData:(NSData *)compressedData error:(NSError *__autoreleasing *)err;
+ (NSData *)decompressData:(NSData *)compressedData options:(NSDictionary *)options error:(NSError *__autoreleasing *)err;

+ (BOOL)decompressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath error:(NSError *__autoreleasing *)err;
+ (BOOL)decompressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath options:(NSDictionary *)options error:(NSError *__autoreleasing *)err;

+ (BOOL)decompressDataFromStream:(NSInputStream *)sourceStream toStream:(NSOutputStream *)destinationStream error:(NSError *__autoreleasing *)err;
+ (BOOL)decompressDataFromStream:(NSInputStream *)sourceStream toStream:(NSOutputStream *)destinationStream options:(NSDictionary *)options error:(NSError *__autoreleasing *)err;

@end
