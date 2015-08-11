//
//  NSThread+DCHBlockExtension.m
//  Tourbillon
//
//  Created by Derek Chen on 4/4/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSThread+DCHBlockExtension.h"

@implementation NSThread (DCHBlockExtension)

+ (void)dch_runInMain:(void (^)(void))block {
    do {
        if ([NSThread isMainThread]) {
            if (block) {
                block();
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (block) {
                    block();
                }
            });
        }
    } while (NO);
}

+ (void)dch_runInBackground:(void (^)(void))block {
    do {
        if (![NSThread isMainThread]) {
            if (block) {
                block();
            }
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                if (block) {
                    block();
                }
            });
        }
    } while (NO);
}

+ (void)dch_run:(void (^)(void))block synchronous:(BOOL)sync {
    do {
        if (sync) {
            if (block) {
                block();
            }
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                if (block) {
                    block();
                }
            });
        }
    } while (NO);
}

@end
