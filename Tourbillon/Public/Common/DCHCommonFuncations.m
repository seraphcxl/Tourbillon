//
//  DCHCommonFuncations.m
//  Tourbillon
//
//  Created by Derek Chen on 1/29/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "DCHCommonFuncations.h"

#pragma mark - Calc memory size
NSUInteger DCHCalcMemorySizeFormKBToInt(NSUInteger numOfKB) {
    return numOfKB * 1024;
}

NSUInteger DCHCalcMemorySizeFormMBToInt(NSUInteger numOfMB) {
    return DCHCalcMemorySizeFormKBToInt(numOfMB * 1024);
}

NSUInteger DCHCalcMemorySizeFormGBToInt(NSUInteger numOfGB) {
    return DCHCalcMemorySizeFormMBToInt(numOfGB * 1024);
}

double DCHCalcMemorySizeFormIntToKB(NSUInteger num) {
    return num / 1024.0f;
}

double DCHCalcMemorySizeFormIntToMB(NSUInteger num) {
    return DCHCalcMemorySizeFormIntToKB(num / 1024.0f);
}

double DCHCalcMemorySizeFormIntToGB(NSUInteger num) {
    return DCHCalcMemorySizeFormIntToMB(num / 1024.0f);
}

#pragma mark RGBA convert
double DCHRGBAConvert256ToPercentage(NSUInteger numOfRGB256) {
    return (double)(numOfRGB256 / 255.0f);
}

NSUInteger DCHRGBAConvertPercentageTo256(double numOfPercentage) {
    return (NSUInteger)(numOfPercentage * 255);
}

#pragma mark - Degree radian convert
float DCHConvertDegreesToRadians(float angle) {
    return (float)((angle * M_PI) / 180.f);
}

float DCHConvertRadiansToDegrees(float radian) {
    return (float)((radian * 180.f) / M_PI);
}

@implementation DCHCommonFuncations

+ (void)actionInMainThread:(void (^)(void))block {
    do {
        if (!block) {
            break;
        }
        
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    } while (NO);
}

@end
