//
//  NSObject+DCHThreadSafe.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DCHThreadSafe)

- (instancetype)dch_threadSafe_init:(BOOL)isSyncSetting;
- (void)dch_threadSafe_uninit;
- (BOOL)isSyncSetting;
- (BOOL)threafSafe_Setting:(dispatch_block_t) block;

- (BOOL)dch_threadSafe_QueueSync:(dispatch_block_t) block;
- (BOOL)dch_threadSafe_QueueBarrierSync:(dispatch_block_t) block;

- (BOOL)dch_threadSafe_QueueAsync:(dispatch_block_t) block;
- (BOOL)dch_threadSafe_QueueBarrierAsync:(dispatch_block_t) block;

@end
