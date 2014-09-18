//
//  DCCommonFuncations.h
//  Tourbillon
//
//  Created by Derek Chen on 8/21/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - DCCalcMemorySize
extern NSUInteger DCCalcMemorySizeFormKBToInt(NSUInteger numOfKB);
extern NSUInteger DCCalcMemorySizeFormMBToInt(NSUInteger numOfMB);
extern NSUInteger DCCalcMemorySizeFormGBToInt(NSUInteger numOfGB);

extern double DCCalcMemorySizeFormIntToKB(NSUInteger num);
extern double DCCalcMemorySizeFormIntToMB(NSUInteger num);
extern double DCCalcMemorySizeFormIntToGB(NSUInteger num);

#pragma mark - DCRGBAConvert
extern double DCRGBAConvert256ToPercentage(NSUInteger numOfRGB256);
extern NSUInteger DCRGBAConvertPercentageTo256(double numOfPercentage);

#pragma mark - DCDegreeRadianConvert
extern float DCConvertDegreesToRadians(float angle);
extern float DCConvertRadiansToDegrees(float radian);

@interface DCCommonFuncations : NSObject

@end
