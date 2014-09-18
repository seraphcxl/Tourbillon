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

+ (NSArray *)getProcessStatusWith:(NSArray *)keywords andPID:(NSUInteger)pid {
    NSMutableArray *result = [NSMutableArray array];
    do {
        if (!keywords || keywords.count == 0 || pid == 0) {
            break;
        }
        
        NSMutableArray *arguments = [NSMutableArray arrayWithObjects: @"-O", nil];
        [arguments addObjectsFromArray:keywords];
        [arguments addObject:@"-p"];
        [arguments addObject:[NSString stringWithFormat:@"%lu", (unsigned long)pid]];
        
        NSTask *task = [NSTask launchedTaskWithLaunchPath:@"/bin/ps" arguments:arguments];
        
        NSPipe *pipe = [NSPipe pipe];
        [task setStandardOutput: pipe];
        
        NSFileHandle *file = [pipe fileHandleForReading];
        
        [task launch];
        
        NSData *data = [file readDataToEndOfFile];
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSMutableArray *arr = (NSMutableArray *)[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [arr removeObject:@""];
        NSUInteger commandIdx = [arr indexOfObject:@"COMMAND"];
        if (arr.count >= (2 + commandIdx)) {
            NSInteger count = MIN((2 + commandIdx + keywords.count), (arr.count));
            for (NSInteger idx = (2 + commandIdx); idx < count; ++idx) {
                [result addObject:[arr objectAtIndex:idx]];
            }
        }
    } while (NO);
    return result;
}

@end
