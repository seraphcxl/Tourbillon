//
//  NSThread+DCHBlockExtension.m
//  Tourbillon
//
//  Created by Derek Chen on 4/4/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "NSThread+DCHBlockExtension.h"

@implementation NSThread (DCHBlockExtension)

+ (void)runInMain:(void (^)(void))block {
    do {
        if (!block) {
            break;
        }
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    } while (NO);
}

+ (void)runInBackground:(void (^)(void))block {
    do {
        if (!block) {
            break;
        }
        if (![NSThread isMainThread]) {
            block();
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                block();
            });
        }
    } while (NO);
}

@end
