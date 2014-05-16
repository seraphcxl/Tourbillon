//
//  DCMainThreadAsyncReactiveObject.m
//  Tourbillon
//
//  Created by Derek Chen on 5/16/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCMainThreadAsyncReactiveObject.h"

@interface DCMainThreadAsyncReactiveObject () {
}

@property (strong, atomic) NSOperationQueue *asyncReactiveQueue;

@end

@implementation DCMainThreadAsyncReactiveObject

@synthesize asyncReactiveQueue = _asyncReactiveQueue;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.asyncReactiveQueue = [[NSOperationQueue alloc] init];
        [self.asyncReactiveQueue setMaxConcurrentOperationCount:1];
    }
    return self;
}

- (void)dealloc {
    do {
        @synchronized(self) {
            if (self.asyncReactiveQueue) {
                [self.asyncReactiveQueue cancelAllOperations];
                [self.asyncReactiveQueue waitUntilAllOperationsAreFinished];
                self.asyncReactiveQueue = nil;
            }
        }
    } while (NO);
}

- (void)addOperationForAsyncReactiveInMainThreadWithBlock:(void (^)(id strongSelf))block {
    do {
        if (!block || !self.asyncReactiveQueue) {
            break;
        }
        
        __weak id weakSelf = self;
        [self.asyncReactiveQueue addOperationWithBlock:^{
            do {
                dispatch_async(dispatch_get_main_queue(), ^{
                    id strongSelf = weakSelf;
                    if (strongSelf) {
                        block(strongSelf);
                    }
                });
            } while (NO);
        }];
    } while (NO);
}

@end
