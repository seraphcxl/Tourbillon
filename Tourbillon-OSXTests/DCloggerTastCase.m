//
//  DCloggerTastCase.m
//  Tourbillon
//
//  Created by Derek Chen on 9/19/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCloggerTastCase.h"

#import "DCTourbillon.h"

@implementation DCloggerTastCase

- (void)test4MemoryUsageReporter {
    do {
        DCMemoryUsageReporter *r = [[DCMemoryUsageReporter alloc] init];
        for (NSInteger idx = 0; idx < 100; ++idx) {
            [r log];
            NSArray *ary = [NSArray arrayWithObject:@"Hello, world."];
        }
        
//        DCMemoryUsageMonitor *monitor = [[DCMemoryUsageMonitor alloc] init];
//        [monitor start];
        
//        sleep(30);
        
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//        dispatch_time_t timeoutTime = dispatch_time(DISPATCH_TIME_NOW, 30000000000);
//        if (dispatch_semaphore_wait(semaphore, timeoutTime)) {
//            ;
//        }
        
//        [monitor stop];
    } while (NO);
}

@end
