//
//  DCCompressorTestCase.m
//  Tourbillon
//
//  Created by Derek Chen on 9/19/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCCompressorTestCase.h"

#import "DCTourbillon.h"

@implementation DCCompressorTestCase

- (void)test4Compressor {
    do {
        NSString *str = [NSObject createUniqueStrByUUID];
        NSData *rawData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err = nil;
        NSData *compressedData = [rawData compressByGZipWithError:&err];
        XCTAssertNil(err, @"err");
        
        err = nil;
        NSData *decompressedData = [compressedData decompressByGZipWithError:&err];
        XCTAssertEqualObjects(rawData, decompressedData, @"rawData == decompressedData");
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *fileURL = [bundle URLForResource:@"Apple think different" withExtension:@"rtf"];
        rawData = [NSData dataWithContentsOfURL:fileURL];
        
        err = nil;
        compressedData = [rawData compressByGZipWithError:&err];
        XCTAssertNil(err, @"err");
        
        err = nil;
        decompressedData = [compressedData decompressByGZipWithError:&err];
        XCTAssertEqualObjects(rawData, decompressedData, @"rawData == decompressedData");
        
    } while (NO);
}

@end
