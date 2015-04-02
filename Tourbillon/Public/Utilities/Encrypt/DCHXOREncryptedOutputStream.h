//
//  DCHXOREncryptedOutputStream.h
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCHXOREncryptedOutputStream : NSObject

- (id)initToMemory;
- (id)initToBuffer:(uint8_t *)buffer capacity:(NSUInteger)capacity;
- (id)initToFileAtPath:(NSString *)path append:(BOOL)shouldAppend;

- (void)open;
- (void)close;

- (NSInteger)write:(const uint8_t *)buffer maxLength:(NSUInteger)len;
- (BOOL)hasSpaceAvailable;

@end
