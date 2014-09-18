//
//  DCXOREncryptedInputStream.h
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCXOREncryptedInputStream : NSInputStream

@property (nonatomic, strong, readonly) NSString *password;

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len;

@end
