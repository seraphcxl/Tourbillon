//
//  DCGradientView.m
//  Tourbillon
//
//  Created by Derek Chen on 10/10/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCGradientView.h"
#import "DCCommonConstants.h"

@implementation DCGradientView

@synthesize gradientOrientation = _gradientOrientation;
@synthesize opacity = _opacity;
@synthesize fillSize = _fillSize;

- (id)init {
    self = [super init];
    if (self) {
        self.gradientOrientation = DCGradientViewOrientation_Radial;
        self.opacity = DCGradientViewOpacity_Normal;
        self.fillSize = DCGradientViewFillSize_Small;
        [self setColor:[UIColor blackColor]];
    }
    return self;
}

- (void)awakeFromNib {
    do {
//        self.gradientOrientation = DCGradientViewOrientation_Radial;
//        self.opacity = DCGradientViewOpacity_Light;
//        self.fillSize = DCGradientViewFillSize_Small;
//        [self setColor:[UIColor blackColor]];
    } while (NO);
}

- (void)setColor:(UIColor *)newColor {
    do {
        if (!newColor) {
            break;
        }
        CGFloat new[4] = {1.0, 1.0, 1.0, 0.0};
        [newColor getRed:&new[0] green:&new[1] blue:&new[2] alpha:&new[3]];
        if (DCFloatingNumberEqual(new[3], 1.0f)) {
            new[3] = 0.999f;
        }
        self.backgroundColor = [UIColor colorWithRed:new[0] green:new[1] blue:new[2] alpha:new[3]];
        [self setNeedsDisplay];
    } while (NO);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGImageRef contextImg = nil;
    CGColorSpaceRef colorSpace = nil;
    CGGradientRef gradientRef = nil;
    CGImageRef maskImage = nil;
    CGImageRef mask = nil;
    CGImageRef maskedImage = nil;
    do {
        [super drawRect:rect];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        contextImg = CGBitmapContextCreateImage(context);
        
        CGContextClearRect(context, rect);
        
        CGContextSaveGState(context);
        
        // flip the context (right-sideup)
        CGContextTranslateCTM(context, 0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        colorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGFloat alpha = 0.0f;
        switch (self.opacity) {
            case DCGradientViewOpacity_Light:
            {
                alpha = 1.0f;
            }
                break;
            case DCGradientViewOpacity_Normal:
            {
                alpha = 0.7f;
            }
                break;
            case DCGradientViewOpacity_Dark:
            {
                alpha = 0.4f;
            }
                break;
        }
        
        UIColor *startColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
        UIColor *endColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
        CGFloat start[4] = {1.0, 1.0, 1.0, 0.0};
        CGFloat end[4] = {1.0, 1.0, 1.0, 0.0};
        
        if (![startColor getRed:&start[0] green:&start[1] blue:&start[2] alpha:&start[3]]) {
            ;
        }
        
        if (![endColor getRed:&end[0] green:&end[1] blue:&end[2] alpha:&end[3]]) {
            ;
        }
        
        CGFloat components[8] = {
            start[0], start[1], start[2], start[3],
            end[0], end[1], end[2], end[3],
        };
        CGFloat endColorLocation = 1.0f;
        switch (self.fillSize) {
            case DCGradientViewFillSize_Small:
            {
                endColorLocation = 0.95f;
            }
                break;
            case DCGradientViewFillSize_Big:
            {
                endColorLocation = 0.75f;
            }
                break;
        }
        CGFloat colorLocations[2] = {0.0f, endColorLocation};
        gradientRef = CGGradientCreateWithColorComponents(colorSpace, components, colorLocations, 2);
        
        switch (self.gradientOrientation) {
            case DCGradientViewOrientation_Radial:
            {
                CGPoint centerPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2.0f, self.bounds.origin.y + self.bounds.size.height / 2.0f);
                CGFloat startRadius = 0.0f;
                CGFloat endRadius = sqrtf(powf(self.bounds.size.width, 2) + powf(self.bounds.size.height, 2)) / 2.0f;
                CGContextDrawRadialGradient(context, gradientRef, centerPoint, startRadius, centerPoint, endRadius, 0);
            }
                break;
            case DCGradientViewOrientation_OneWay_TopToBottom:
            {
                CGPoint startPoint = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
                CGPoint endPoint = self.bounds.origin;
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
            }
                break;
            case DCGradientViewOrientation_OneWay_BottomToTop:
            {
                CGPoint startPoint = self.bounds.origin;
                CGPoint endPoint = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
            }
                break;
            case DCGradientViewOrientation_OneWay_LeftToRight:
            {
                CGPoint startPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
                CGPoint endPoint = self.bounds.origin;
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
            }
                break;
            case DCGradientViewOrientation_OneWay_RightToLeft:
            {
                CGPoint startPoint = self.bounds.origin;
                CGPoint endPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
            }
                break;
            case DCGradientViewOrientation_OneWay_TopLeftToBottomRight:
            {
                CGPoint startPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height);
                CGPoint endPoint = self.bounds.origin;
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
            }
                break;
            case DCGradientViewOrientation_OneWay_TopRightToBottomLeft:
            {
                CGPoint startPoint = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
                CGPoint endPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
            }
                break;
            case DCGradientViewOrientation_OneWay_BottomLeftToTopRight:
            {
                CGPoint startPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
                CGPoint endPoint = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
            }
                break;
            case DCGradientViewOrientation_OneWay_BottomRightToTopLeft:
            {
                CGPoint startPoint = self.bounds.origin;
                CGPoint endPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
            }
                break;
            case DCGradientViewOrientation_TwoWay_Horizontal:
            {
                CGPoint startPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2.0f, self.bounds.origin.y);
                CGPoint endPoint1 = self.bounds.origin;
                CGPoint endPoint2 = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint1, 0);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint2, 0);
            }
                break;
            case DCGradientViewOrientation_TwoWay_Vertical:
            {
                CGPoint startPoint = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height / 2.0f);
                CGPoint endPoint1 = self.bounds.origin;
                CGPoint endPoint2 = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint1, 0);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint2, 0);
            }
                break;
            case DCGradientViewOrientation_TwoWay_TopLeftTilt:
            {
                CGPoint startPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2.0f, self.bounds.origin.y + self.bounds.size.height / 2.0f);
                CGPoint endPoint1 = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height);
                CGPoint endPoint2 = self.bounds.origin;
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint1, 0);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint2, 0);
            }
                break;
            case DCGradientViewOrientation_TwoWay_TopRightTilt:
            {
                CGPoint startPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2.0f, self.bounds.origin.y + self.bounds.size.height / 2.0f);
                CGPoint endPoint1 = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
                CGPoint endPoint2 = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint1, 0);
                CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint2, 0);
            }
                break;
        }
        
        if (gradientRef) {
            CGGradientRelease(gradientRef);
            gradientRef = nil;
        }
        if (colorSpace) {
            CGColorSpaceRelease(colorSpace);
            colorSpace = nil;
        }
        
        CGContextRestoreGState(context);
        
        maskImage = CGBitmapContextCreateImage(context);
        mask = CGImageMaskCreate(CGImageGetWidth(maskImage), CGImageGetHeight(maskImage), CGImageGetBitsPerComponent(maskImage), CGImageGetBitsPerPixel(maskImage), CGImageGetBytesPerRow(maskImage), CGImageGetDataProvider(maskImage), NULL, FALSE);
        maskedImage = CGImageCreateWithMask(contextImg, mask);
        
        if (contextImg) {
            CGImageRelease(contextImg);
            contextImg = nil;
        }
        
        CGContextClearRect(context, rect);
        
        if (maskImage) {
            CGImageRelease(maskImage);
            maskImage = nil;
        }
        if (mask) {
            CGImageRelease(mask);
            mask = nil;
        }
        
        CGContextDrawImage(context, rect, maskedImage);
        
    } while (NO);
    if (maskedImage) {
        CGImageRelease(maskedImage);
        maskedImage = nil;
    }
    
    if (mask) {
        CGImageRelease(mask);
        mask = nil;
    }
    
    if (maskImage) {
        CGImageRelease(maskImage);
        maskImage = nil;
    }
    
    if (gradientRef) {
        CGGradientRelease(gradientRef);
        gradientRef = nil;
    }
    
    if (colorSpace) {
        CGColorSpaceRelease(colorSpace);
        colorSpace = nil;
    }
    
    if (contextImg) {
        CGImageRelease(contextImg);
        contextImg = nil;
    }
}

@end
