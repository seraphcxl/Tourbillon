//
//  NSData+DCHex.h
//  Tourbillon
//
//  Created by Derek Chen on 8/4/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DCHex)

- (NSString *)hex;
- (NSString *)hexLower;

- (NSString *)hexUseLower:(BOOL)isOutputLower;

@end
