//
//  DCHTree.h
//  Tourbillon
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kDCHTreeLevelSeparator;

@class DCHTreeNode;
@class DCHTree;

typedef BOOL (^DCHTreeActionBlock)(DCHTree *tree, DCHTreeNode *node);

@protocol DCHTreeDelegate <NSObject>

- (void)Tree:(DCHTree *)tree didActionWithNode:(DCHTreeNode *)node;

@end

@interface DCHTree : NSObject <NSCoding>

@property (weak, nonatomic) id<DCHTreeDelegate> delegate;
@property (strong, nonatomic, readonly) DCHTreeNode *root;

- (instancetype)initWithRootNodeKey:(NSString *)key andValue:(id<NSCoding>)value;
- (BOOL)actionWithRoot:(DCHTreeActionBlock)actionBlock;
- (BOOL)actionWithNodeByTreeNodeDescription:(NSString *)desc andActionBlock:(DCHTreeActionBlock)actionBlock;

- (NSString *)keyLevelTraversal:(BOOL)needLevelSeparator;

@end
