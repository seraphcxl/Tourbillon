//
//  DCRunLoopOperation.m
//  Tourbillon
//
//  Created by Derek Chen on 13-10-16.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "DCRunLoopOperation.h"
#import "DCLogger.h"

@interface DCRunLoopOperation () {
}

@property (assign, readwrite) DCRunLoopOperationState state;
@property (copy, readwrite) NSError *error;

@end

// debugging infrastructure

#if defined(NDEBUG)

#define DebugLogEvent(str) do { } while (0)

#else

@interface DCRunLoopOperation (UnitTestSupportPrivate)

@property (atomic, assign) NSArray *debugEventLog;

- (void)debugLogEvent:(NSString *)event;

@end

#define DebugLogEvent(str) do { [self debugLogEvent:str]; } while (0)

#endif

@implementation DCRunLoopOperation

@synthesize debugName = _debugName;
@synthesize runLoopThread = _runLoopThread;
@synthesize runLoopModes = _runLoopModes;
@synthesize error = _error;
@synthesize state = _state;

- (id)init {
    @synchronized(self) {
        self = [super init];
        if (self != nil) {
            DCAssert(self.state == kDCRunLoopOperationStateInited);
        }
        return self;
    }
}

- (void)dealloc {
    do {
        @synchronized(self) {
            DCAssert(self.state == kDCRunLoopOperationStateExecuting);
            self.debugName = nil;
            self.runLoopModes = nil;
            self.runLoopThread = nil;
            self.error = nil;
#if ! defined(NDEBUG)
            SAFE_ARC_RELEASE(self->_debugEventLog);
#endif
        }
        SAFE_ARC_SUPER_DEALLOC();
    } while (NO);
}

// Returns the effective run loop thread, that is, the one set by the user
// or, if that's not set, the main thread.
- (NSThread *)actualRunLoopThread {
    NSThread *result = nil;
    do {
        result = self.runLoopThread;
        if (result == nil) {
            result = [NSThread mainThread];
        }
    } while (NO);
    return result;
}

// Returns YES if the current thread is the actual run loop thread.
- (BOOL)isActualRunLoopThread {
    return [[NSThread currentThread] isEqual:self.actualRunLoopThread];
}

- (NSSet *)actualRunLoopModes {
    NSSet *result = nil;
    do {
        result = self.runLoopModes;
        if ((result == nil) || ([result count] == 0)) {
            result = [NSSet setWithObject:NSDefaultRunLoopMode];
        }
    } while (NO);
    return result;
}

- (DCRunLoopOperationState)state {
    return self->_state;
}

// Change the state of the operation, sending the appropriate KVO notifications.
- (void)setState:(DCRunLoopOperationState)newState {
    do {
        DCRunLoopOperationState oldState;
        
        // The following check is really important.  The state can only go forward, and there
        // should be no redundant changes to the state (that is, newState must never be
        // equal to self->_state).
        
        DCAssert(newState > self->_state);
        
        // As a corollary to the above, you can't change the state to inited because it starts
        // out there.
        
        DCAssert(newState != kDCRunLoopOperationStateInited);
        
        // The -start method is the one that transitions from inited to executing,
        // and it can run on any thread.  However, there's no race possible because
        // only one thread is allowed to call -start.  The transition from executing
        // to finished must be done by the run loop thread.
        //
        // There's a subtle requirement here, namely that -start must change the state
        // before scheduling -startOnRunLoopThread.  Without that, the inited to executing
        // and executing to finished changes race.
        
        DCAssert((newState == kDCRunLoopOperationStateExecuting) || self.isActualRunLoopThread);
        
        // Change the state and send the right KVO notifications.
        
        // inited    + executing -> isExecuting
        // inited    + finished  -> isFinished
        // executing + finished  -> isExecuting + isFinished
        
        oldState = self->_state;
        if ((newState == kDCRunLoopOperationStateExecuting) || (oldState == kDCRunLoopOperationStateExecuting)) {
            [self willChangeValueForKey:@"isExecuting"];
        }
        if (newState == kDCRunLoopOperationStateFinished) {
            [self willChangeValueForKey:@"isFinished"];
        }
        self->_state = newState;
        if (newState == kDCRunLoopOperationStateFinished) {
            [self didChangeValueForKey:@"isFinished"];
        }
        if ((newState == kDCRunLoopOperationStateExecuting) || (oldState == kDCRunLoopOperationStateExecuting)) {
            [self didChangeValueForKey:@"isExecuting"];
        }
        
        // Log the change.
#if !defined(NDEBUG)
        switch (newState) {
            default:
                DCAssert(NO);
                // fall through
            case kDCRunLoopOperationStateInited: {
                DebugLogEvent(@"-setState.inited");
            } break;
            case kDCRunLoopOperationStateExecuting: {
                DebugLogEvent(@"-setState.executing");
            } break;
            case kDCRunLoopOperationStateFinished: {
                DebugLogEvent(@"-setState.finished");
            } break;
        }
#endif
    } while (NO);
}

