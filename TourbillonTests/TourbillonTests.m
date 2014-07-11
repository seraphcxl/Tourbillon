//
//  TourbillonTests.m
//  TourbillonTests
//
//  Created by Derek Chen on 5/16/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DCTree.h"
#import "DCTreeNode.h"

@interface TourbillonTests : XCTestCase

@end

@implementation TourbillonTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testDCTree {
    DCTree *tree = [[DCTree alloc] initWithRootNodeKey:@"Main" andValue:@"MainV"];
    
    DCTreeNode *naviBar = [[DCTreeNode alloc] initWithKey:@"Navi" andValue:@"NaviV"];
    DCTreeNode *leftBtn = [[DCTreeNode alloc] initWithKey:@"LeftBtn" andValue:@"LeftBtnV"];
    DCTreeNode *rightBtn = [[DCTreeNode alloc] initWithKey:@"RightBtn" andValue:@"RightBtnV"];
    [naviBar addChild:leftBtn];
    [naviBar addChild:rightBtn];
    
    DCTreeNode *view = [[DCTreeNode alloc] initWithKey:@"View" andValue:@"ViewV"];
    DCTreeNode *leftView = [[DCTreeNode alloc] initWithKey:@"LeftView" andValue:@"LeftViewV"];
    DCTreeNode *rightView = [[DCTreeNode alloc] initWithKey:@"RightView" andValue:@"RightViewV"];
    [view addChild:leftView];
    [view addChild:rightView];
    
    [tree actionWithRoot:^BOOL(DCTree *tree, DCTreeNode *node) {
        [node addChild:naviBar];
        [node addChild:view];
        return YES;
    }];
    
    NSLog(@"%@", [tree keyLevelTraversal:NO]);
    NSLog(@"%@", [tree keyLevelTraversal:YES]);
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:tree forKey:@"tree"];
    [archiver finishEncoding];
    
    NSUInteger len = [data length];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    DCTree *otherTree = [unarchiver decodeObjectForKey:@"tree"];
    [unarchiver finishDecoding];
    
    NSLog(@"%@", [otherTree keyLevelTraversal:NO]);
    NSLog(@"%@", [otherTree keyLevelTraversal:YES]);
    
    NSLog(@"%@", [leftBtn treeNodeDescription]);
    
    [tree actionWithNodeByTreeNodeDescription:[leftView treeNodeDescription] andActionBlock:^BOOL(DCTree *tree, DCTreeNode *node) {
        return YES;
    }];
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
