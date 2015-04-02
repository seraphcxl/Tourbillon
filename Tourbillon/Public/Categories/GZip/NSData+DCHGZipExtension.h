//
//  NSData+GZipExtension.h
//  Tourbillon
//
//  Created by Derek Chen on 7/12/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DCHGZipExtension)

- (NSData *)dch_compressByGZipWithError:(NSError *__autoreleasing *)err;
- (NSData *)dch_decompressByGZipWithError:(NSError *__autoreleasing *)err;

@end
