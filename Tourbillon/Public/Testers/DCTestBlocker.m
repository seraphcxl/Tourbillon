//
//  DCTestBlocker.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-8.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "DCTestBlocker.h"

@interface DCTestBlocker () {
}

@property (nonatomic, assign) NSInteger signalsRemaining;
@property (nonatomic, assign) NSInteger expectedSignalCount;

- (NSInteger)reset;

@end

@implementation DCTestBlocker

@synthesize signalsRemaining = _signalsRemaining;
@synthesize expectedSignalCount = _expectedSignalCount;

#pragma mark - DCDataStoreManager - Public method
- (id)init {
    @synchronized (self) {
        return [self initWithExpectedSignalCount:1];
    }
}

- (id)initWithExpectedSignalCount:(NSInteger)expectedSignalCount {
    @synchronized (self) {
        if (self = [super init]) {
            self.expectedSignalCount = expectedSignalCount;
            [self reset];
        }
        return self;
    }
}

- (BOOL)wait {
    BOOL result = NO;
    do {
        @synchronized (self) {
            result = [self waitWithTimeout:0];
        }
    } while (NO);
    return result;
}

- (BOOL)waitWithPeriodicHandler:(DCTestBlockerPeriodicHandler)handler {
    BOOL result = NO;
    do {
        @synchronized (self) {
            result = [self waitWithTimeout:0 periodicHandler:handler];
        }
    } while (NO);
    return result;
}

- (BOOL)waitWithTimeout:(NSTimeInterval)timeout {
    BOOL result = NO;
    do {
        @synchronized (self) {
            result = [self waitWithTimeout:timeout periodicHandler:nil];
        }
    } while (NO);
    return result;
}

- (BOOL)waitWithTimeout:(NSTimeInterval)timeout periodicHandler:(DCTestBlockerPeriodicHandler)handler {
    BOOL result = NO;
    do {
        @synchronized (self) {
            NSDate *start = [NSDate date];
            
            BOOL allowReturn = NO;
            // loop until the previous call completes
            while (_signalsRemaining > 0) {
                [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
                if (timeout > 0 && [[NSDate date] timeIntervalSinceDate:start] > timeout) {
                    [self reset];
                    result = NO;
                    allowReturn = YES;
                }
                if (handler) {
                    handler(self);
                }
            };
            
            if (!allowReturn) {
                [self reset];
                result = YES;
            }
        }
    } while (NO);
    return result;
    
}

- (NSInteger)signal {
    @synchronized (self) {
        return --self.signalsRemaining;
    }
}

#pragma mark - DCDataStoreManager - Private method
- (NSInteger)reset {
    @synchronized (self) {
        self.signalsRemaining = self.expectedSignalCount;
        return self.signalsRemaining;
    }
    
}
@end
