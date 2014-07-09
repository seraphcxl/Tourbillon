//
//  NSObject+DCUUIDExtension.m
//  Tourbillon
//
//  Created by Derek Chen on 7/9/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSObject+DCUUIDExtension.h"

@implementation NSObject (DCUUIDExtension)

+ (NSString *)createMemoryID:(NSObject *)object {
    NSString *result = nil;
    do {
        if (!object) {
            break;
        }
        result = [NSString stringWithFormat:@"%@_%p", [object class], object];
    } while (NO);
    return result;
}

+ (NSString *)createUniqueStrByUUID {
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
