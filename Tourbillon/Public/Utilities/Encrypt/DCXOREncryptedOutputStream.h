//
//  DCXOREncryptedOutputStream.h
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCXOREncryptedOutputStream : NSOutputStream

@property (nonatomic, strong, readonly) NSString *password;

- (NSInteger)write:(const uint8_t *)buffer maxLength:(NSUInteger)len;

@end
