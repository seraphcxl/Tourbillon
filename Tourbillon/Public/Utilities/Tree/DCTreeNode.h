//
//  DCTreeNode.h
//  FoundingFather
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kDCTreeNodeSeparator;

@interface DCTreeNode : NSObject <NSCoding>

+ (NSMutableArray *)treeNodeDescriptionToKeyArray:(NSString *)desc;

@property (strong, nonatomic, readonly) NSString *key;
@property (strong, nonatomic, readonly) id<NSCoding> value;

@property (strong, nonatomic) DCTreeNode *parent;
@property (strong, nonatomic, readonly) NSMutableArray *children;

- (instancetype)initWithKey:(NSString *)key andValue:(id<NSCoding>)value;

- (NSUInteger)level;

- (void)addChild:(DCTreeNode *)child;
- (void)addChildrenByArray:(NSArray *)children;
- (void)removeAllChildren;
- (void)removeChildrenAtIndex:(NSUInteger)childIndex;
- (void)removeChildrenByKey:(NSString *)childKey;
- (void)removeChildrenByArray:(NSArray *)children;
- (DCTreeNode *)getChildAtIndex:(NSUInteger)childIndex;
- (DCTreeNode *)getChildByKey:(NSString *)childKey;

- (NSString *)treeNodeDescription;
- (DCTreeNode *)getChildByTreeNodeDescription:(NSString *)desc;
- (DCTreeNode *)getChildByNodeKeyArray:(NSArray *)keyArray;

@end
