//
//  NSColor+DCHColorful.m
//  Tourbillon
//
//  Created by Derek Chen on 7/1/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSColor+DCHColorful.h"
#import "DCHCommonConstants.h"
#import "DCHCommonFuncations.h"

@implementation NSColor (DCHColorful)

+ (NSColor *)aluminumColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(153.0f) green:DCHRGBAConvert256ToPercentage(153.0f) blue:DCHRGBAConvert256ToPercentage(153.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)aquaColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(128.0f) blue:DCHRGBAConvert256ToPercentage(255.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)asparagusColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(128.0f) green:DCHRGBAConvert256ToPercentage(128.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)bananaColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(255.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(102.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)blueberryColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(0.0f) blue:DCHRGBAConvert256ToPercentage(255.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)bubblegumColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(255.0f) green:DCHRGBAConvert256ToPercentage(102.0f) blue:DCHRGBAConvert256ToPercentage(255.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)cantaloupeColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(255.0f) green:DCHRGBAConvert256ToPercentage(204.0f) blue:DCHRGBAConvert256ToPercentage(102.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)carnationColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(255.0f) green:DCHRGBAConvert256ToPercentage(111.0f) blue:DCHRGBAConvert256ToPercentage(207.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)cayenneColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(128.0f) green:DCHRGBAConvert256ToPercentage(0.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)cloverColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(128.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)eggplantColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(64.0f) green:DCHRGBAConvert256ToPercentage(0.0f) blue:DCHRGBAConvert256ToPercentage(128.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)fernColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(64.0f) green:DCHRGBAConvert256ToPercentage(128.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)floraColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(102.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(102.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)grapeColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(128.0f) green:DCHRGBAConvert256ToPercentage(0.0f) blue:DCHRGBAConvert256ToPercentage(255.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)honeydewColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(204.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(102.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)iceColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(102.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(255.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)ironColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(76.0f) green:DCHRGBAConvert256ToPercentage(76.0f) blue:DCHRGBAConvert256ToPercentage(76.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)lavenderColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(204.0f) green:DCHRGBAConvert256ToPercentage(102.0f) blue:DCHRGBAConvert256ToPercentage(255.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)leadColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(25.0f) green:DCHRGBAConvert256ToPercentage(25.0f) blue:DCHRGBAConvert256ToPercentage(25.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)lemonColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(255.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)licoriceColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(0.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)limeColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(128.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)magnesiumColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(179.0f) green:DCHRGBAConvert256ToPercentage(179.0f) blue:DCHRGBAConvert256ToPercentage(179.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)maraschinoColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(255.0f) green:DCHRGBAConvert256ToPercentage(0.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)maroonColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(128.0f) green:DCHRGBAConvert256ToPercentage(0.0f) blue:DCHRGBAConvert256ToPercentage(64.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)midnightColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(0.0f) blue:DCHRGBAConvert256ToPercentage(128.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)mochaColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(128.0f) green:DCHRGBAConvert256ToPercentage(64.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)mossColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(128.0f) blue:DCHRGBAConvert256ToPercentage(64.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)murcuryColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(230.0f) green:DCHRGBAConvert256ToPercentage(230.0f) blue:DCHRGBAConvert256ToPercentage(230.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)nickelColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(128.0f) green:DCHRGBAConvert256ToPercentage(128.0f) blue:DCHRGBAConvert256ToPercentage(128.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)oceanColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(64.0f) blue:DCHRGBAConvert256ToPercentage(128.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)orchidColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(102.0f) green:DCHRGBAConvert256ToPercentage(102.0f) blue:DCHRGBAConvert256ToPercentage(255.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)plumColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(128.0f) green:DCHRGBAConvert256ToPercentage(0.0f) blue:DCHRGBAConvert256ToPercentage(128.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)salmonColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(255.0f) green:DCHRGBAConvert256ToPercentage(102.0f) blue:DCHRGBAConvert256ToPercentage(102.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)seaFoamColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(128.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)silverColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(204.0f) green:DCHRGBAConvert256ToPercentage(204.0f) blue:DCHRGBAConvert256ToPercentage(204.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)skyColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(102.0f) green:DCHRGBAConvert256ToPercentage(204.0f) blue:DCHRGBAConvert256ToPercentage(255.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)snowColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(255.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(255.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)spindriftColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(102.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(204.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)springColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)steelColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(102.0f) green:DCHRGBAConvert256ToPercentage(102.0f) blue:DCHRGBAConvert256ToPercentage(102.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)strawberryColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(255.0f) green:DCHRGBAConvert256ToPercentage(0.0f) blue:DCHRGBAConvert256ToPercentage(105.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)tangerineColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(255.0f) green:DCHRGBAConvert256ToPercentage(128.0f) blue:DCHRGBAConvert256ToPercentage(0.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)tealColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(128.0f) blue:DCHRGBAConvert256ToPercentage(128.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)tinColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(127.0f) green:DCHRGBAConvert256ToPercentage(127.0f) blue:DCHRGBAConvert256ToPercentage(127.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)tungstenColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(51.0f) green:DCHRGBAConvert256ToPercentage(51.0f) blue:DCHRGBAConvert256ToPercentage(51.0f) alpha:1.0f];
    });
    return color;
}

+ (NSColor *)turquoiseColor {
    static NSColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [NSColor colorWithDeviceRed:DCHRGBAConvert256ToPercentage(0.0f) green:DCHRGBAConvert256ToPercentage(255.0f) blue:DCHRGBAConvert256ToPercentage(255.0f) alpha:1.0f];
    });
    return color;
}

