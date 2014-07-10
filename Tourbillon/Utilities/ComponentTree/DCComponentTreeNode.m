//
//  DCComponentTreeNode.m
//  FoundingFather
//
//  Created by Derek Chen on 7/10/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import "DCComponentTreeNode.h"
#import "NSMutableArray+DCGCDThreadSafe.h"
#import "NSMutableDictionary+DCGCDThreadSafe.h"
#import "DCLogger.h"
#import "NSString+DCURLCoding.h"

@interface DCComponentTreeNode ()

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) id value;
@property (strong, nonatomic) NSMutableArray *children;
@property (strong, nonatomic) NSMutableDictionary *childrenDict;

@end

@implementation DCComponentTreeNode

@synthesize key = _key;
@synthesize value = _value;
@synthesize parent = _parent;
@synthesize children = _children;

+ (NSMutableArray *)componentTreeNodeDescriptionToKeyArray:(NSString *)desc {
    NSMutableArray *result = nil;
    do {
        if (!desc) {
            break;
        }
        result = [NSMutableArray array];
        NSScanner *scanner = [NSScanner scannerWithString:desc];
        NSString *separator = @",";
        NSString *key = nil;
        while(![scanner isAtEnd]) {
            [scanner scanUpToString:separator intoString:&key];
            [scanner scanString:separator intoString:NULL];
            [result addObject:result];
        }
    } while (NO);
    return result;
}

- (instancetype)initWithKey:(NSString *)key value:(id)value {
    self = [self init];
    if (self) {
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

- (void)addChild:(DCComponentTreeNode *)child {
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
        for (DCComponentTreeNode *node in children) {
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
        DCComponentTreeNode *node = [self.children threadSafe_objectAtIndex:childIndex];
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
        DCComponentTreeNode *node = [self.childrenDict threadSafe_objectForKey:key];
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

- (DCComponentTreeNode *)getChildAtIndex:(NSUInteger)childIndex {
    DCComponentTreeNode *result = nil;
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
        if (childIndex >= [self.children threadSafe_count]) {
            break;
        }
        result = [self.children threadSafe_objectAtIndex:childIndex];
    } while (NO);
    return result;
}

- (DCComponentTreeNode *)getChildByKey:(NSString *)childKey {
    DCComponentTreeNode *result = nil;
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

- (NSString *)componentTreeNodeDescription {
    NSString *result = nil;
    do {
        if (self.key) {
            break;
        }
        if (self.parent) {
            NSString *parentDesc = [self.parent componentTreeNodeDescription];
            result = [NSString stringWithFormat:@"%@.%@", parentDesc, self.key];
        } else {
            result = [NSString stringWithFormat:@"%@", self.key];
        }
    } while (NO);
    return result;
}

- (DCComponentTreeNode *)getChildByComponentTreeNodeDescription:(NSString *)desc {
    DCComponentTreeNode *result = nil;
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
        if (!desc) {
            break;
        }
        NSMutableArray *keyAry = [DCComponentTreeNode componentTreeNodeDescriptionToKeyArray:desc];
        if (keyAry.count == 0) {
            break;
        }
        NSString *key = [keyAry objectAtIndex:0];
        DCComponentTreeNode *node = [self getChildByKey:key];
        if (!node) {
            break;
        }
        [keyAry removeObjectAtIndex:0];
        result = [node getChildByNodeKeyArray:keyAry];
    } while (NO);
    return result;
}

- (DCComponentTreeNode *)getChildByNodeKeyArray:(NSArray *)keyArray {
    DCComponentTreeNode *result = nil;
    do {
        DCAssert(self.children != nil && self.childrenDict != nil);
        if (!keyArray || keyArray.count == 0) {
            break;
        }
        NSMutableArray *keyAry = [NSMutableArray arrayWithArray:keyArray];
        if (keyAry.count == 0) {
            break;
        }
        NSString *key = [keyAry objectAtIndex:0];
        DCComponentTreeNode *node = [self getChildByKey:key];
        if (!node) {
            break;
        }
        [keyAry removeObjectAtIndex:0];
        result = [node getChildByNodeKeyArray:keyAry];
    } while (NO);
    return result;
}

@end
