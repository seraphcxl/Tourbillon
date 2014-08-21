//
//  DCTree.m
//  FoundingFather
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import "DCTree.h"
#import "DCTreeNode.h"
#import "DCLogger.h"

NSString * const kDCTreeLevelSeparator = @"DCTreeLevel";

NSString * const kDCTreeCodingRoot = @"DCTreeCodingRoot";

@interface DCTree ()

@property (strong, nonatomic) DCTreeNode *root;

- (NSString *)createLevelSeparatorBy:(NSUInteger)level;

@end

@implementation DCTree

@synthesize delegate = _delegate;
@synthesize root = _root;

- (instancetype)initWithRootNodeKey:(NSString *)key andValue:(id<NSCoding>)value {
    self = [self init];
    if (self) {
        DCAssert(key != nil && [key length] != 0 && value != nil);
        self.root = nil;
        self.root = [[DCTreeNode alloc] initWithKey:key andValue:value];
    }
    return self;
}

- (void)dealloc {
    do {
        self.root = nil;
    } while (NO);
}

- (BOOL)actionWithRoot:(DCTreeActionBlock)actionBlock {
    BOOL result = NO;
    do {
        if (!self.root || !actionBlock) {
            break;
        }
        result = [self actionWithNodeByTreeNodeDescription:[self.root treeNodeDescription] andActionBlock:actionBlock];
    } while (NO);
    return result;
}

- (BOOL)actionWithNodeByTreeNodeDescription:(NSString *)desc andActionBlock:(DCTreeActionBlock)actionBlock {
    BOOL result = NO;
    do {
        if (!self.root || !desc || !actionBlock) {
            break;
        }
        DCTreeNode *node = [self.root getChildByTreeNodeDescription:desc];
        if (!node) {
            break;
        }
        result = actionBlock(self, node);
    } while (NO);
    return result;
}

- (NSString *)keyLevelTraversal:(BOOL)needLevelSeparator {
    NSMutableString *result = nil;
    do {
        if (!self.root) {
            break;
        }
        result = [NSMutableString string];
        NSMutableArray *nodeAry = [NSMutableArray arrayWithObject:self.root];
        NSUInteger currentLevel = -1;
        do {
            DCTreeNode *node = [nodeAry objectAtIndex:0];
            if (needLevelSeparator) {
                NSUInteger nodeLevel = [node level];
                if (nodeLevel != currentLevel) {
                    currentLevel = nodeLevel;
                    [result appendString:[self createLevelSeparatorBy:currentLevel]];
                }
            }
            [result appendString:node.key];
            [nodeAry addObjectsFromArray:node.children];
            [nodeAry removeObjectAtIndex:0];
            if (nodeAry.count != 0) {
                [result appendString:kDCTreeNodeSeparator];
            }
        } while (nodeAry.count != 0);
    } while (NO);
    return result;
}

- (NSString *)createLevelSeparatorBy:(NSUInteger)level {
    return [NSString stringWithFormat:@"%@_%lu:", kDCTreeLevelSeparator, (unsigned long)level];
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    do {
        if (!aCoder || ![aCoder allowsKeyedCoding]) {
            break;
        }
        [aCoder encodeObject:self.root forKey:kDCTreeCodingRoot];
    } while (NO);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        DCAssert(aDecoder != nil && [aDecoder allowsKeyedCoding]);
        self.root = [aDecoder decodeObjectForKey:kDCTreeCodingRoot];
    }
    return self;
}

@end
