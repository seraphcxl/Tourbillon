//
//  NSObject+DCHThreadSafe.m
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSObject+DCHThreadSafe.h"
#import "NSObject+DCHSwizzle.h"
#import "NSObject+DCHAssociatedObjectExtension.h"

@implementation NSObject (DCHThreadSafe)

DCH_DEFINE_ASSOCIATEDOBJECT_FOR_CLASS(GCDThreadSafeQueue, NSObject_DCHGCDThreadSafeQueue_Key, OBJC_ASSOCIATION_RETAIN);

DCH_DEFINE_ASSOCIATEDOBJECT_FOR_CLASS(SyncSetting, NSObject_DCHSyncSetting_Key, OBJC_ASSOCIATION_ASSIGN);

- (instancetype)threadSafe_init:(BOOL)isSyncSetting {
    do {
        @synchronized(self) {
            if ([self getGCDThreadSafeQueue]) {
                break;
            }
            NSString *uuid = [NSString stringWithFormat:@"%@_GCDThreadSafeQueue_%p", [[self class] description], self];
            dispatch_queue_t concurrentQueue = dispatch_queue_create([uuid UTF8String], DISPATCH_QUEUE_CONCURRENT);
            [self setGCDThreadSafeQueue:concurrentQueue];
            [self setSyncSetting:[NSNumber numberWithBool:isSyncSetting]];
        }
    } while (NO);
    return self;
}

- (BOOL)isSyncSetting {
    BOOL result = NO;
    do {
        result = [[self getSyncSetting] boolValue];
    } while (NO);
    return result;
}

- (BOOL)threafSafe_Setting:(dispatch_block_t)block {
    BOOL result = NO;
    do {
        if (!block) {
            break;
        }
        dispatch_queue_t concurrentQueue = [self getGCDThreadSafeQueue];
        if (!concurrentQueue) {
            break;
        }
        if ([self isSyncSetting]) {
            dispatch_barrier_sync(concurrentQueue, block);
        } else {
            dispatch_barrier_async(concurrentQueue, block);
        }
        result = YES;
    } while (NO);
    return result;
}

- (BOOL)threadSafe_QueueSync:(dispatch_block_t)block {
    BOOL result = NO;
    do {
        if (!block) {
            break;
        }
        dispatch_queue_t concurrentQueue = [self getGCDThreadSafeQueue];
        if (!concurrentQueue) {
            break;
        }
        dispatch_sync(concurrentQueue, block);
        result = YES;
    } while (NO);
    return result;
}

- (BOOL)threadSafe_QueueBarrierSync:(dispatch_block_t)block {
    BOOL result = NO;
    do {
        if (!block) {
            break;
        }
        dispatch_queue_t concurrentQueue = [self getGCDThreadSafeQueue];
        if (!concurrentQueue) {
            break;
        }
        dispatch_barrier_sync(concurrentQueue, block);
        result = YES;
    } while (NO);
    return result;
}

- (BOOL)threadSafe_QueueAsync:(dispatch_block_t)block {
    BOOL result = NO;
    do {
        if (!block) {
            break;
        }
        dispatch_queue_t concurrentQueue = [self getGCDThreadSafeQueue];
        if (!concurrentQueue) {
            break;
        }
        dispatch_async(concurrentQueue, block);
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
        dispatch_queue_t concurrentQueue = [self getGCDThreadSafeQueue];
        if (!concurrentQueue) {
            break;
        }
        dispatch_barrier_async(concurrentQueue, block);
        result = YES;
    } while (NO);
    return result;
}

@end
