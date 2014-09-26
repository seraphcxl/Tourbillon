//
//  DCXOREncryptUtility.m
//  Tourbillon
//
//  Created by Derek Chen on 9/26/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCXOREncryptUtility.h"
#import "DCXOREncryptedInputStream.h"
#import "DCXOREncryptedOutputStream.h"
#import "NSObject+DCUUIDExtension.h"

@implementation DCXOREncryptUtility

+ (BOOL)encryptFile:(NSString *)source toPath:(NSString *)dest withBlockLength:(NSUInteger)len {
    BOOL result = NO;
    NSInputStream *input = nil;
    DCXOREncryptedOutputStream *eOutput = nil;
    do {
        if (!source || !dest || len == 0) {
            break;
        }
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        BOOL isDir = NO;
        if (![fileMgr fileExistsAtPath:source isDirectory:&isDir] || isDir) {
            break;
        }
        
        NSString *path = [NSString stringWithFormat:@"%@_%@", dest, [NSObject createUniqueStrByUUID]];
        NSError *err = nil;
        if ([fileMgr fileExistsAtPath:path]) {
            if (![fileMgr removeItemAtPath:path error:&err] || err) {
                NSLog(@"%@", [err localizedDescription]);
                break;
            }
        }
        
        input = [NSInputStream inputStreamWithFileAtPath:source];
        [input open];
        
        eOutput = [[DCXOREncryptedOutputStream alloc] initToFileAtPath:path append:NO];
        [eOutput open];
        
        BOOL succ = YES;
        while ([input hasBytesAvailable]) {
            uint8_t readData[len];
            NSUInteger readLen = [input read:readData maxLength:len];
            if (readLen > 0) {
                NSUInteger writenLen = [eOutput write:readData maxLength:readLen];
                if (writenLen != readLen) {
                    succ = NO;
                    break;
                }
            }
        }
        if (!succ) {
            break;
        }
        
        err = nil;
        if ([fileMgr fileExistsAtPath:dest]) {
            if (![fileMgr removeItemAtPath:dest error:&err] || err) {
                NSLog(@"%@", [err localizedDescription]);
                break;
            }
        }
        
        if (![fileMgr moveItemAtPath:path toPath:dest error:&err] || err) {
            NSLog(@"%@", [err localizedDescription]);
            break;
        }
        
        result = YES;
    } while (NO);
    [eOutput close];
    eOutput = nil;
    
    [input close];
    input = nil;
    
    return result;
}

+ (BOOL)decryptFile:(NSString *)source toPath:(NSString *)dest withBlockLength:(NSUInteger)len {
    BOOL result = NO;
    NSOutputStream *output = nil;
    DCXOREncryptedInputStream *eInput = nil;
    do {
        if (!source || !dest || len == 0) {
            break;
        }
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        BOOL isDir = NO;
        if (![fileMgr fileExistsAtPath:source isDirectory:&isDir] || isDir) {
            break;
        }
        
        NSString *path = [NSString stringWithFormat:@"%@_%@", dest, [NSObject createUniqueStrByUUID]];
        NSError *err = nil;
        if ([fileMgr fileExistsAtPath:path]) {
            if (![fileMgr removeItemAtPath:path error:&err] || err) {
                NSLog(@"%@", [err localizedDescription]);
                break;
            }
        }
        
        eInput = [[DCXOREncryptedInputStream alloc] initWithFileAtPath:source];
        [eInput open];
        
        output = [NSOutputStream outputStreamToFileAtPath:path append:NO];
        [output open];
        
        BOOL succ = YES;
        while ([eInput hasBytesAvailable]) {
            uint8_t readData[len];
            NSUInteger readLen = [eInput read:readData maxLength:len];
            if (readLen > 0) {
                NSUInteger writenLen =  [output write:readData maxLength:readLen];
                if (writenLen != readLen) {
                    succ = NO;
                    break;
                }
            }
        }
        if (!succ) {
            break;
        }
        
        err = nil;
        if ([fileMgr fileExistsAtPath:dest]) {
            if (![fileMgr removeItemAtPath:dest error:&err] || err) {
                NSLog(@"%@", [err localizedDescription]);
                break;
            }
        }
        
        if (![fileMgr moveItemAtPath:path toPath:dest error:&err] || err) {
            NSLog(@"%@", [err localizedDescription]);
            break;
        }
        
        result = YES;
    } while (NO);
    [eInput close];
    eInput = nil;
    
    [output close];
    output = nil;
    
    return result;
}

@end
