//
//  DCGradientView.h
//  Tourbillon
//
//  Created by Derek Chen on 10/10/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DCGradientViewOrientation) {
    DCGradientViewOrientation_TopToBottom,
    DCGradientViewOrientation_BottomToTop,
    DCGradientViewOrientation_LeftToRight,
    DCGradientViewOrientation_RightToLeft,
    DCGradientViewOrientation_TopLeftToBottomRight,
    DCGradientViewOrientation_TopRightToBottomLeft,
    DCGradientViewOrientation_BottomLeftToTopRight,
    DCGradientViewOrientation_BottomRightToTopLeft,
};

@interface DCGradientView : UIView

@property (assign, nonatomic) DCGradientViewOrientation gradientOrientation;

@property (strong, nonatomic) UIColor *startColor;
@property (strong, nonatomic) UIColor *endColor;

@property (assign, nonatomic) CGFloat startColorLocation;
@property (assign, nonatomic) CGFloat endColorLocation;

@end
