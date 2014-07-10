//
//  DCComponentTreeNode.h
//  FoundingFather
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCComponentTreeNode : NSObject

+ (NSMutableArray *)componentTreeNodeDescriptionToKeyArray:(NSString *)desc;

@property (strong, nonatomic, readonly) NSString *key;
@property (strong, nonatomic, readonly) id value;

@property (strong, nonatomic) DCComponentTreeNode *parent;
@property (strong, nonatomic, readonly) NSMutableArray *children;

- (instancetype)initWithKey:(NSString *)key value:(id)value;

- (void)addChild:(DCComponentTreeNode *)child;
- (void)addChildrenByArray:(NSArray *)children;
- (void)removeAllChildren;
- (void)removeChildrenAtIndex:(NSUInteger)childIndex;
- (void)removeChildrenByKey:(NSString *)childKey;
- (void)removeChildrenByArray:(NSArray *)children;
- (DCComponentTreeNode *)getChildAtIndex:(NSUInteger)childIndex;
- (DCComponentTreeNode *)getChildByKey:(NSString *)childKey;

- (NSString *)componentTreeNodeDescription;
- (DCComponentTreeNode *)getChildByComponentTreeNodeDescription:(NSString *)desc;
- (DCComponentTreeNode *)getChildByNodeKeyArray:(NSArray *)keyArray;

@end
