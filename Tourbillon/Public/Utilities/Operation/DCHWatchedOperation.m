//
//  DCHWatchedOperation.m
//  Tourbillon
//
//  Created by Derek Chen on 4/1/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "DCHWatchedOperation.h"
#import "NSObject+DCHUUIDExtension.h"

@interface DCHWatchedOperation ()

@property (nonatomic, copy) DCHWatchedOperationCompletionHandler completionHandler;

@end

@implementation DCHWatchedOperation

- (void)dealloc {
    do {
        [self removeObserver:self forKeyPath:@"isFinished"];
        self.completionHandler = nil;
    } while (NO);
}

- (instancetype)initWithCompletionHandler:(DCHWatchedOperationCompletionHandler)completionHandler {
    if (!completionHandler) {
        return nil;
    }
    self = [self init];
    if (self) {
        self.completionHandler = completionHandler;
        [self addObserver:self forKeyPath:@"isFinished" options:0 context:(__bridge void *)([self createMemoryID])];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    do {
        if (![object isKindOfClass:[DCHWatchedOperation class]]) {
            break;
        }
        NSString *uuid = (__bridge NSString *)context;
        if ([[self createMemoryID] isEqualToString:uuid]) {
            if ([keyPath isEqual:@"isFinished"]) {
                self.completionHandler(self);
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } while (NO);
}

@end
