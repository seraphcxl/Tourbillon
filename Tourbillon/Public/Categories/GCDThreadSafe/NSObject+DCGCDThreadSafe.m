//
//  NSObject+DCGCDThreadSafe.m
//  Tourbillon
//
//  Created by Derek Chen on 5/8/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSObject+DCGCDThreadSafe.h"
#import "NSObject+DCSwizzle.h"
#import "NSObject+DCAssociatedObjectExtension.h"

@implementation NSObject (DCGCDThreadSafe)

DEFINE_ASSOCIATEDOBJECT_FOR_CLASS(GCDThreadSafeQueue, NSObject_DCGCDThreadSafe_QueueKey, OBJC_ASSOCIATION_RETAIN);

- (instancetype)threadSafe_init {
    do {
        @synchronized(self) {
            if ([self getGCDThreadSafeQueue]) {
                break;
            }
            NSString *uuid = [NSString stringWithFormat:@"%@_GCDThreadSafeQueue_%p", [[self class] description], self];
            dispatch_queue_t concurrentQueue = dispatch_queue_create([uuid UTF8String], DISPATCH_QUEUE_CONCURRENT);
            [self setGCDThreadSafeQueue:(__bridge id)(concurrentQueue)];
        }
    } while (NO);
    return self;
}

//- (void)setGCDThreadSafeQueue:(dispatch_queue_t)concurrentQueue {
//    objc_setAssociatedObject(self, &NSObject_DCGCDThreadSafe_QueueKey, (__bridge id)(concurrentQueue), OBJC_ASSOCIATION_RETAIN);
//}
//
//- (dispatch_queue_t)getGCDThreadSafeQueue {
//    return (__bridge dispatch_queue_t)(objc_getAssociatedObject(self, &NSObject_DCGCDThreadSafe_QueueKey));
//}

- (BOOL)threadSafe_QueueSync:(dispatch_block_t)block {
    BOOL result = NO;
    do {
        if (!block) {
            break;
        }
        dispatch_queue_t concurrentQueue = (__bridge dispatch_queue_t)([self getGCDThreadSafeQueue]);
        if (!concurrentQueue) {
            break;
        }
        dispatch_sync(concurrentQueue, block);
        result = YES;
    } while (NO);
    return result;
}

- (BOOL)threadSafe_QueueBarrierAsync:(dispatch_block_t)block {
    BOOL result = NO;
    do {
        if (!block) {
            break;
        }
        dispatch_queue_t concurrentQueue = (__bridge dispatch_queue_t)([self getGCDThreadSafeQueue]);
        if (!concurrentQueue) {
            break;
        }
        dispatch_barrier_async(concurrentQueue, block);
        result = YES;
    } while (NO);
    return result;
}

@end
