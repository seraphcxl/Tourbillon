//
//  NSBundle+DCLibrarySupport.m
//  Tourbillon
//
//  Created by Derek Chen on 5/30/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSBundle+DCLibrarySupport.h"

@implementation NSBundle (DCLibrarySupport)

+ (NSBundle *)libraryResourcesBundle:(NSString *)libraryName {
    NSBundle *libraryResourcesBundle = nil;
    do {
        if (!libraryName) {
            break;
        }
        
        libraryResourcesBundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:libraryName withExtension:@"bundle"]];
    } while (NO);
    return libraryResourcesBundle;
}

@end
