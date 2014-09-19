//
//  DCEncryptTestCase.m
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCEncryptTestCase.h"

#import "DCTourbillon.h"

@implementation DCEncryptTestCase

- (void)test4Encryption {
    do {
        
        NSString *str = @"Hello, world.";
        NSData *rawData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableData *store = [NSMutableData dataWithLength:[rawData length] + 36];
        
        DCXOREncryptedOutputStream *output = [[DCXOREncryptedOutputStream alloc] initToBuffer:[store bytes] capacity:[store length]];
        [output open];
        [output write:[rawData bytes] maxLength:[rawData length]];
        [output close];
        
        NSMutableData *readData = [NSMutableData dataWithLength:[rawData length]];
        
        DCXOREncryptedInputStream *input = [[DCXOREncryptedInputStream alloc] initWithData:store];
        [input open];
        NSInteger readLen = [input read:[readData bytes] maxLength:[readData length]];
        [input close];
        
        XCTAssertEqualObjects(rawData, readData, @"[readData isEqualToData:rawData]");
//        DCAssert([readData isEqualToData:rawData], @"[readData isEqualToData:rawData]");
    } while (NO);
}

@end
