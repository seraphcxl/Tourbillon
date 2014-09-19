//
//  DCCommonFuncations.m
//  Tourbillon
//
//  Created by Derek Chen on 8/21/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCCommonFuncations.h"

#pragma mark - DCCalcMemorySize
NSUInteger DCCalcMemorySizeFormKBToInt(NSUInteger numOfKB) {
    return numOfKB * 1024;
}

NSUInteger DCCalcMemorySizeFormMBToInt(NSUInteger numOfMB) {
    return DCCalcMemorySizeFormKBToInt(numOfMB * 1024);
}

NSUInteger DCCalcMemorySizeFormGBToInt(NSUInteger numOfGB) {
    return DCCalcMemorySizeFormMBToInt(numOfGB * 1024);
}

double DCCalcMemorySizeFormIntToKB(NSUInteger num) {
    return num / 1024.0f;
}

double DCCalcMemorySizeFormIntToMB(NSUInteger num) {
    return DCCalcMemorySizeFormIntToKB(num / 1024.0f);
}

double DCCalcMemorySizeFormIntToGB(NSUInteger num) {
    return DCCalcMemorySizeFormIntToMB(num / 1024.0f);
}

#pragma mark - DCRGBAConvert
double DCRGBAConvert256ToPercentage(NSUInteger numOfRGB256) {
    return (double)(numOfRGB256 / 255.0f);
}

NSUInteger DCRGBAConvertPercentageTo256(double numOfPercentage) {
    return (NSUInteger)(numOfPercentage * 255);
}

#pragma mark - DCDegreeRadianConvert
float DCConvertDegreesToRadians(float angle) {
    return (float)((angle * M_PI) / 180.f);
}

float DCConvertRadiansToDegrees(float radian) {
    return (float)((radian * 180.f) / M_PI);
}

@implementation DCCommonFuncations

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
