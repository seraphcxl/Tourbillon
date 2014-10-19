//
//  DCGradientView.h
//  Tourbillon
//
//  Created by Derek Chen on 10/10/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DCGradientViewOrientation) {
    DCGradientViewOrientation_Radial,
    
    DCGradientViewOrientation_OneWay_TopToBottom,
    DCGradientViewOrientation_OneWay_BottomToTop,
    DCGradientViewOrientation_OneWay_LeftToRight,
    DCGradientViewOrientation_OneWay_RightToLeft,
    DCGradientViewOrientation_OneWay_TopLeftToBottomRight,
    DCGradientViewOrientation_OneWay_TopRightToBottomLeft,
    DCGradientViewOrientation_OneWay_BottomLeftToTopRight,
    DCGradientViewOrientation_OneWay_BottomRightToTopLeft,
    
    DCGradientViewOrientation_TwoWay_Horizontal,
    DCGradientViewOrientation_TwoWay_Vertical,
    DCGradientViewOrientation_TwoWay_TopLeftTilt,
    DCGradientViewOrientation_TwoWay_TopRightTilt,
};

typedef NS_ENUM(NSUInteger, DCGradientViewOpacity) {
    DCGradientViewOpacity_Light,
    DCGradientViewOpacity_Normal,
    DCGradientViewOpacity_Dark,
};

typedef NS_ENUM(NSUInteger, DCGradientViewFillSize) {
    DCGradientViewFillSize_Small,
    DCGradientViewFillSize_Big,
};

@interface DCGradientView : UIView

@property (assign, nonatomic) DCGradientViewOrientation gradientOrientation;
@property (assign, nonatomic) DCGradientViewOpacity opacity;
@property (assign, nonatomic) DCGradientViewFillSize fillSize;

- (void)setColor:(UIColor *)newColor;

@end
