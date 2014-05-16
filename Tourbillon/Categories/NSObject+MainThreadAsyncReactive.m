//
//  NSObject+MainThreadAsyncReactive.m
//  Tourbillon
//
//  Created by Derek Chen on 5/16/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSObject+MainThreadAsyncReactive.h"
#import <objc/runtime.h>

static char NSObjectMainThreadAsyncReactiveQueueKey;

@implementation NSObject (MainThreadAsyncReactive)

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

- (void)setMainThreadAsyncReactiveQueue:(NSOperationQueue *)concurrentQueue {
    objc_setAssociatedObject(self, &NSObjectMainThreadAsyncReactiveQueueKey, concurrentQueue, OBJC_ASSOCIATION_RETAIN);
}

- (NSOperationQueue *)getMainThreadAsyncReactiveQueue {
    return (NSOperationQueue *)objc_getAssociatedObject(self, &NSObjectMainThreadAsyncReactiveQueueKey);
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
