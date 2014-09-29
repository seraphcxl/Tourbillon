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
#import "NSString+DCHash.h"

@interface DCXOREncryptedInputStream () {
}

@property (nonatomic, strong) NSInputStream *stream;
@property (nonatomic, strong) NSString *pwSHA1;
@property (nonatomic, strong) NSData *passwordData;
@property (nonatomic, assign) NSUInteger pwIndex;

@end

@implementation DCXOREncryptedInputStream

@synthesize stream = _stream;
@synthesize pwSHA1 = _pwSHA1;
@synthesize passwordData = _passwordData;
@synthesize pwIndex = _pwIndex;

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
        _pwIndex = 0;
        self.stream = nil;
        self.passwordData = nil;
        self.pwSHA1 = nil;
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
            self.pwSHA1 = nil;
            
            NSUInteger pwSHA1len = [[[[NSObject createUniqueStrByUUID] shaStringWithType:DCSHAType_SHA1] dataUsingEncoding:NSUTF8StringEncoding] length];
            NSMutableData *pwSHA1DataLeft = [NSMutableData data];
            NSMutableData *pwSHA1DataRight = [NSMutableData data];
            
            NSUInteger blockCount = 8;
            NSUInteger lapCount = blockCount / 2;
            NSUInteger sha1BlockLen = pwSHA1len / blockCount;
            uint8_t pwSHA1DataAry[sha1BlockLen];
            
            NSUInteger readLen = 0;
            for (NSUInteger idx = 0; idx < lapCount; ++idx) {
                readLen = [_stream read:pwSHA1DataAry maxLength:sha1BlockLen];
                DCAssert(readLen == sha1BlockLen, @"Read password error!");
                [pwSHA1DataLeft appendBytes:pwSHA1DataAry length:sha1BlockLen];
                
                readLen = [_stream read:pwSHA1DataAry maxLength:sha1BlockLen];
                DCAssert(readLen == sha1BlockLen, @"Read password error!");
                [pwSHA1DataRight appendBytes:pwSHA1DataAry length:sha1BlockLen];
            }
            
            NSMutableData *pwSHA1Data = [NSMutableData dataWithData:pwSHA1DataLeft];
            [pwSHA1Data appendData:pwSHA1DataRight];
            
            _pwSHA1 = [[NSString alloc] initWithData:pwSHA1Data encoding:NSUTF8StringEncoding];
            _passwordData = [[_pwSHA1 shaStringWithType:DCSHAType_SHA1] dataUsingEncoding:NSUTF8StringEncoding];
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
            
            if (pw == NULL || pwLen == 0) {
                break;
            }
            
            NSUInteger pwStartIdx = _pwIndex;
            for (NSInteger idx = 0; idx < tmpReadCount; ++idx) {
                _pwIndex = idx + pwStartIdx;
                if (_pwIndex >= pwLen) {
                    _pwIndex %= pwLen;
                }
                buffer[idx] = tmpBuffer[idx] ^ pw[_pwIndex];
            }
            ++_pwIndex;
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
