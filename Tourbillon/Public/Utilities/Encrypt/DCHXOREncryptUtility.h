//
//  DCXOREncryptUtility.h
//  Tourbillon
//
//  Created by Derek Chen on 9/26/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCXOREncryptUtility : NSObject

+ (BOOL)encryptFile:(NSString *)source toPath:(NSString *)dest withBlockLength:(NSUInteger)len;
+ (BOOL)decryptFile:(NSString *)source toPath:(NSString *)dest withBlockLength:(NSUInteger)len;

@end
