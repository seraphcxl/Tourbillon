//
//  NSBundle+DCLibrarySupport.m
//  Tourbillon
//
//  Created by Derek Chen on 5/30/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSBundle+DCLibrarySupport.h"
#import "NSMutableDictionary+GCDThreadSafe.h"

static NSMutableDictionary *s_libraryResourcesBundleDict = nil;

@implementation NSBundle (DCLibrarySupport)

+ (NSBundle *)libraryResourcesBundle:(NSString *)libraryName {
    NSBundle *libraryResourcesBundle = nil;
    do {
        if (!libraryName) {
            break;
        }
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            s_libraryResourcesBundleDict = [[NSMutableDictionary dictionary] threadSafe_init];
        });
        
        libraryResourcesBundle = [s_libraryResourcesBundleDict threadSafe_objectForKey:libraryName];
        if (libraryResourcesBundle) {
            break;
        }
        
        libraryResourcesBundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:libraryName withExtension:@"bundle"]];
        [s_libraryResourcesBundleDict threadSafe_setObject:libraryResourcesBundle forKey:libraryName];
        
    } while (NO);
    return libraryResourcesBundle;
}

+ (void)removeAllLibraryResourcesBundles {
    do {
        if (s_libraryResourcesBundleDict) {
            [s_libraryResourcesBundleDict threadSafe_removeAllObjects];
        }
    } while (NO);
}

@end