// Starts the operation.  The actual -start method is very simple,
// deferring all of the work to be done on the run loop thread by this
// method.
- (void)startOnRunLoopThread {
    do {
        DebugLogEvent(@">startOnRunLoopThread");
        
        DCAssert(self.isActualRunLoopThread);
        DCAssert(self.state != kDCRunLoopOperationStateInited);
        
        // State might be kQRunLoopOperationStateFinished at this point if someone managed
        // to cancel us from the actual run loop thread between -start and -startOnRunLoopThread.
        // In that case we've already finished, so we just do nothing.
        
        if (self.state == kDCRunLoopOperationStateExecuting) {
            if ([self isCancelled]) {
                DebugLogEvent(@"-startOnRunLoopThread.cancelled");
                
                // We were cancelled before we even got running.  Flip the the finished
                // state immediately.
                
                [self finishWithError:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
            } else {
                DebugLogEvent(@"-startOnRunLoopThread.start");
                [self operationDidStart];
            }
        } else {
            DebugLogEvent(@"-startOnRunLoopThread.bounce");
        }
        
        DebugLogEvent(@"<startOnRunLoopThread");
    } while (NO);
}

// Cancels the operation.
- (void)cancelOnRunLoopThread {
    do {
        DebugLogEvent(@">cancelOnRunLoopThread");
        
        DCAssert(self.isActualRunLoopThread);
        
        // We know that a) state was kQRunLoopOperationStateExecuting when we were
        // scheduled (that's enforced by -cancel), and b) the state can't go
        // backwards (that's enforced by -setState), so we know the state must
        // either be kQRunLoopOperationStateExecuting or kQRunLoopOperationStateFinished.
        // We also know that the transition from executing to finished always
        // happens on the run loop thread.  Thus, we don't need to lock here.
        // We can look at state and, if we're executing, trigger a cancellation.
        
        if (self.state == kDCRunLoopOperationStateExecuting) {
            DebugLogEvent(@"-cancelOnRunLoopThread.cancel");
            [self finishWithError:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
        } else {
            DebugLogEvent(@"-cancelOnRunLoopThread.bounce");
        }
        DebugLogEvent(@"<cancelOnRunLoopThread");
    } while (NO);
}

- (BOOL)isConcurrent {
    // any thread
    return YES;
}

- (BOOL)isExecuting {
    // any thread
    return self->_state == kDCRunLoopOperationStateExecuting;
}

- (BOOL)isFinished {
    // any thread
    return self->_state == kDCRunLoopOperationStateFinished;
}

- (void)start {
    do {
        DebugLogEvent(@">start");
        
        // any thread
        
        DCAssert(self.state == kDCRunLoopOperationStateInited);
        
        // We have to change the state here, otherwise isExecuting won't necessarily return
        // true by the time we return from -start.  Also, we don't test for cancellation
        // here because that would a) result in us sending isFinished notifications on a
        // thread that isn't our run loop thread, and b) confuse the core cancellation code,
        // which expects to run on our run loop thread.  Finally, we don't have to worry
        // about races with other threads calling -start.  Only one thread is allowed to
        // start us at a time.
        
        self.state = kDCRunLoopOperationStateExecuting;
#if ! defined(NDEBUG)
        if (self.debugCancelSelfBeforeSchedulingStart) {
            DebugLogEvent(@"-start.cancelBefore");
            [self cancel];
        }
#endif
        [self performSelector:@selector(startOnRunLoopThread) onThread:self.actualRunLoopThread withObject:nil waitUntilDone:NO modes:[self.actualRunLoopModes allObjects]];
#if ! defined(NDEBUG)
        if (self.debugCancelSelfAfterSchedulingStart) {
            DebugLogEvent(@"-start.cancelAfter");
            [self cancel];
        }
#endif
        
        DebugLogEvent(@"<start");
    } while (NO);
}

- (void)cancel {
    do {
        BOOL runCancelOnRunLoopThread = NO;
        BOOL oldValue = NO;
        
        DebugLogEvent(@">cancel");
        
        // any thread
        
        // We synchronise here to ensure that only one thread calls [super cancel].
        
        @synchronized (self) {
            oldValue = [self isCancelled];
            
            if (!oldValue) {
                DebugLogEvent(@"-cancel.winner");
            }
            
            // Call our super class so that isCancelled starts returning true immediately.
            
            [super cancel];
            
            // If we were the one to set isCancelled (that is, we won the race with regards
            // other threads calling -cancel) and we're actually running (that is, we lost
            // the race with other threads calling -start and the run loop thread finishing),
            // we schedule to run on the run loop thread.
            //
            // The concurrency guarantee here is kinda hazy.  Specifically, state can change
            // immediately after we read it (because of another thread calling -start or
            // the run loop thread finishing).  There are two important cases to consider here:
            //
            // o -start taking us from inited to executing -- We might want to schedule
            //   -cancelOnRunLoopThread in this case, but we miss our chance.  That's OK though:
            //   after changing the state -start will schedule -startOnRunLoopThread which will
            //   check for cancellation.
            //
            // o run loop thread taking us from executing to finished -- In this case we might
            //   schedule -cancelOnRunLoopThread redundantly.  That's OK though because
            //   -cancelOnRunLoopThread will just bounce in that case.
            
            runCancelOnRunLoopThread = ! oldValue && self.state == kDCRunLoopOperationStateExecuting;
        }
        if (runCancelOnRunLoopThread) {
#if ! defined(NDEBUG)
            if (self.debugSecondaryThreadCancelDelay > 0.0) {
                if ( ! self.isActualRunLoopThread ) {
                    DebugLogEvent(@"-cancel.delay");
                    [NSThread sleepForTimeInterval:self.debugSecondaryThreadCancelDelay];
                }
            }
#endif
            DebugLogEvent(@"-cancel.schedule");
            [self performSelector:@selector(cancelOnRunLoopThread) onThread:self.actualRunLoopThread withObject:nil waitUntilDone:NO modes:[self.actualRunLoopModes allObjects]];
        }
        DebugLogEvent(@"<cancel");
    } while (NO);
}

@end

@implementation DCRunLoopOperation (SubClassSupport)

- (void)finishWithError:(NSError *)error {
    do {
        DebugLogEvent(@">finishWithError");
        
        DCAssert(self.isActualRunLoopThread);
        // error may be nil
        
        // Latch the error.  This code is very simple once you remove all the debug logging (-:
        if (self.error == nil) {
            if (error != nil) {
                DebugLogEvent(@"-finishWithError.error");
            } else {
                DebugLogEvent(@"-finishWithError.noError");
            }
            self.error = error;
        } else {
            if (error != nil) {
                DebugLogEvent(@"-finishWithError.bounceError");
            } else {
                DebugLogEvent(@"-finishWithError.bounceNoError");
            }
        }
        
        // Call -operationWillFinish to let subclasses know about the change.
        
        [self operationWillFinish];
        
        // Make the change.
        
        self.state = kDCRunLoopOperationStateFinished;
        
        DebugLogEvent(@"<finishWithError");
    } while (NO);
}

- (void)operationDidStart {
    DCAssert(self.isActualRunLoopThread);
}

- (void)operationWillFinish {
    DCAssert(self.isActualRunLoopThread);
}

@end

#if ! defined(NDEBUG)

@implementation DCRunLoopOperation (UnitTestSupport)

// The compiler won't let me @synthesize these accessors, so we write them out
// by hand.  Fortunately they are single item "assign" properties, so atomicity is
// not a problem.

// If debugCancelSelfBeforeSchedulingStart is set, -start calls -cancel
// before scheduling -startOnRunLoopThread.

- (BOOL)debugCancelSelfBeforeSchedulingStart {
    return self->_debugCancelSelfBeforeSchedulingStart;
}

- (void)setDebugCancelSelfBeforeSchedulingStart:(BOOL)newValue {
    self->_debugCancelSelfBeforeSchedulingStart = newValue;
}

// If debugCancelSelfAfterSchedulingStart is set, -start calls -cancel
// after scheduling -startOnRunLoopThread.

- (BOOL)debugCancelSelfAfterSchedulingStart {
    return self->_debugCancelSelfAfterSchedulingStart;
}

- (void)setDebugCancelSelfAfterSchedulingStart:(BOOL)newValue {
    self->_debugCancelSelfAfterSchedulingStart = newValue;
}

// debugSecondaryThreadCancelDelay controls a delay in -cancel, just
// before is schedules -cancelOnRunLoopThread.

- (NSTimeInterval)debugSecondaryThreadCancelDelay {
    return self->_debugSecondaryThreadCancelDelay;
}

- (void)setDebugSecondaryThreadCancelDelay:(NSTimeInterval)newValue {
    self->_debugSecondaryThreadCancelDelay = newValue;
}

// Returns the current event log.
- (NSArray *)debugEventLog {
    NSArray *result = nil;
    do {
        // Synchronisation is necessary to avoid accessing the array while
        // it's being mutated by another thread.
        
        @synchronized (self) {
            // _debugEventLog may be nil, and that's OK.
            result = [self->_debugEventLog copy];
            SAFE_ARC_AUTORELEASE(result);
        }
    } while (NO);
    return result;
}

// Enables the event log on this object.
- (void)debugEnableEventLog {
    do {
        // Synchronisation is necessary to because it's reasonable for multiple
        // threads to call this routine at once.
        
        @synchronized (self) {
            if (self->_debugEventLog == nil) {
                self->_debugEventLog = [[NSMutableArray alloc] init];
            }
        }
    } while (NO);
}

// Called by the implementation to log events.
- (void)debugLogEvent:(NSString *)event {
    do {
        DCAssert(event != nil);
        
        // Synchronisation is necessary because multiple threads might be adding
        // events concurrently.
        
        @synchronized (self) {
            if (self->_debugEventLog != nil) {
                [self->_debugEventLog addObject:event];
            }
        }
    } while (NO);
}

@end

#endif
