//
//  DCComponentTree.h
//  FoundingFather
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCComponentTreeNode;

@interface DCComponentTree : NSObject

@property (strong, nonatomic, readonly) DCComponentTreeNode *root;

@end
