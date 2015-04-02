//
//  DCHTree.m
//  Tourbillon
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import "DCHTree.h"
#import "DCHCommonConstants.h"
#import "DCHTreeNode.h"

NSString * const kDCHTreeLevelSeparator = @"DCHTreeLevel";

NSString * const kDCHTreeCodingRoot = @"DCHTreeCodingRoot";

@interface DCHTree ()

@property (strong, nonatomic) DCHTreeNode *root;

- (NSString *)createLevelSeparatorBy:(NSUInteger)level;

@end

@implementation DCHTree

@synthesize delegate = _delegate;
@synthesize root = _root;

- (instancetype)initWithRootNodeKey:(NSString *)key andValue:(id<NSCoding>)value {
    self = [self init];
    if (self) {
        DCHAssert(key != nil && [key length] != 0 && value != nil);
        self.root = nil;
        self.root = [[DCHTreeNode alloc] initWithKey:key andValue:value];
    }
    return self;
}

- (void)dealloc {
    do {
        self.root = nil;
    } while (NO);
}

- (BOOL)actionWithRoot:(DCHTreeActionBlock)actionBlock {
    BOOL result = NO;
    do {
        if (!self.root || !actionBlock) {
            break;
        }
        result = [self actionWithNodeByTreeNodeDescription:[self.root treeNodeDescription] andActionBlock:actionBlock];
    } while (NO);
    return result;
}

- (BOOL)actionWithNodeByTreeNodeDescription:(NSString *)desc andActionBlock:(DCHTreeActionBlock)actionBlock {
    BOOL result = NO;
    do {
        if (!self.root || !desc || !actionBlock) {
            break;
        }
        DCHTreeNode *node = [self.root getChildByTreeNodeDescription:desc];
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
            DCHTreeNode *node = [nodeAry objectAtIndex:0];
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
                [result appendString:kDCHTreeNodeSeparator];
            }
        } while (nodeAry.count != 0);
    } while (NO);
    return result;
}

- (NSString *)createLevelSeparatorBy:(NSUInteger)level {
    return [NSString stringWithFormat:@"%@_%lu:", kDCHTreeLevelSeparator, (unsigned long)level];
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    do {
        if (!aCoder || ![aCoder allowsKeyedCoding]) {
            break;
        }
        [aCoder encodeObject:self.root forKey:kDCHTreeCodingRoot];
    } while (NO);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        DCHAssert(aDecoder != nil && [aDecoder allowsKeyedCoding]);
        self.root = [aDecoder decodeObjectForKey:kDCHTreeCodingRoot];
    }
    return self;
}

@end
