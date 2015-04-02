//
//  DCHTreeNode.m
//  Tourbillon
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import "DCHTreeNode.h"
#import "DCHCommonConstants.h"
#import "NSMutableArray+DCHThreadSafe.h"
#import "NSMutableDictionary+DCHThreadSafe.h"
#import "NSString+DCHURLCoding.h"

NSString * const kDCHTreeNodeSeparator = @",";

NSString * const kDCHTreeNodeCodingKey = @"DCHTreeNodeCodingKey";
NSString * const kDCHTreeNodeCodingValue = @"DCHTreeNodeCodingValue";
NSString * const kDCHTreeNodeCodingChildren = @"DCHTreeNodeCodingChildren";

@interface DCHTreeNode ()

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) id<NSCoding> value;
@property (strong, nonatomic) NSMutableArray *children;
@property (strong, nonatomic) NSMutableDictionary *childrenDict;

@end

@implementation DCHTreeNode

@synthesize key = _key;
@synthesize value = _value;
@synthesize parent = _parent;
@synthesize children = _children;

+ (NSMutableArray *)treeNodeDescriptionToKeyArray:(NSString *)desc {
    NSMutableArray *result = nil;
    do {
        if (!desc) {
            break;
        }
        result = [NSMutableArray array];
        NSScanner *scanner = [NSScanner scannerWithString:desc];
        NSString *key = nil;
        while(![scanner isAtEnd]) {
            [scanner scanUpToString:kDCHTreeNodeSeparator intoString:&key];
            [scanner scanString:kDCHTreeNodeSeparator intoString:NULL];
            [result addObject:key];
        }
    } while (NO);
    return result;
}

- (instancetype)initWithKey:(NSString *)key andValue:(id<NSCoding>)value {
    self = [self init];
    if (self) {
        DCHAssert(key != nil && [key length] != 0 && value != nil);
        self.key = [[key dch_urlEncodedString] copy];
        self.value = value;
        
        self.parent = nil;
        self.children = [[NSMutableArray array] threadSafe_init:YES];
        self.childrenDict = [[NSMutableDictionary dictionary] threadSafe_init:YES];
    }
    return self;
}

- (void)dealloc {
    do {
        [self.childrenDict threadSafe_removeAllObjects];
        self.childrenDict = nil;
        [self.children threadSafe_removeAllObjects];
        self.children = nil;
        self.parent = nil;
        
        self.value = nil;
        self.key = nil;
    } while (NO);
}

- (NSUInteger)level {
    NSUInteger result = 0;
    do {
        if (!self.parent) {
            break;
        }
        result = 1 + [self.parent level];
    } while (NO);
    return result;
}

- (void)addChild:(DCHTreeNode *)child {
    do {
        DCHAssert(self.children != nil && self.childrenDict != nil);
        if (!child) {
            break;
        }
        if ([self.childrenDict threadSafe_objectForKey:child.key]) {
            break;
        }
        [self.children threadSafe_addObject:child];
        child.parent = self;
        [self.childrenDict threadSafe_setObject:child forKey:child.key];
    } while (NO);
}

- (void)addChildrenByArray:(NSArray *)children {
    do {
        DCHAssert(self.children != nil && self.childrenDict != nil);
        if (!children || children.count == 0) {
            break;
        }
        for (DCHTreeNode *node in children) {
            [self addChild:node];
        }
    } while (NO);
}

- (void)removeAllChildren {
    do {
        DCHAssert(self.children != nil && self.childrenDict != nil);
        [self.children threadSafe_removeAllObjects];
        [self.childrenDict threadSafe_removeAllObjects];
    } while (NO);
}

- (void)removeChildrenAtIndex:(NSUInteger)childIndex {
    do {
        DCHAssert(self.children != nil && self.childrenDict != nil);
        if (childIndex >= [self.children threadSafe_count]) {
            break;
        }
        DCHTreeNode *node = [self.children threadSafe_objectAtIndex:childIndex];
        if (node) {
            [self.childrenDict removeObjectForKey:node.key];
        }
        [self.children threadSafe_removeObjectAtIndex:childIndex];
    } while (NO);
}

