//
//  UIColor+DCHAdditions.m
//  Tourbillon_iOS
//
//  Created by Derek Chen on 13-7-15.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "UIColor+DCHAdditions.h"
#import "DCHCommonConstants.h"
#import "DCHCommonFuncations.h"

@implementation UIColor (DCHAdditions)

+ (UIColor *)colorWithHexValue:(NSString *)hex {
    UIColor *result = nil;
    do {
        if (!hex) {
            break;
        }
        
        if ([hex hasPrefix:@"#"]) {
            hex = [hex substringFromIndex:1];
        }
        
        NSString *rStr = nil;
        NSString *gStr = nil;
        NSString *bStr = nil;
        NSString *aStr = nil;
        
        if (hex.length == 3) {
            rStr = [hex substringWithRange:NSMakeRange(0, 1)];
            rStr = [NSString stringWithFormat:@"%@%@", rStr, rStr];
            gStr = [hex substringWithRange:NSMakeRange(1, 1)];
            gStr = [NSString stringWithFormat:@"%@%@", gStr, gStr];
            bStr = [hex substringWithRange:NSMakeRange(2, 1)];
            bStr = [NSString stringWithFormat:@"%@%@", bStr, bStr];
            aStr = @"FF";
        } else if (hex.length == 4) {
            rStr = [hex substringWithRange:NSMakeRange(0, 1)];
            rStr = [NSString stringWithFormat:@"%@%@", rStr, rStr];
            gStr = [hex substringWithRange:NSMakeRange(1, 1)];
            gStr = [NSString stringWithFormat:@"%@%@", gStr, gStr];
            bStr = [hex substringWithRange:NSMakeRange(2, 1)];
            bStr = [NSString stringWithFormat:@"%@%@", bStr, bStr];
            aStr = [hex substringWithRange:NSMakeRange(3, 1)];
            aStr = [NSString stringWithFormat:@"%@%@", aStr, aStr];
        } else if (hex.length == 6) {
            rStr = [hex substringWithRange:NSMakeRange(0, 2)];
            gStr = [hex substringWithRange:NSMakeRange(2, 2)];
            bStr = [hex substringWithRange:NSMakeRange(4, 2)];
            aStr = @"FF";
        } else if (hex.length == 8) {
            rStr = [hex substringWithRange:NSMakeRange(0, 2)];
            gStr = [hex substringWithRange:NSMakeRange(2, 2)];
            bStr = [hex substringWithRange:NSMakeRange(4, 2)];
            aStr = [hex substringWithRange:NSMakeRange(6, 2)];
        } else {
            // Unknown encoding
            break;
        }
        
        unsigned r, g, b, a;
        [[NSScanner scannerWithString:rStr] scanHexInt:&r];
        [[NSScanner scannerWithString:gStr] scanHexInt:&g];
        [[NSScanner scannerWithString:bStr] scanHexInt:&b];
        [[NSScanner scannerWithString:aStr] scanHexInt:&a];
        
        if (r == g && g == b) {
            // Optimal case for grayscale
            result = [UIColor colorWithWhite:DCHRGBAConvert256ToPercentage(r) alpha:DCHRGBAConvert256ToPercentage(a)];
        } else {
            result = [UIColor colorWithRed:DCHRGBAConvert256ToPercentage(r) green:DCHRGBAConvert256ToPercentage(g) blue:DCHRGBAConvert256ToPercentage(b) alpha:DCHRGBAConvert256ToPercentage(a)];
        }
    } while (NO);
    return result;
}

- (UIColor *)blackOrWhiteContrastingColor {
    UIColor *black = [UIColor blackColor];
    UIColor *white = [UIColor whiteColor];
    
    float blackDiff = [self luminosityDifference:black];
    float whiteDiff = [self luminosityDifference:white];
    
    return (blackDiff > whiteDiff) ? black : white;
}

- (CGFloat)luminosityDifference:(UIColor *)otherColor {
    CGFloat result = 0.0f;
    do {
        NSInteger numComponentsA = CGColorGetNumberOfComponents(self.CGColor);
        NSInteger numComponentsB = CGColorGetNumberOfComponents(otherColor.CGColor);

        if (numComponentsA == numComponentsB && numComponentsA == 4) {
            const CGFloat *rgbA = CGColorGetComponents(self.CGColor);
            const CGFloat *rgbB = CGColorGetComponents(otherColor.CGColor);
            
            CGFloat l1 = 0.2126 * pow(rgbA[0], 2.2f) + 0.7152 * pow(rgbA[1], 2.2f) + 0.0722 * pow(rgbA[2], 2.2f);
            CGFloat l2 = 0.2126 * pow(rgbB[0], 2.2f) + 0.7152 * pow(rgbB[1], 2.2f) + 0.0722 * pow(rgbB[2], 2.2f);
            
            if (l1 > l2) {
                result = (l1 + 0.05f) / (l2 / 0.05f);
            } else {
                result = (l2 + 0.05f) / (l1 / 0.05f);
            }
        } else {
            break;
        }
    } while (NO);
    return result;
}

+ (UIColor *)colorWithColor:(UIColor *)color andAlpha:(CGFloat)alpha {
    UIColor *result = nil;
    do {
        if (!color) {
            break;
        }
        if (alpha < 0) {
            alpha = 0;
        }
        if (alpha > 1) {
            alpha = 1;
        }
        CGFloat components[4] = {0.0, 0.0, 0.0, 0.0};
        [color getRed:&components[0] green:&components[1] blue:&components[2] alpha:&components[3]];
        result = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:alpha];
    } while (NO);
    return result;
}

@end
