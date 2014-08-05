//
//  UIColor+DCColorful.m
//  Tourbillon
//
//  Created by Derek Chen on 7/2/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "UIColor+DCColorful.h"
#import "DCCommonConstants.h"

@implementation UIColor (DCColorful)

+ (UIColor *)aluminumColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(153.0f) green:DC_RGB256(153.0f) blue:DC_RGB256(153.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)aquaColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(128.0f) blue:DC_RGB256(255.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)asparagusColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(128.0f) green:DC_RGB256(128.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)bananaColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(255.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(102.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)blueberryColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(0.0f) blue:DC_RGB256(255.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)bubblegumColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(255.0f) green:DC_RGB256(102.0f) blue:DC_RGB256(255.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)cantaloupeColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(255.0f) green:DC_RGB256(204.0f) blue:DC_RGB256(102.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)carnationColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(255.0f) green:DC_RGB256(111.0f) blue:DC_RGB256(207.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)cayenneColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(128.0f) green:DC_RGB256(0.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)cloverColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(128.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)eggplantColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(64.0f) green:DC_RGB256(0.0f) blue:DC_RGB256(128.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)fernColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(64.0f) green:DC_RGB256(128.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)floraColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(102.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(102.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)grapeColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(128.0f) green:DC_RGB256(0.0f) blue:DC_RGB256(255.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)honeydewColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(204.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(102.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)iceColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(102.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(255.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)ironColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(76.0f) green:DC_RGB256(76.0f) blue:DC_RGB256(76.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)lavenderColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(204.0f) green:DC_RGB256(102.0f) blue:DC_RGB256(255.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)leadColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(25.0f) green:DC_RGB256(25.0f) blue:DC_RGB256(25.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)lemonColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(255.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)licoriceColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(0.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)limeColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(128.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)magnesiumColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(179.0f) green:DC_RGB256(179.0f) blue:DC_RGB256(179.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)maraschinoColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(255.0f) green:DC_RGB256(0.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)maroonColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(128.0f) green:DC_RGB256(0.0f) blue:DC_RGB256(64.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)midnightColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(0.0f) blue:DC_RGB256(128.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)mochaColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(128.0f) green:DC_RGB256(64.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)mossColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(128.0f) blue:DC_RGB256(64.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)murcuryColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(230.0f) green:DC_RGB256(230.0f) blue:DC_RGB256(230.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)nickelColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(128.0f) green:DC_RGB256(128.0f) blue:DC_RGB256(128.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)oceanColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(64.0f) blue:DC_RGB256(128.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)orchidColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(102.0f) green:DC_RGB256(102.0f) blue:DC_RGB256(255.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)plumColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(128.0f) green:DC_RGB256(0.0f) blue:DC_RGB256(128.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)salmonColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(255.0f) green:DC_RGB256(102.0f) blue:DC_RGB256(102.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)seaFoamColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(128.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)silverColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(204.0f) green:DC_RGB256(204.0f) blue:DC_RGB256(204.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)skyColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(102.0f) green:DC_RGB256(204.0f) blue:DC_RGB256(255.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)snowColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(255.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(255.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)spindriftColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(102.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(204.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)springColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)steelColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(102.0f) green:DC_RGB256(102.0f) blue:DC_RGB256(102.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)strawberryColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(255.0f) green:DC_RGB256(0.0f) blue:DC_RGB256(105.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)tangerineColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(255.0f) green:DC_RGB256(128.0f) blue:DC_RGB256(0.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)tealColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(128.0f) blue:DC_RGB256(128.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)tinColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(127.0f) green:DC_RGB256(127.0f) blue:DC_RGB256(127.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)tungstenColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(51.0f) green:DC_RGB256(51.0f) blue:DC_RGB256(51.0f) alpha:1.0f];
    });
    return color;
}

+ (UIColor *)turquoiseColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:DC_RGB256(0.0f) green:DC_RGB256(255.0f) blue:DC_RGB256(255.0f) alpha:1.0f];
    });
    return color;
}

@end
