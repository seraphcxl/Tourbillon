//
//  NSData+GZipExtension.m
//  Tourbillon
//
//  Created by Derek Chen on 7/12/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSData+GZipExtension.h"
#import "DCGZipCompressor.h"
#import "DCGZipDecompressor.h"

@implementation NSData (GZipExtension)

- (NSData *)compressByGZipWithError:(NSError *__autoreleasing *)err {
    return [DCGZipCompressor compressData:self error:err];
}

- (NSData *)decompressByGZipWithError:(NSError *__autoreleasing *)err {
    return [DCGZipDecompressor decompressData:self error:err];
}

@end
