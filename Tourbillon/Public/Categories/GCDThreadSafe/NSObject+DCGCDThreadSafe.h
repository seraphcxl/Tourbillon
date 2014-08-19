//
//  NSObject+DCGCDThreadSafe.h
//  Tourbillon
//
//  Created by Derek Chen on 5/8/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DCGCDThreadSafe)

- (instancetype)threadSafe_init;
- (BOOL)threadSafe_QueueSync:(dispatch_block_t) block;
- (BOOL)threadSafe_QueueBarrierAsync:(dispatch_block_t) block;

//DEFINE_ASSOCIATEDOBJECT_FOR_HEADER(GCDThreadSafeQueue)

@end
