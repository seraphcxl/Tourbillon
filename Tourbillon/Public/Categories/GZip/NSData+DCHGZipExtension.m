//
//  NSData+GZipExtension.m
//  Tourbillon
//
//  Created by Derek Chen on 7/12/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSData+DCHGZipExtension.h"
#import "DCHGZipCompressor.h"
#import "DCHGZipDecompressor.h"

@implementation NSData (DCHGZipExtension)

- (NSData *)dch_compressByGZipWithError:(NSError *__autoreleasing *)err {
    return [DCHGZipCompressor compressData:self error:err];
}

- (NSData *)dch_decompressByGZipWithError:(NSError *__autoreleasing *)err {
    return [DCHGZipDecompressor decompressData:self error:err];
}

@end
