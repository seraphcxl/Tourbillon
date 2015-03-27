//
//  NSObject+DCHUUIDExtension.m
//  Tourbillon
//
//  Created by Derek Chen on 2/13/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSObject+DCHUUIDExtension.h"

@implementation NSObject (DCHUUIDExtension)

- (NSString *)createMemoryID {
    NSString *result = nil;
    do {
        result = [NSString stringWithFormat:@"%@_%p", NSStringFromClass([self class]), self];
    } while (NO);
    return result;
}

+ (NSString *)createUUID {
    NSString *result = nil;
    CFUUIDRef uuidObj = NULL;
    do {
        uuidObj = CFUUIDCreate(nil);
        result = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuidObj);
    } while (NO);
    if (uuidObj) {
        CFRelease(uuidObj);
        uuidObj = NULL;
    }
    return result;
}

@end
