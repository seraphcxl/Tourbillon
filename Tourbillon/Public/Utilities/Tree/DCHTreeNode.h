//
//  DCHTreeNode.h
//  Tourbillon
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kDCHTreeNodeSeparator;

@interface DCHTreeNode : NSObject <NSCoding>

+ (NSMutableArray *)treeNodeDescriptionToKeyArray:(NSString *)desc;

@property (strong, nonatomic, readonly) NSString *key;
@property (strong, nonatomic, readonly) id<NSCoding> value;

@property (strong, nonatomic) DCHTreeNode *parent;
@property (strong, nonatomic, readonly) NSMutableArray *children;

- (instancetype)initWithKey:(NSString *)key andValue:(id<NSCoding>)value;

- (NSUInteger)level;

- (void)addChild:(DCHTreeNode *)child;
- (void)addChildrenByArray:(NSArray *)children;
- (void)removeAllChildren;
- (void)removeChildrenAtIndex:(NSUInteger)childIndex;
- (void)removeChildrenByKey:(NSString *)childKey;
- (void)removeChildrenByArray:(NSArray *)children;
- (DCHTreeNode *)getChildAtIndex:(NSUInteger)childIndex;
- (DCHTreeNode *)getChildByKey:(NSString *)childKey;

- (NSString *)treeNodeDescription;
- (DCHTreeNode *)getChildByTreeNodeDescription:(NSString *)desc;
- (DCHTreeNode *)getChildByNodeKeyArray:(NSArray *)keyArray;

@end
