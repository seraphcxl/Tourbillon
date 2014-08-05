//
//  UIImage+DCLibrarySupport.m
//  Tourbillon
//
//  Created by Derek Chen on 5/30/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "UIImage+DCLibrarySupport.h"
#import "NSBundle+DCLibrarySupport.h"

@implementation UIImage (DCLibrarySupport)

+ (instancetype)ImageNamed:(NSString *)imageName inLibrary:(NSString *)libraryName {
    id result = nil;
    do {
        if (!imageName || !libraryName) {
            break;
        }
        result = [self imageNamed:imageName];
        if (result) {
            break;
        }
        result = [self imageWithContentsOfFile:[[[NSBundle libraryResourcesBundle:libraryName] resourcePath] stringByAppendingPathComponent:imageName]];
    } while (NO);
    return result;
}

@end