+ (NSArray *)DCH_colorfulArray {
    static NSArray *colorfulArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colorfulArray = @[[NSColor aluminumColor]
                          , [NSColor aquaColor]
                          , [NSColor asparagusColor]
                          , [NSColor bananaColor]
                          , [NSColor blueberryColor]
                          , [NSColor bubblegumColor]
                          , [NSColor cantaloupeColor]
                          , [NSColor carnationColor]
                          , [NSColor cayenneColor]
                          , [NSColor cloverColor]
                          , [NSColor eggplantColor]
                          , [NSColor fernColor]
                          , [NSColor floraColor]
                          , [NSColor grapeColor]
                          , [NSColor honeydewColor]
                          , [NSColor iceColor]
                          , [NSColor ironColor]
                          , [NSColor lavenderColor]
                          , [NSColor leadColor]
                          , [NSColor lemonColor]
                          , [NSColor licoriceColor]
                          , [NSColor limeColor]
                          , [NSColor magnesiumColor]
                          , [NSColor maraschinoColor]
                          , [NSColor maroonColor]
                          , [NSColor midnightColor]
                          , [NSColor mochaColor]
                          , [NSColor mossColor]
                          , [NSColor murcuryColor]
                          , [NSColor nickelColor]
                          , [NSColor oceanColor]
                          , [NSColor orchidColor]
                          , [NSColor plumColor]
                          , [NSColor salmonColor]
                          , [NSColor seaFoamColor]
                          , [NSColor silverColor]
                          , [NSColor skyColor]
                          , [NSColor snowColor]
                          , [NSColor spindriftColor]
                          , [NSColor springColor]
                          , [NSColor steelColor]
                          , [NSColor strawberryColor]
                          , [NSColor tangerineColor]
                          , [NSColor tealColor]
                          , [NSColor tinColor]
                          , [NSColor tungstenColor]
                          , [NSColor turquoiseColor]
                          ];
    });
    return colorfulArray;
}

+ (NSString *)DCH_colorName:(NSColor *)color {
    NSString *result = @"";
    do {
        if (!color) {
            break;
        }
        static NSArray *colorfulNameArray = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            colorfulNameArray = @[@"aluminumColor"
                                  , @"aquaColor"
                                  , @"asparagusColor"
                                  , @"bananaColor"
                                  , @"blueberryColor"
                                  , @"bubblegumColor"
                                  , @"cantaloupeColor"
                                  , @"carnationColor"
                                  , @"cayenneColor"
                                  , @"cloverColor"
                                  , @"eggplantColor"
                                  , @"fernColor"
                                  , @"floraColor"
                                  , @"grapeColor"
                                  , @"honeydewColor"
                                  , @"iceColor"
                                  , @"ironColor"
                                  , @"lavenderColor"
                                  , @"leadColor"
                                  , @"lemonColor"
                                  , @"licoriceColor"
                                  , @"limeColor"
                                  , @"magnesiumColor"
                                  , @"maraschinoColor"
                                  , @"maroonColor"
                                  , @"midnightColor"
                                  , @"mochaColor"
                                  , @"mossColor"
                                  , @"murcuryColor"
                                  , @"nickelColor"
                                  , @"oceanColor"
                                  , @"orchidColor"
                                  , @"plumColor"
                                  , @"salmonColor"
                                  , @"seaFoamColor"
                                  , @"silverColor"
                                  , @"skyColor"
                                  , @"snowColor"
                                  , @"spindriftColor"
                                  , @"springColor"
                                  , @"steelColor"
                                  , @"strawberryColor"
                                  , @"tangerineColor"
                                  , @"tealColor"
                                  , @"tinColor"
                                  , @"tungstenColor"
                                  , @"turquoiseColor"
                                  ];
        });
        NSUInteger idx = [[self DCH_colorfulArray] indexOfObject:color];
        if (idx != NSNotFound) {
            result = [colorfulNameArray objectAtIndex:idx];
        }
    } while (NO);
    return result;
}

@end
