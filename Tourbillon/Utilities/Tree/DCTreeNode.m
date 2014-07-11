//
//  DCTreeNode.m
//  FoundingFather
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import "DCTreeNode.h"
#import "NSMutableArray+DCGCDThreadSafe.h"
#import "NSMutableDictionary+DCGCDThreadSafe.h"
#import "DCLogger.h"
#import "NSString+DCURLCoding.h"

NSString *kDCTreeNodeSeparator = @",";

NSString *kDCTreeNodeCodingKey = @"DCTreeNodeCodingKey";
NSString *kDCTreeNodeCodingValue = @"DCTreeNodeCodingValue";
NSString *kDCTreeNodeCodingChildren = @"DCTreeNodeCodingChildren";

@interface DCTreeNode ()

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) id<NSCoding> value;
@property (strong, nonatomic) NSMutableArray *children;
@property (strong, nonatomic) NSMutableDictionary *childrenDict;

@end

@implementation DCTreeNode

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
            [scanner scanUpToString:kDCTreeNodeSeparator intoString:&key];
            [scanner scanString:kDCTreeNodeSeparator intoString:NULL];
            [result addObject:key];
        }
    } while (NO);
    return result;
}

- (instancetype)initWithKey:(NSString *)key andValue:(id<NSCoding>)value {
    self = [self init];
    if (self) {
        DCAssert(key != nil && [key length] != 0 && value != nil);
        self.key = [[key urlEncodedString] copy];
        self.value = value;
        
        self.parent = nil;
        self.children = [[NSMutableArray array] threadSafe_init];
        self.childrenDict = [[NSMutableDictionary dictionary] threadSafe_init];
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

- (void)addChild:(DCTreeNode *)child {
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
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
        DCAssert(self.children != nil && self.childrenDict != nil);
        if (!children || children.count == 0) {
            break;
        }
        for (DCTreeNode *node in children) {
            [self addChild:node];
        }
    } while (NO);
}

- (void)removeAllChildren {
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
        [self.children threadSafe_removeAllObjects];
        [self.childrenDict threadSafe_removeAllObjects];
    } while (NO);
}

- (void)removeChildrenAtIndex:(NSUInteger)childIndex {
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
        if (childIndex >= [self.children threadSafe_count]) {
            break;
        }
        DCTreeNode *node = [self.children threadSafe_objectAtIndex:childIndex];
        if (node) {
            [self.childrenDict removeObjectForKey:node.key];
        }
        [self.children threadSafe_removeObjectAtIndex:childIndex];
    } while (NO);
}

- (void)removeChildrenByKey:(NSString *)childKey {
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
        if (!childKey) {
            break;
        }
        NSString *key = [childKey urlEncodedString];
        DCTreeNode *node = [self.childrenDict threadSafe_objectForKey:key];
        if (node) {
            [self.children removeObject:node];
        }
        [self.childrenDict removeObjectForKey:key];
    } while (NO);
}

- (void)removeChildrenByArray:(NSArray *)children {
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
        if (!children || children.count == 0) {
            break;
        }
        NSUInteger count = [self.children threadSafe_count];
        for (NSUInteger idx = 0; idx < count; ++idx) {
            [self removeChildrenAtIndex:idx];
        }
    } while (NO);
}

- (DCTreeNode *)getChildAtIndex:(NSUInteger)childIndex {
    DCTreeNode *result = nil;
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
        if (childIndex >= [self.children threadSafe_count]) {
            break;
        }
        result = [self.children threadSafe_objectAtIndex:childIndex];
    } while (NO);
    return result;
}

- (DCTreeNode *)getChildByKey:(NSString *)childKey {
    DCTreeNode *result = nil;
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
        if (!childKey) {
            break;
        }
        NSString *key = [childKey urlEncodedString];
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
            result = [NSString stringWithFormat:@"%@%@%@", parentDesc, kDCTreeNodeSeparator, self.key];
        } else {
            result = [NSString stringWithFormat:@"%@", self.key];
        }
    } while (NO);
    return result;
}

- (DCTreeNode *)getChildByTreeNodeDescription:(NSString *)desc {
    DCTreeNode *result = nil;
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
        if (!desc) {
            break;
        }
        result = [self getChildByNodeKeyArray:[DCTreeNode treeNodeDescriptionToKeyArray:desc]];
    } while (NO);
    return result;
}

- (DCTreeNode *)getChildByNodeKeyArray:(NSArray *)keyArray {
    DCTreeNode *result = nil;
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
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
            DCTreeNode *node = [self getChildByKey:key];
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
        [aCoder encodeObject:self.key forKey:kDCTreeNodeCodingKey];
        [aCoder encodeObject:self.value forKey:kDCTreeNodeCodingValue];
        [aCoder encodeObject:self.children forKey:kDCTreeNodeCodingChildren];
    } while (NO);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        DCAssert(aDecoder != nil && [aDecoder allowsKeyedCoding]);
        self.key = [aDecoder decodeObjectForKey:kDCTreeNodeCodingKey];
        self.value = [aDecoder decodeObjectForKey:kDCTreeNodeCodingValue];
        self.children = [[aDecoder decodeObjectForKey:kDCTreeNodeCodingChildren] threadSafe_init];
        self.childrenDict = [[NSMutableDictionary dictionary] threadSafe_init];
        for (DCTreeNode *node in self.children) {
            node.parent = self;
            [self.childrenDict threadSafe_setObject:node forKey:node.key];
        }
    }
    return self;
}

@end
