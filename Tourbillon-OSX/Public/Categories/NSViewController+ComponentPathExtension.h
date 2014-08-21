//
//  NSViewController+ComponentPathExtension.h
//  Tourbillon
//
//  Created by Derek Chen on 8/21/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSObject+DCAssociatedObjectExtension.h"
#import "DCTreeNode.h"

@interface NSViewController (ComponentPathExtension)

DEFINE_ASSOCIATEDOBJECT_FOR_HEADER(ComponentPath)

- (BOOL)registerComponentPath:(DCTreeNode *)componentPath;
- (void)resignComponentPath;

@end
