//
//  NSNumber+DCHRandom.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "NSNumber+DCHRandom.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation NSNumber (DCHRandom)

+ (NSNumber *)dch_randomUnsignedInt {
    return [NSNumber numberWithUnsignedInt:arc4random()];
}

+ (NSNumber *)dch_randomUnsignedIntForm:(unsigned int)start range:(unsigned int)range {
    return [NSNumber numberWithUnsignedInt:((arc4random() % range) + start)];
}

+ (NSNumber *)dch_randomDoubleForm:(double)start range:(double)range {
    return [NSNumber numberWithDouble:(floor(((double)arc4random() / ARC4RANDOM_MAX) * 100.0f) + start)];
}

@end
