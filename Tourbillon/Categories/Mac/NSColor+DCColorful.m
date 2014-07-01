//
//  NSColor+DCColorful.m
//  Tourbillon
//
//  Created by Derek Chen on 7/1/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSColor+DCColorful.h"
#import "DCCommonConstants.h"

@implementation NSColor (DCColorful)

+ (NSColor *)aluminumColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(153.0f);
        CGFloat green = DC_RGB(153.0f);
        CGFloat red = DC_RGB(153.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)aquaColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(255.0f);
        CGFloat green = DC_RGB(128.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)asparagusColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(128.0f);
        CGFloat red = DC_RGB(128.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)bananaColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(102.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(255.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)blueberryColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(255.0f);
        CGFloat green = DC_RGB(0.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)bubblegumColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(255.0f);
        CGFloat green = DC_RGB(102.0f);
        CGFloat red = DC_RGB(255.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)cantaloupeColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(102.0f);
        CGFloat green = DC_RGB(204.0f);
        CGFloat red = DC_RGB(255.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)carnationColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(207.0f);
        CGFloat green = DC_RGB(111.0f);
        CGFloat red = DC_RGB(255.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)cayenneColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(0.0f);
        CGFloat red = DC_RGB(128.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)cloverColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(128.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)eggplantColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(128.0f);
        CGFloat green = DC_RGB(0.0f);
        CGFloat red = DC_RGB(64.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)fernColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(128.0f);
        CGFloat red = DC_RGB(64.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)floraColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(102.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(102.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)grapeColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(255.0f);
        CGFloat green = DC_RGB(0.0f);
        CGFloat red = DC_RGB(128.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)honeydewColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(102.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(204.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)iceColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(255.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(102.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)ironColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(76.0f);
        CGFloat green = DC_RGB(76.0f);
        CGFloat red = DC_RGB(76.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)lavenderColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(255.0f);
        CGFloat green = DC_RGB(102.0f);
        CGFloat red = DC_RGB(204.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)leadColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(25.0f);
        CGFloat green = DC_RGB(25.0f);
        CGFloat red = DC_RGB(25.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)lemonColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(255.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)licoriceColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(0.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)limeColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(128.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)magnesiumColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(179.0f);
        CGFloat green = DC_RGB(179.0f);
        CGFloat red = DC_RGB(179.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)maraschinoColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(0.0f);
        CGFloat red = DC_RGB(255.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)maroonColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(64.0f);
        CGFloat green = DC_RGB(0.0f);
        CGFloat red = DC_RGB(128.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)midnightColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(128.0f);
        CGFloat green = DC_RGB(0.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)mochaColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(64.0f);
        CGFloat red = DC_RGB(128.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)mossColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(64.0f);
        CGFloat green = DC_RGB(128.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)murcuryColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(230.0f);
        CGFloat green = DC_RGB(230.0f);
        CGFloat red = DC_RGB(230.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)nickelColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(128.0f);
        CGFloat green = DC_RGB(128.0f);
        CGFloat red = DC_RGB(128.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)oceanColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(128.0f);
        CGFloat green = DC_RGB(64.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)orchidColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(255.0f);
        CGFloat green = DC_RGB(102.0f);
        CGFloat red = DC_RGB(102.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)plumColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(128.0f);
        CGFloat green = DC_RGB(0.0f);
        CGFloat red = DC_RGB(128.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)salmonColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(102.0f);
        CGFloat green = DC_RGB(102.0f);
        CGFloat red = DC_RGB(255.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)seaFoamColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(128.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)silverColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(204.0f);
        CGFloat green = DC_RGB(204.0f);
        CGFloat red = DC_RGB(204.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)skyColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(255.0f);
        CGFloat green = DC_RGB(204.0f);
        CGFloat red = DC_RGB(102.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)snowColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(255.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(255.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)spindriftColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(204.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(102.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)springColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)steelColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(102.0f);
        CGFloat green = DC_RGB(102.0f);
        CGFloat red = DC_RGB(102.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)strawberryColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(105.0f);
        CGFloat green = DC_RGB(0.0f);
        CGFloat red = DC_RGB(255.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)tangerineColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(0.0f);
        CGFloat green = DC_RGB(128.0f);
        CGFloat red = DC_RGB(255.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)tealColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(128.0f);
        CGFloat green = DC_RGB(128.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)tinColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(127.0f);
        CGFloat green = DC_RGB(127.0f);
        CGFloat red = DC_RGB(127.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)tungstenColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(51.0f);
        CGFloat green = DC_RGB(51.0f);
        CGFloat red = DC_RGB(51.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

+ (NSColor *)turquoiseColor {
    static NSColor *color = nil;
    
    dispatch_block_t block = ^(void) {
        CGFloat alpha = 1.0f;
        CGFloat blue = DC_RGB(255.0f);
        CGFloat green = DC_RGB(255.0f);
        CGFloat red = DC_RGB(0.0f);
        
        color = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
    };
    
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, block);
    
    return color;
}

@end
