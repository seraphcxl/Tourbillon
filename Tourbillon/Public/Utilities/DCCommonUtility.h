//
//  DCCommonUtility.h
//  Tourbillon
//
//  Created by Derek Chen on 13-6-7.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCCommonUtility : NSObject

+ (BOOL)isRetinaDisplay;
+ (BOOL)isRegisteredURLScheme:(NSString *)urlScheme;

+ (unsigned long)currentTimeInMilliseconds;
+ (NSTimeInterval)randomTimeInterval:(NSTimeInterval)minValue withMaxValue:(NSTimeInterval)maxValue;

+ (NSString *)localizedStringForKey:(NSString *)key withDefault:(NSString *)value inBundle:(NSBundle *)bundle;

@end
