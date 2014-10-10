//
//  DCGradientView.m
//  Tourbillon
//
//  Created by Derek Chen on 10/10/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCGradientView.h"

@implementation DCGradientView

@synthesize gradientOrientation = _gradientOrientation;
@synthesize startColor = _startColor;
@synthesize endColor = _endColor;
@synthesize startColorLocation = _startColorLocation;
@synthesize endColorLocation = _endColorLocation;

- (id)init {
    self = [super init];
    if (self) {
        self.gradientOrientation = DCGradientViewOrientation_TopToBottom;
        self.startColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.endColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
        self.startColorLocation = 0;
        self.endColorLocation = 1;
    }
    return self;
}

- (void)awakeFromNib {
    do {
        self.gradientOrientation = DCGradientViewOrientation_TopToBottom;
        self.startColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.endColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
        self.startColorLocation = 0;
        self.endColorLocation = 1;
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
        
        CGFloat start[4] = {1.0, 1.0, 1.0, 0.0};
        CGFloat end[4] = {1.0, 1.0, 1.0, 0.0};
        
        if (![self.startColor getRed:&start[0] green:&start[1] blue:&start[2] alpha:&start[3]]) {
            ;
        }
        
        if (![self.endColor getRed:&end[0] green:&end[1] blue:&end[2] alpha:&end[3]]) {
            ;
        }
        
        CGFloat components[8] = {
            start[0], start[1], start[2], start[3],
            end[0], end[1], end[2], end[3],
        };
        
        CGFloat colorLocations[2] = {self.startColorLocation, self.endColorLocation};
        gradientRef = CGGradientCreateWithColorComponents(colorSpace, components, colorLocations, 2);
        
        CGPoint startPoint = CGPointMake(0, 0);
        CGPoint endPoint = CGPointMake(0, 0);
        switch (self.gradientOrientation) {
            case DCGradientViewOrientation_TopToBottom:
            {
                startPoint = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
                endPoint = self.bounds.origin;
            }
                break;
            case DCGradientViewOrientation_BottomToTop:
            {
                startPoint = self.bounds.origin;
                endPoint = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
            }
                break;
            case DCGradientViewOrientation_LeftToRight:
            {
                startPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
                endPoint = self.bounds.origin;
            }
                break;
            case DCGradientViewOrientation_RightToLeft:
            {
                startPoint = self.bounds.origin;
                endPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
            }
                break;
            case DCGradientViewOrientation_TopLeftToBottomRight:
            {
                startPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height);
                endPoint = self.bounds.origin;
            }
                break;
            case DCGradientViewOrientation_TopRightToBottomLeft:
            {
                startPoint = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
                endPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
            }
                break;
            case DCGradientViewOrientation_BottomLeftToTopRight:
            {
                startPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
                endPoint = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
            }
                break;
            case DCGradientViewOrientation_BottomRightToTopLeft:
            {
                startPoint = self.bounds.origin;
                endPoint = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height);
            }
                break;
            default:
            {
                ;
            }
                break;
        }
        
        CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
        
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
