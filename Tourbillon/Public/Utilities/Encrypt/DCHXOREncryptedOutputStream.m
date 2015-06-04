//
//  DCHXOREncryptedOutputStream.m
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCHXOREncryptedOutputStream.h"
#import "DCHCommonConstants.h"
#import "NSObject+DCHUUIDExtension.h"
#import "NSString+DCHHash.h"

@interface DCHXOREncryptedOutputStream () {
}

@property (nonatomic, strong) NSOutputStream *stream;
@property (nonatomic, strong) NSString *pwSHA1;
@property (nonatomic, strong) NSData *passwordData;
@property (nonatomic, assign) NSUInteger pwIndex;

@end

@implementation DCHXOREncryptedOutputStream

@synthesize stream = _stream;
@synthesize pwSHA1 = _pwSHA1;
@synthesize passwordData = _passwordData;
@synthesize pwIndex = _pwIndex;

- (id)init {
    self = [super init];
    if (self) {
        _pwSHA1 = [[NSObject dch_createUUID] dch_shaStringWithType:DCHSHAType_SHA1];
        _passwordData = [[_pwSHA1 dch_shaStringWithType:DCHSHAType_SHA1] dataUsingEncoding:NSUTF8StringEncoding];
        self.stream = [[NSOutputStream alloc] initToMemory];
    }
    return self;
}

- (void)dealloc {
    do {
        _pwIndex = 0;
        self.stream = nil;
        self.passwordData = nil;
        self.pwSHA1 = nil;
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
            
            NSData *pwSHA1Data = [_pwSHA1 dataUsingEncoding:NSUTF8StringEncoding];
            NSUInteger pwSHA1len = [pwSHA1Data length];
            uint8_t *pwSHA1 = (uint8_t *)[pwSHA1Data bytes];
            
            NSUInteger blockCount = 8;
            NSUInteger lapCount = blockCount / 2;
            NSUInteger sha1BlockLen = pwSHA1len / blockCount;
            
            NSInteger writtenLen = 0;
            NSUInteger cursor = sha1BlockLen * lapCount;
            for (NSUInteger idx = 0; idx < lapCount; ++idx) {
                writtenLen = [_stream write:&pwSHA1[idx * sha1BlockLen] maxLength:sha1BlockLen];
                DCHAssert(writtenLen == sha1BlockLen, @"Write password error!");
                
                writtenLen = [_stream write:&pwSHA1[idx * sha1BlockLen + cursor] maxLength:sha1BlockLen];
                DCHAssert(writtenLen == sha1BlockLen, @"Write password error!");
            }
            
            _pwIndex = 0;
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
            
            _pwIndex = 0;
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
            
            if (pw == NULL || pwLen == 0) {
                break;
            }
            
            NSUInteger pwStartIdx = _pwIndex;
            for (NSInteger idx = 0; idx < len; ++idx) {
                _pwIndex = idx + pwStartIdx;
                if (_pwIndex >= pwLen) {
                    _pwIndex %= pwLen;
                }
                encryptedData[idx] = buffer[idx] ^ pw[_pwIndex];
            }
            ++_pwIndex;
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