- (void)removeChildrenByKey:(NSString *)childKey {
    do {
        DCHAssert(self.children != nil && self.childrenDict != nil);
        if (!childKey) {
            break;
        }
        NSString *key = [childKey dch_urlEncodedString];
        DCHTreeNode *node = [self.childrenDict threadSafe_objectForKey:key];
        if (node) {
            [self.children removeObject:node];
        }
        [self.childrenDict removeObjectForKey:key];
    } while (NO);
}

- (void)removeChildrenByArray:(NSArray *)children {
    do {
        DCHAssert(self.children != nil && self.childrenDict != nil);
        if (!children || children.count == 0) {
            break;
        }
        NSUInteger count = [self.children threadSafe_count];
        for (NSUInteger idx = 0; idx < count; ++idx) {
            [self removeChildrenAtIndex:idx];
        }
    } while (NO);
}

- (DCHTreeNode *)getChildAtIndex:(NSUInteger)childIndex {
    DCHTreeNode *result = nil;
    do {
        DCHAssert(self.children != nil && self.childrenDict != nil);
        if (childIndex >= [self.children threadSafe_count]) {
            break;
        }
        result = [self.children threadSafe_objectAtIndex:childIndex];
    } while (NO);
    return result;
}

- (DCHTreeNode *)getChildByKey:(NSString *)childKey {
    DCHTreeNode *result = nil;
    do {
        DCHAssert(self.children != nil && self.childrenDict != nil);
        if (!childKey) {
            break;
        }
        NSString *key = [childKey dch_urlEncodedString];
        result = [self.childrenDict threadSafe_objectForKey:key];
    } while (NO);
    return result;
}

- (NSString *)treeNodeDescription {
    NSString *result = nil;
    do {
        if (!self.key) {
            break;
        }
        if (self.parent) {
            NSString *parentDesc = [self.parent treeNodeDescription];
            result = [NSString stringWithFormat:@"%@%@%@", parentDesc, kDCHTreeNodeSeparator, self.key];
        } else {
            result = [NSString stringWithFormat:@"%@", self.key];
        }
    } while (NO);
    return result;
}

- (DCHTreeNode *)getChildByTreeNodeDescription:(NSString *)desc {
    DCHTreeNode *result = nil;
    do {
        DCHAssert(self.children != nil && self.childrenDict != nil);
        if (!desc) {
            break;
        }
        result = [self getChildByNodeKeyArray:[DCHTreeNode treeNodeDescriptionToKeyArray:desc]];
    } while (NO);
    return result;
}

- (DCHTreeNode *)getChildByNodeKeyArray:(NSArray *)keyArray {
    DCHTreeNode *result = nil;
    do {
        DCHAssert(self.children != nil && self.childrenDict != nil);
        if (!keyArray || keyArray.count == 0) {
            break;
        }
        NSMutableArray *keyAry = [NSMutableArray arrayWithArray:keyArray];
        if (keyAry.count == 0 || ![self.key isEqualToString:[keyAry objectAtIndex:0]]) {
            break;
        }
        [keyAry removeObjectAtIndex:0];
        if (keyAry.count == 0) {
            result = self;
        } else {
            NSString *key = [keyAry objectAtIndex:0];
            DCHTreeNode *node = [self getChildByKey:key];
            if (!node) {
                break;
            }
            result = [node getChildByNodeKeyArray:keyAry];
        }
    } while (NO);
    return result;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    do {
        if (!aCoder || ![aCoder allowsKeyedCoding]) {
            break;
        }
        [aCoder encodeObject:self.key forKey:kDCHTreeNodeCodingKey];
        [aCoder encodeObject:self.value forKey:kDCHTreeNodeCodingValue];
        [aCoder encodeObject:self.children forKey:kDCHTreeNodeCodingChildren];
    } while (NO);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        DCHAssert(aDecoder != nil && [aDecoder allowsKeyedCoding]);
        self.key = [aDecoder decodeObjectForKey:kDCHTreeNodeCodingKey];
        self.value = [aDecoder decodeObjectForKey:kDCHTreeNodeCodingValue];
        self.children = [[aDecoder decodeObjectForKey:kDCHTreeNodeCodingChildren] threadSafe_init:YES];
        self.childrenDict = [[NSMutableDictionary dictionary] threadSafe_init:YES];
        for (DCHTreeNode *node in self.children) {
            node.parent = self;
            [self.childrenDict threadSafe_setObject:node forKey:node.key];
        }
    }
    return self;
}

@end
