//
//  DCXOREncryptedInputStream.m
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCXOREncryptedInputStream.h"
#import "NSObject+DCUUIDExtension.h"
#import "DCLogger.h"

@interface DCXOREncryptedInputStream () {
}

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSData *passwordData;

@end

@implementation DCXOREncryptedInputStream

@synthesize password = _password;
@synthesize passwordData = _passwordData;

- (void)dealloc {
    do {
        self.passwordData = nil;
        self.password = nil;
    } while (NO);
}

- (void)open {
    do {
        [super open];
        @synchronized (self) {
            if (_passwordData) {
                NSUInteger len = [[[NSObject createUniqueStrByUUID] dataUsingEncoding:NSUTF8StringEncoding] length];
                uint8_t pwData[len];
                NSUInteger resultLen = [super read:pwData maxLength:len];
                DCAssert(resultLen == len, @"Read password error!");
                
                _passwordData = [NSData dataWithBytes:pwData length:len];
                _password = [NSString stringWithUTF8String:(char *)pwData];
            }
        }
    } while (NO);
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len {
    NSUInteger result = 0;
    do {
        if (!buffer || len == 0) {
            break;
        }
        uint8_t tmpBuffer[len];
        NSInteger tmpReadCount = [super read:tmpBuffer maxLength:len];
        DCAssert(tmpReadCount <= len, @"Read too much data!");
        
        uint8_t *pw = (uint8_t *)[_passwordData bytes];
        NSUInteger pwLen = [_passwordData length];
        
        for (NSInteger idx = 0; idx < tmpReadCount; ++idx) {
            NSInteger pwIdx = ((idx >= pwLen) ? (idx - pwLen) : idx);
            buffer[idx] = tmpBuffer[idx] ^ pw[pwIdx];
        }
        
    } while (NO);
    return result;
}

@end
