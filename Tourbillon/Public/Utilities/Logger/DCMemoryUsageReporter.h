//
//  DCMemoryUsageReporter.h
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCMemoryUsageReporter : NSObject {
}

@property (nonatomic, assign, readonly) long prevMemUsage;  // size in bytes
@property (nonatomic, assign, readonly) long curMemUsage;  // size in bytes
@property (nonatomic, assign, readonly) long memUsageDiff;  // size in bytes
@property (nonatomic, assign, readonly) long curFreeMem;  // size in bytes
@property (nonatomic, assign) long minMemUsageDiff;  // size in bytes, default is 100KB

- (void)reportMemoryUsage;
- (NSString *)log;

@end
