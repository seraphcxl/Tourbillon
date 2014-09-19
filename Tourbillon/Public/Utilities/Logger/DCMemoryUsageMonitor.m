//
//  DCMemoryUsageMonitor.m
//  Tourbillon
//
//  Created by Derek Chen on 9/19/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCMemoryUsageMonitor.h"
#import "DCMemoryUsageReporter.h"
#import "DCCommonFuncations.h"

@interface DCMemoryUsageMonitor ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) DCMemoryUsageReporter *memUsageReporter;

- (void)createTimerWithTimeInterval:(NSTimeInterval)ti;
- (void)clearTimer;

- (void)actionForTimer:(NSTimer *)timer;

@end

@implementation DCMemoryUsageMonitor

@synthesize timer = _timer;
@synthesize memUsageReporter = _memUsageReporter;

- (id)init {
    self = [super init];
    if (self) {
        _memUsageReporter = [[DCMemoryUsageReporter alloc] init];
    }
    return self;
}

- (void)dealloc {
    do {
        [self clearTimer];
        self.memUsageReporter = nil;
    } while (NO);
}

- (void)start {
    do {
        [self createTimerWithTimeInterval:5];
    } while (NO);
}

- (void)stop {
    do {
        [self clearTimer];
    } while (NO);
}

- (void)setTimeInterval:(NSTimeInterval)ti {
    do {
        [self clearTimer];
        
        [self createTimerWithTimeInterval:ti];
    } while (NO);
}

- (void)createTimerWithTimeInterval:(NSTimeInterval)ti {
    do {
        @synchronized (self) {
            if (!_timer) {
                _timer = [NSTimer timerWithTimeInterval:ti target:self selector:@selector(actionForTimer:) userInfo:nil repeats:YES];
                
                [DCCommonFuncations actionInMainThread:^{
                    @synchronized (self) {
                        if (self.timer) {
                            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
                        }
                    }
                }];
            }
        }
    } while (NO);
}

- (void)clearTimer {
    do {
        @synchronized (self) {
            if (_timer) {
                [_timer invalidate];
                self.timer = nil;
            }
        }
    } while (NO);
}

- (void)actionForTimer:(NSTimer *)timer {
    do {
        if (!timer) {
            break;
        }
        @synchronized (self) {
            if (_memUsageReporter) {
                [_memUsageReporter log];
            }
        }
    } while (NO);
}

@end
