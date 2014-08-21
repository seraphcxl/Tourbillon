//
//  DCTree.h
//  FoundingFather
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kDCTreeLevelSeparator;

@class DCTreeNode;
@class DCTree;

typedef BOOL (^DCTreeActionBlock)(DCTree *tree, DCTreeNode *node);

@protocol DCTreeDelegate <NSObject>

- (void)Tree:(DCTree *)tree didActionWithNode:(DCTreeNode *)node;

@end

@interface DCTree : NSObject <NSCoding>

@property (weak, atomic) id<DCTreeDelegate> delegate;
@property (strong, nonatomic, readonly) DCTreeNode *root;

- (instancetype)initWithRootNodeKey:(NSString *)key andValue:(id<NSCoding>)value;
- (BOOL)actionWithRoot:(DCTreeActionBlock)actionBlock;
- (BOOL)actionWithNodeByTreeNodeDescription:(NSString *)desc andActionBlock:(DCTreeActionBlock)actionBlock;

- (NSString *)keyLevelTraversal:(BOOL)needLevelSeparator;

@end
