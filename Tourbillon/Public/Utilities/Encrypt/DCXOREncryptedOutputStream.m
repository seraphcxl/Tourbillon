//
//  DCXOREncryptedOutputStream.m
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCXOREncryptedOutputStream.h"
#import "NSObject+DCUUIDExtension.h"
#import "DCLogger.h"

@interface DCXOREncryptedOutputStream () {
}

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSData *passwordData;

@end

@implementation DCXOREncryptedOutputStream

@synthesize password = _password;
@synthesize passwordData = _passwordData;

- (id)init {
    self = [super init];
    if (self) {
        _password = [NSObject createUniqueStrByUUID];
        _passwordData = [_password dataUsingEncoding:NSUTF8StringEncoding];
    }
    return self;
}

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
                NSUInteger len = [_passwordData length];
                NSInteger writtenLen = [super write:[_passwordData bytes] maxLength:len];
                DCAssert(writtenLen == len, @"Write password error!");
            }
        }
    } while (NO);
}

- (NSInteger)write:(const uint8_t *)buffer maxLength:(NSUInteger)len {
    NSUInteger result = 0;
    do {
        if (!buffer || len == 0) {
            break;
        }
        @synchronized (self) {
            uint8_t encryptedData[len];
            
            uint8_t *pw = (uint8_t *)[_passwordData bytes];
            NSUInteger pwLen = [_passwordData length];
            
            for (NSInteger idx = 0; idx < len; ++idx) {
                NSInteger pwIdx = ((idx >= pwLen) ? (idx - pwLen) : idx);
                encryptedData[idx] = buffer[idx] ^ pw[pwIdx];
            }
            
            result = [super write:encryptedData maxLength:len];
        }
    } while (NO);
    return result;
}

@end
