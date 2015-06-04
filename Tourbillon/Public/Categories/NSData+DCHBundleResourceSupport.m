//
//  NSData+DCHBundleResourceSupport.m
//  Tourbillon
//
//  Created by Derek Chen on 5/30/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSData+DCHBundleResourceSupport.h"
#import "NSBundle+DCHBundleResourceSupport.h"

@implementation NSData (DCHBundleResourceSupport)

+ (instancetype)dch_dataInLibrary:(NSString *)libraryName withBundleResource:(NSString *)resourceName ofType:(NSString *)type {
    id result = nil;
    do {
        if (!libraryName || !resourceName || !type) {
            break;
        }
        NSString *filePathInMainBundle = [[NSBundle mainBundle] pathForResource:resourceName ofType:type];
        result = [self dataWithContentsOfFile:filePathInMainBundle];
        if (result) {
            break;
        }
        NSString *filePathInLibraryBundle = [[NSBundle dch_libraryResourcesBundle:libraryName] pathForResource:resourceName ofType:type];
        result = [self dataWithContentsOfFile:filePathInLibraryBundle];
    } while (NO);
    return result;
}

+ (instancetype)dch_dataInLibrary:(NSString *)libraryName withBundleResource:(NSString *)resourceName ofType:(NSString *)type options:(NSDataReadingOptions)readOptionsMask error:(NSError *__autoreleasing *)errorPtr {
    id result = nil;
    do {
        if (!libraryName || !resourceName || !type) {
            break;
        }
        NSString *filePathInMainBundle = [[NSBundle mainBundle] pathForResource:resourceName ofType:type];
        result = [self dataWithContentsOfFile:filePathInMainBundle options:readOptionsMask error:errorPtr];
        if (result) {
            break;
        }
        NSString *filePathInLibraryBundle = [[NSBundle dch_libraryResourcesBundle:libraryName] pathForResource:resourceName ofType:type];
        result = [self dataWithContentsOfFile:filePathInLibraryBundle options:readOptionsMask error:errorPtr];
    } while (NO);
    return result;
}

@end
