//
//  DCMemoryUsageMonitor.h
//  Tourbillon
//
//  Created by Derek Chen on 9/19/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCMemoryUsageMonitor : NSObject

- (void)start;
- (void)stop;

- (void)setTimeInterval:(NSTimeInterval)ti;

@end
