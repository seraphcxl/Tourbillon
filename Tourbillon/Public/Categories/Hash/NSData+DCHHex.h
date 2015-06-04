//
//  NSData+DCHHex.h
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DCHHex)

- (NSString *)dch_hex;
- (NSString *)dch_hexLower;

- (NSString *)dch_hexUseLower:(BOOL)isOutputLower;

@end
