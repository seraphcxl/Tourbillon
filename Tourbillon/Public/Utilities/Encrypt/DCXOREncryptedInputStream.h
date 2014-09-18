//
//  DCXOREncryptedInputStream.h
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCXOREncryptedInputStream : NSObject

@property (nonatomic, strong, readonly) NSString *password;

- (id)initWithData:(NSData *)data;
- (id)initWithFileAtPath:(NSString *)path;

- (void)open;
- (void)close;

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len;
- (BOOL)hasBytesAvailable;

@end
