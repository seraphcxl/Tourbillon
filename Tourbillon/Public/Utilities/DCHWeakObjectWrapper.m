//
//  DCHWeakObjectWrapper.m
//  Tourbillon
//
//  Created by Derek Chen on 8/28/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "DCHWeakObjectWrapper.h"
#import "NSObject+DCHUUIDExtension.h"

@interface DCHWeakObjectWrapper ()

@property (nonatomic, weak) id object;

@end

@implementation DCHWeakObjectWrapper

- (instancetype)initWithObject:(id)object {
    if (!object) {
        return nil;
    }
    self = [self init];
    if (self) {
        self.object = object;
    }
    return self;
}

- (NSString *)uuid {
    return [self.object dch_createMemoryID];
}

@end
