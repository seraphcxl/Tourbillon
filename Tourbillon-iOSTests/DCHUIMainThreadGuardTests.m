//
//  DCHUIMainThreadGuardTests.m
//  Tourbillon
//
//  Created by Derek Chen on 4/1/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "DCHTourbillon.h"

@interface DCHUIMainThreadGuardTests : XCTestCase

@end

@implementation DCHUIMainThreadGuardTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMain {
    do {
        [DCHUIMainThreadGuard guarding];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//            UIView *view = [[UIView alloc] init];
//            [view setNeedsDisplay];
//        });
    } while (NO);
}

@end
