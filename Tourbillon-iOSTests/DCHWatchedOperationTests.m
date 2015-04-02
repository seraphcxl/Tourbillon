//
//  DCHWatchedOperationTests.m
//  Tourbillon
//
//  Created by Derek Chen on 4/1/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "DCHTourbillon.h"

@interface DCHTestWatchedOperation : DCHWatchedOperation

@end

@implementation DCHTestWatchedOperation

- (void)main {
    do {
        sleep(2);
        NSLog(@"Hello, world.");
    } while (NO);
}

@end

@interface DCHWatchedOperationTests : XCTestCase

@end

@implementation DCHWatchedOperationTests

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
        __block BOOL done = NO;
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        DCHTestWatchedOperation *op = [[DCHTestWatchedOperation alloc] initWithCompletionHandler:^(DCHWatchedOperation *operation) {
            NSLog(@"DCHWatchedOperation: %@", operation);
            NSLog(@"is canceled: %d", operation.isCancelled);
            done = YES;
        }];
        [queue addOperation:op];
//        [op cancel];
        
        [DCHAsyncTest expect:^BOOL{
            return done;
        } withCompletionHandler:^(BOOL promiseResult, NSError *error, NSDictionary *infoDic) {
            ;
        }];
    } while (NO);
}

@end
