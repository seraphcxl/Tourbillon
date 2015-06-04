//
//  NSNumber+DCHRandom.h
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (DCHRandom)

+ (NSNumber *)dch_randomUnsignedInt;
+ (NSNumber *)dch_randomUnsignedIntForm:(unsigned int)start range:(unsigned int)range;  // [start, (start + range - 1)]
+ (NSNumber *)dch_randomDoubleForm:(double)start range:(double)range;  // [start, (start + range)]

@end
