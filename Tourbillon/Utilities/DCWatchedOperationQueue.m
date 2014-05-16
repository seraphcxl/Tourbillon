//
//  DCWatchedOperationQueue.m
//  Tourbillon
//
//  Created by Derek Chen on 13-10-14.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "DCWatchedOperationQueue.h"
#import "DCLogger.h"

@interface DCWatchedOperationFinishedActionStub () {
}

@property (nonatomic, weak) id target;
@property (nonatomic, strong) NSThread *thread;

@end

@implementation DCWatchedOperationFinishedActionStub

#pragma mark - DCWatchedOperationFinishedActionStub - Public method
@synthesize operation = _operation;
@synthesize target = _target;
@synthesize thread = _thread;
@synthesize finishedAction = _finishedAction;
@synthesize cancelAction = _cancelAction;

- (id)initWithOperation:(NSOperation *)anOperation forTarget:(id)aTarget withFinishedAction:(SEL)aFinishedAction andCancelAction:(SEL)aCancelAction {
    @synchronized(self) {
        if (!anOperation || !aTarget) {
            return nil;
        }
        self = [super init];
        if (self) {
            _operation = anOperation;
            _target = aTarget;
            self.thread = [NSThread currentThread];
            _finishedAction = aFinishedAction;
            _cancelAction = aCancelAction;
        }
        return self;
    }
}

- (void)dealloc {
    do {
        @synchronized(self) {
            _cancelAction = nil;
            _finishedAction = nil;
            self.thread = nil;
            _target = nil;
            _operation = nil;
        }
    } while (NO);
}

@end

@interface DCWatchedOperationQueue () {
}

@property (nonatomic, strong) NSMutableDictionary *operationToTargetActionDict;
@property (nonatomic, strong) NSThread *queueThread;

- (NSString *)operationUUID:(NSOperation *)operation;
- (void)didFinishOperation:(NSOperation *)operation;

@end

@implementation DCWatchedOperationQueue

#pragma mark - DCWatchedOperationQueue - Public method
@synthesize uuid = _uuid;
@synthesize operationToTargetActionDict = _operationToTargetActionDict;
@synthesize queueThread = _queueThread;

- (id)init {
    @synchronized(self) {
        self = [super init];
        if (self) {
            CFUUIDRef tmpUUID = CFUUIDCreate(kCFAllocatorDefault);
            _uuid = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, tmpUUID));
            CFRelease(tmpUUID);
            
            self.operationToTargetActionDict = [NSMutableDictionary dictionary];
            self.queueThread = [NSThread currentThread];
        }
        return self;
    }
}

- (void)dealloc {
    do {
        @synchronized(self) {
            if (self.operationToTargetActionDict) {
                DCAssert([self.operationToTargetActionDict count] == 0, @"self.operationToTargetActionDict not empty.");
                self.operationToTargetActionDict = nil;
            }
            self.queueThread = nil;
        }
    } while (NO);
}

- (void)addOperation:(NSOperation *)operation forTarget:(id)target withFinishedAction:(SEL)finishedAction andCancelAction:(SEL)cancelAction{
    do {
        if (!operation) {
            break;
        }
        
        NSString *opUUID = [self operationUUID:operation];
        
        @synchronized (self) {
            if (target && (finishedAction || cancelAction)) {
                if (!self.operationToTargetActionDict) {
                    break;
                }
                DCAssert([self.operationToTargetActionDict objectForKey:opUUID] == nil, @"self.operationToTargetActionDict contained stub for op:%@", opUUID);
                DCWatchedOperationFinishedActionStub *stub = [[DCWatchedOperationFinishedActionStub alloc] initWithOperation:operation forTarget:target withFinishedAction:finishedAction andCancelAction:cancelAction];
                [self.operationToTargetActionDict setObject:stub forKey:opUUID];
            }
        }
        
        [operation addObserver:self forKeyPath:@"isFinished" options:0 context:(__bridge void *)(self.uuid)];
        
        [self addOperation:operation];
    } while (NO);
}

- (void)invalidate {
    do {
        if ([NSThread currentThread] != self.queueThread) {
            break;
        }
        @synchronized (self) {
            if (!self.operationToTargetActionDict) {
                break;
            }
            [self.operationToTargetActionDict removeAllObjects];
        }
    } while (NO);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    do {
        if (![object isKindOfClass:[NSOperation class]]) {
            break;
        }
        if (context == (__bridge void *)(self.uuid)) {
            if ([keyPath isEqual:@"isFinished"]) {
                NSString *opUUID = [self operationUUID:object];
                BOOL gotStub = NO;
                @synchronized (self) {
                    if (!self.operationToTargetActionDict) {
                        break;
                    }
                    if ([self.operationToTargetActionDict objectForKey:opUUID] != nil) {
                        gotStub = YES;
                    }
                }
                if (gotStub || [((NSOperation *) object) isFinished]) {
                    [self performSelector:@selector(didFinishOperation:) onThread:self.queueThread withObject:object waitUntilDone:NO];
                }
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } while (NO);
}

- (void)didFinishOperation:(NSOperation *)operation {
    do {
        if (!operation || ![operation isKindOfClass:[NSOperation class]] || ![operation isFinished]) {
            break;
        }
        DCWatchedOperationFinishedActionStub *stub = nil;
        NSString *opUUID = [self operationUUID:operation];
        @synchronized (self) {
            if (!self.operationToTargetActionDict) {
                break;
            }
            stub = [self.operationToTargetActionDict objectForKey:opUUID];
            if (!stub) {
                break;
            }
            [self.operationToTargetActionDict removeObjectForKey:opUUID];
        }
        
        [operation removeObserver:self forKeyPath:@"isFinished"];
        
        if ((stub != nil) && (stub.target != nil) && (stub.thread != nil)) {
            if (![operation isCancelled] && (stub.finishedAction != nil)) {
                [stub.target performSelector:stub.finishedAction onThread:stub.thread withObject:operation waitUntilDone:NO];
            } else if ([operation isCancelled] && (stub.cancelAction != nil)) {
                [stub.target performSelector:stub.cancelAction onThread:stub.thread withObject:operation waitUntilDone:NO];
            }
        }
    } while (NO);
}

#pragma mark - DCWatchedOperationQueue - Private method
- (NSString *)operationUUID:(NSOperation *)operation {
    NSString *result = nil;
    do {
        if (!operation) {
            break;
        }
        result = [NSString stringWithFormat:@"%@", operation];
    } while (NO);
    return result;
}

@end
