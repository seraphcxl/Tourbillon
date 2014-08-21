//
//  NSViewController+ComponentPathExtension.m
//  Tourbillon
//
//  Created by Derek Chen on 8/21/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSViewController+ComponentPathExtension.h"

@implementation NSViewController (ComponentPathExtension)

DEFINE_ASSOCIATEDOBJECT_FOR_CLASS(ComponentPath, NSViewController_ComponentPathExtension_ComponentPath, OBJC_ASSOCIATION_RETAIN)

- (BOOL)registerComponentPath:(DCTreeNode *)componentPath {
    BOOL result = NO;
    do {
        if (!componentPath) {
            break;
        }
        [self setComponentPath:componentPath];
        result = YES;
    } while (NO);
    return result;
}

- (void)resignComponentPath {
    do {
        [self setComponentPath:nil];
    } while (NO);
}

@end
