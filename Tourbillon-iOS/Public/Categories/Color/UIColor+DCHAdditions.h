//
//  UIColor+DCHAdditions.h
//  Tourbillon_iOS
//
//  Created by Derek Chen on 13-7-15.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DCHAdditions)

+ (UIColor *)colorWithHexValue:(NSString *)hex;

- (UIColor *)blackOrWhiteContrastingColor;
- (CGFloat)luminosityDifference:(UIColor *)otherColor;

@end
