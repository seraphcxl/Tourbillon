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

- (void)test4EncryptData {
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

- (void)test4EncryptFile {
    do {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *fileURL = [bundle URLForResource:@"Apple think different" withExtension:@"rtf"];
        NSData *fileData = [NSData dataWithContentsOfURL:fileURL];
        NSInputStream *input = [NSInputStream inputStreamWithData:fileData];
        [input open];
        
        NSMutableData *eData = [NSMutableData dataWithLength:[fileData length] + 36];
        DCXOREncryptedOutputStream *eOutput = [[DCXOREncryptedOutputStream alloc] initToBuffer:[eData bytes] capacity:[eData length]];
        [eOutput open];
        
        NSUInteger count = 16;
        while ([input hasBytesAvailable]) {
            uint8_t readData[count];
            NSUInteger readLen = [input read:readData maxLength:count];
            if (readLen > 0) {
                NSUInteger writenLen = [eOutput write:readData maxLength:readLen];
                if (writenLen != readLen) {
                    break;
                }
            }
            ++count;
        }
        
        [input close];
        [eOutput close];
        
        DCXOREncryptedInputStream *eInput = [[DCXOREncryptedInputStream alloc] initWithData:eData];
        [eInput open];
        
        NSMutableData *rawData = [NSMutableData data];
        count = 16;
        while ([eInput hasBytesAvailable]) {
            uint8_t readData[count];
            NSUInteger readLen = [eInput read:readData maxLength:count];
            if (readLen > 0) {
                [rawData appendBytes:readData length:readLen];
            }
            ++count;
        }
        NSString *str = [NSString stringWithUTF8String:[fileData bytes]];
        NSLog(@"%@",str);
        NSString *str1 = [NSString stringWithUTF8String:[rawData bytes]];
        NSLog(@"%@",str1);
        XCTAssertEqualObjects(rawData, fileData, @"[fileData isEqualToData:rawData]");
        int i = 0;
    } while (NO);
}

@end
