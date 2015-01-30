//
//  DCHCommonFuncations.h
//  Tourbillon
//
//  Created by Derek Chen on 1/29/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Calc memory size
extern NSUInteger DCHCalcMemorySizeFormKBToInt(NSUInteger numOfKB);
extern NSUInteger DCHCalcMemorySizeFormMBToInt(NSUInteger numOfMB);
extern NSUInteger DCHCalcMemorySizeFormGBToInt(NSUInteger numOfGB);

extern double DCHCalcMemorySizeFormIntToKB(NSUInteger num);
extern double DCHCalcMemorySizeFormIntToMB(NSUInteger num);
extern double DCHCalcMemorySizeFormIntToGB(NSUInteger num);

#pragma mark - RGBA convert
extern double DCHRGBAConvert256ToPercentage(NSUInteger numOfRGB256);
extern NSUInteger DCHRGBAConvertPercentageTo256(double numOfPercentage);

#pragma mark - Degree radian convert
extern float DCHConvertDegreesToRadians(float angle);
extern float DCHConvertRadiansToDegrees(float radian);

@interface DCHCommonFuncations : NSObject

+ (void)actionInMainThread:(void (^)(void)) block;

@end
