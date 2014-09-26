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

@property (nonatomic, strong) NSOutputStream *stream;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSData *passwordData;

@end

@implementation DCXOREncryptedOutputStream

@synthesize stream = _stream;
@synthesize password = _password;
@synthesize passwordData = _passwordData;

- (id)init {
    self = [super init];
    if (self) {
        _password = [NSObject createUniqueStrByUUID];
        _passwordData = [_password dataUsingEncoding:NSUTF8StringEncoding];
        self.stream = [[NSOutputStream alloc] initToMemory];
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

- (id)initToMemory {
    self = [self init];
    if (self) {
        ;
    }
    return self;
}

- (id)initToBuffer:(uint8_t *)buffer capacity:(NSUInteger)capacity {
    self = [self init];
    if (self) {
        self.stream = [[NSOutputStream alloc] initToBuffer:buffer capacity:capacity];
    }
    return self;
}

- (id)initToFileAtPath:(NSString *)path append:(BOOL)shouldAppend {
    self = [self init];
    if (self) {
        self.stream = [[NSOutputStream alloc] initToFileAtPath:path append:shouldAppend];
    }
    return self;
}

- (void)open {
    do {
        @synchronized (self) {
            if (!_stream || !_passwordData) {
                break;
            }
            
            [_stream open];
            
            NSUInteger len = [_passwordData length];
            NSInteger writtenLen = [_stream write:[_passwordData bytes] maxLength:len];
            DCAssert(writtenLen == len, @"Write password error!");
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

- (NSInteger)write:(const uint8_t *)buffer maxLength:(NSUInteger)len {
    NSUInteger result = 0;
    do {
        if (!buffer || len == 0) {
            break;
        }
        
        @synchronized (self) {
            if (!_stream || !_passwordData) {
                break;
            }
            
            uint8_t encryptedData[len];
            
            uint8_t *pw = (uint8_t *)[_passwordData bytes];
            NSUInteger pwLen = [_passwordData length];
            
            for (NSInteger idx = 0; idx < len; ++idx) {
                NSInteger pwIdx = ((idx >= pwLen) ? (idx % pwLen) : idx);
                encryptedData[idx] = buffer[idx] ^ pw[pwIdx];
            }
            
            result = [_stream write:encryptedData maxLength:len];
        }
    } while (NO);
    return result;
}

- (BOOL)hasSpaceAvailable {
    BOOL result = NO;
    do {
        @synchronized (self) {
            if (!_stream) {
                break;
            }
            
            result = [_stream hasSpaceAvailable];
        }
    } while (NO);
    return result;
}

@end
