//
//  DCWatchedOperationQueue.h
//  Tourbillon
//
//  Created by Derek Chen on 13-10-14.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCSafeARC.h"

@interface DCWatchedOperationFinishedActionStub : NSObject {
}

@property (nonatomic, SAFE_ARC_PROP_WEAK, readonly) NSOperation *operation;
@property (nonatomic, SAFE_ARC_PROP_WEAK, readonly) id target;
@property (nonatomic, SAFE_ARC_PROP_STRONG, readonly) NSThread *thread;
@property (nonatomic, assign, readonly) SEL finishedAction;
@property (nonatomic, assign, readonly) SEL cancelAction;

- (id)initWithOperation:(NSOperation *)anOperation forTarget:(id)aTarget withFinishedAction:(SEL)aFinishedAction andCancelAction:(SEL)aCancelAction;

@end

@interface DCWatchedOperationQueue : NSOperationQueue {
}

@property (atomic, SAFE_ARC_PROP_STRONG, readonly) NSString *uuid;

- (void)addOperation:(NSOperation *)operation forTarget:(id)target withFinishedAction:(SEL)finishedAction andCancelAction:(SEL)cancelAction;
- (void)invalidate;

@end
