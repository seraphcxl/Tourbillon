//
//  DCCommonUtility.m
//  CodeGear_ObjC
//
//  Created by Derek Chen on 13-6-7.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "DCCommonUtility.h"
#include <sys/time.h>
#import "DCCommonConstants.h"

#if TARGET_OS_IPHONE
    #import <UIKit/UIKit.h>
#else
#endif

@implementation DCCommonUtility

+ (BOOL)isRetinaDisplay {
#if TARGET_OS_IPHONE
    // Check for displayLinkWithTarget:selector: since that is only available on iOS 4.0+
    // deal with edge case where scale returns 2.0 on a iPad running 3.2 with 2x
    // (which is not retina).
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
            (DCFloatingNumberEqual([UIScreen mainScreen].scale, 2.0)));
#else
    return ([NSScreen mainScreen].backingScaleFactor > 1.0);
#endif
}

+ (BOOL)isRegisteredURLScheme:(NSString *)urlScheme {
    static dispatch_once_t fetchBundleOnce;
    static NSArray *urlSchemes = nil;
    
    dispatch_once(&fetchBundleOnce, ^{
        urlSchemes = [[[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleURLTypes"] objectAtIndex:0] valueForKey:@"CFBundleURLSchemes"];
    });
    return [urlSchemes containsObject:urlScheme];
}

+ (unsigned long)currentTimeInMilliseconds {
    struct timeval time;
    gettimeofday(&time, NULL);
    return (time.tv_sec * 1000) + (time.tv_usec / 1000);
}

+ (NSTimeInterval)randomTimeInterval:(NSTimeInterval)minValue withMaxValue:(NSTimeInterval)maxValue {
    return minValue + (maxValue - minValue) * (double)arc4random() / UINT32_MAX;
}

+ (NSString *)localizedStringForKey:(NSString *)key withDefault:(NSString *)value inBundle:(NSBundle *)bundle {
    NSString *result = value;
    if (bundle) {
        result = [bundle localizedStringForKey:key value:value table:nil];
    }
    return result;
}

@end
