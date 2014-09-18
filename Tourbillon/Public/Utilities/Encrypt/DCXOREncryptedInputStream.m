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

@property (nonatomic, strong) NSInputStream *stream;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSData *passwordData;

@end

@implementation DCXOREncryptedInputStream

@synthesize stream = _stream;
@synthesize password = _password;
@synthesize passwordData = _passwordData;

- (id)initWithData:(NSData *)data {
    self = [self init];
    if (self) {
        self.stream = [NSInputStream inputStreamWithData:data];
    }
    return self;
}

- (id)initWithFileAtPath:(NSString *)path {
    self = [self init];
    if (self) {
        self.stream = [NSInputStream inputStreamWithFileAtPath:path];
    }
    return self;
}

- (void)dealloc {
    do {
        self.stream = nil;
        self.passwordData = nil;
        self.password = nil;
    } while (NO);
}

- (void)open {
    do {
        @synchronized (self) {
            if (!_stream) {
                break;
            }
            
            [_stream open];
            
            self.passwordData = nil;
            self.password = nil;
            
            NSUInteger len = [[[NSObject createUniqueStrByUUID] dataUsingEncoding:NSUTF8StringEncoding] length];
            uint8_t pwData[len];
            NSUInteger resultLen = [_stream read:pwData maxLength:len];
            DCAssert(resultLen == len, @"Read password error!");
            
            _passwordData = [NSData dataWithBytes:pwData length:len];
            _password = [[NSString alloc] initWithData:_passwordData encoding:NSUTF8StringEncoding];
        }
    } while (NO);
}

- (void)close {
    do {
        @synchronized (self) {
            if (!_stream) {
                break;
            }
            
            [_stream close];
        }
    } while (NO);
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len {
    NSUInteger result = 0;
    do {
        if (!buffer || len == 0) {
            break;
        }
        
        @synchronized (self) {
            if (!_stream || !_passwordData) {
                break;
            }
            
            uint8_t tmpBuffer[len];
            NSInteger tmpReadCount = [_stream read:tmpBuffer maxLength:len];
            DCAssert(tmpReadCount <= len, @"Read too much data!");
            
            uint8_t *pw = (uint8_t *)[_passwordData bytes];
            NSUInteger pwLen = [_passwordData length];
            
            for (NSInteger idx = 0; idx < tmpReadCount; ++idx) {
                NSInteger pwIdx = ((idx >= pwLen) ? (idx - pwLen) : idx);
                buffer[idx] = tmpBuffer[idx] ^ pw[pwIdx];
            }
            
            result = tmpReadCount;
        }
    } while (NO);
    return result;
}

- (BOOL)hasBytesAvailable {
    BOOL result = NO;
    do {
        @synchronized (self) {
            if (!_stream) {
                break;
            }
            
            result = [_stream hasBytesAvailable];
        }
    } while (NO);
    return result;
}

@end
