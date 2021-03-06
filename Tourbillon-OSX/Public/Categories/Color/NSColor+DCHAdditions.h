//
//  NSColor+DCHAdditions.h
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (DCHAdditions)

+ (NSColor *)colorWithHexValue:(NSString *)hex;

- (NSColor *)blackOrWhiteContrastingColor;
- (CGFloat)luminosityDifference:(NSColor *)otherColor;

- (CGColorRef)cgColor;

+ (NSColor *)colorWithColor:(NSColor *)color andAlpha:(CGFloat)alpha;

- (BOOL)isEqualTo:(NSColor *)other bySingleVectorDiff:(CGFloat)singleVectorDiff andTotleDiff:(CGFloat)totleDiff;

@end
