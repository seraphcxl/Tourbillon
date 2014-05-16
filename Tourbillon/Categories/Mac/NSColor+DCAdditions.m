//
//  NSColor+DCAdditions.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "NSColor+DCAdditions.h"
#import "DCCommonConstants.h"
#import <QuartzCore/QuartzCore.h>

@implementation NSColor (DCAdditions)

+ (NSColor *)colorWithHexValue:(NSString *)hex {
    NSColor *result = nil;
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
            result = [NSColor colorWithCalibratedWhite:DC_RGB(r) alpha:DC_RGB(a)];
        } else {
            result = [NSColor colorWithCalibratedRed:DC_RGB(r) green:DC_RGB(g) blue:DC_RGB(b) alpha:DC_RGB(a)];
        }
    } while (NO);
    return result;
}

- (NSColor *)blackOrWhiteContrastingColor {
    NSColor *black = [NSColor blackColor];
    NSColor *white = [NSColor whiteColor];
    
    float blackDiff = [self luminosityDifference:black];
    float whiteDiff = [self luminosityDifference:white];
    
    return (blackDiff > whiteDiff) ? black : white;
}

- (CGFloat)luminosityDifference:(NSColor *)otherColor {
    CGFloat result = 0.0f;
    do {
        NSInteger numComponentsA = [self numberOfComponents];
        NSInteger numComponentsB = [otherColor numberOfComponents];
        
        if (numComponentsA == numComponentsB && numComponentsA == 4) {
            CGFloat *rgbA = NULL;
            CGFloat *rgbB = NULL;
            [self getComponents:rgbA];
            [otherColor getComponents:rgbB];
            
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

- (CGColorRef)cgColor {
    CGColorRef result = NULL;
    do {
        const NSInteger numberOfComponents = [self numberOfComponents];
        CGFloat components[numberOfComponents];
        CGColorSpaceRef colorSpace = [[self colorSpace] CGColorSpace];
        
        [self getComponents:(CGFloat *)&components];
        
#ifdef __OBJC_GC__
        result = (CGColorRef)CFMakeCollectable(CGColorCreate(colorSpace, components));
#else
        result = (CGColorRef)CGColorCreate(colorSpace, components);
#endif
    } while (NO);
    return result;
}

@end
