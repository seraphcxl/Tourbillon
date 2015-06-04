//
//  NSBundle+DCHBundleResourceSupport.m
//  Tourbillon
//
//  Created by Derek Chen on 5/30/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSBundle+DCHBundleResourceSupport.h"
#import "NSMutableDictionary+DCHThreadSafe.h"

static NSMutableDictionary *s_libraryResourcesBundleDict = nil;

@implementation NSBundle (DCHBundleResourceSupport)

+ (NSBundle *)dch_libraryResourcesBundle:(NSString *)libraryName {
    NSBundle *libraryResourcesBundle = nil;
    do {
        if (!libraryName) {
            break;
        }
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            s_libraryResourcesBundleDict = [[NSMutableDictionary dictionary] dch_threadSafe_init:YES];
        });
        
        libraryResourcesBundle = [s_libraryResourcesBundleDict dch_threadSafe_objectForKey:libraryName];
        if (libraryResourcesBundle) {
            break;
        }
        
        libraryResourcesBundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:libraryName withExtension:@"bundle"]];
        [s_libraryResourcesBundleDict dch_threadSafe_setObject:libraryResourcesBundle forKey:libraryName];
        
    } while (NO);
    return libraryResourcesBundle;
}

+ (void)dch_removeAllLibraryResourcesBundles {
    do {
        if (s_libraryResourcesBundleDict) {
            [s_libraryResourcesBundleDict dch_threadSafe_removeAllObjects];
        }
    } while (NO);
}

@end
