//
//  NSData+GZipExtension.h
//  Tourbillon
//
//  Created by Derek Chen on 7/12/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GZipExtension)

- (NSData *)compressByGZipWithError:(NSError *__autoreleasing *)err;
- (NSData *)decompressByGZipWithError:(NSError *__autoreleasing *)err;

@end
