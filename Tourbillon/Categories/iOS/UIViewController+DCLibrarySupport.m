//
//  UIViewController+DCLibrarySupport.m
//  Tourbillon
//
//  Created by Derek Chen on 5/31/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "UIViewController+DCLibrarySupport.h"

@implementation UIViewController (DCLibrarySupport)

- (instancetype)initWithLibraryBundle:(NSString *)libraryName {
    NSString *nibPath = [[NSBundle mainBundle] pathForResource:[[self class] description] ofType:@"nib"];
    if (nibPath) {
        self = [self initWithNibName:nil bundle:nil];
    } else {
        if (libraryName) {
            NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:libraryName withExtension:@"bundle"]];
            self = [self initWithNibName:nil bundle:bundle];
        }
    }
    return self;
}

@end
