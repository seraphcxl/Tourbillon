//
//  NSObject+DCMainThreadAsyncReactive.m
//  Tourbillon
//
//  Created by Derek Chen on 5/16/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSObject+DCMainThreadAsyncReactive.h"
#import "NSObject+DCAssociatedObjectExtension.h"

@implementation NSObject (DCMainThreadAsyncReactive)

DEFINE_ASSOCIATEDOBJECT_FOR_CLASS(MainThreadAsyncReactiveQueue, NSObject_DCMainThreadAsyncReactive_QueueKey, OBJC_ASSOCIATION_RETAIN);

- (instancetype)mainThreadAsyncReactive_init {
    do {
        @synchronized(self) {
            if ([self getMainThreadAsyncReactiveQueue]) {
                break;
            }
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [queue setMaxConcurrentOperationCount:1];
            [self setMainThreadAsyncReactiveQueue:queue];
        }
    } while (NO);
    return self;
}

- (void)mainThreadAsyncReactive_dealloc {
    do {
        @synchronized(self) {
            NSOperationQueue *queue = [self getMainThreadAsyncReactiveQueue];
            if (queue) {
                [queue cancelAllOperations];
                [queue waitUntilAllOperationsAreFinished];
                [self setMainThreadAsyncReactiveQueue:nil];
            }
        }
    } while (NO);
}

- (void)addOperationForAsyncReactiveInMainThreadWithBlock:(void (^)(id strongSelf))block {
    do {
        NSOperationQueue *queue = [self getMainThreadAsyncReactiveQueue];
        if (!block || !queue) {
            break;
        }
        
        __weak id weakSelf = self;
        [queue addOperationWithBlock:^{
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
