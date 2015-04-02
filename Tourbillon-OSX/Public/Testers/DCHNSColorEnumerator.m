//
//  DCHNSColorEnumerator.m
//  Tourbillon
//
//  Created by Derek Chen on 10/10/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCHNSColorEnumerator.h"

@interface DCHNSColorEnumerator ()

@property (assign, nonatomic) NSUInteger idx;
@property (strong, nonatomic) NSMutableArray *ary;

@end

@implementation DCHNSColorEnumerator

@synthesize idx = _idx;
@synthesize ary = _ary;

DCH_DEFINE_SINGLETON_FOR_CLASS(DCHNSColorEnumerator)

- (id)init {
    self = [super init];
    if (self) {
        _idx = 0;
        self.ary = [NSMutableArray array];
        
        [self.ary addObject:[NSColor clearColor]];
        
        [self.ary addObject:[NSColor blackColor]];
        [self.ary addObject:[NSColor darkGrayColor]];
        [self.ary addObject:[NSColor grayColor]];
        [self.ary addObject:[NSColor lightGrayColor]];
        [self.ary addObject:[NSColor whiteColor]];
        
        [self.ary addObject:[NSColor redColor]];
        [self.ary addObject:[NSColor orangeColor]];
        [self.ary addObject:[NSColor yellowColor]];
        [self.ary addObject:[NSColor greenColor]];
        [self.ary addObject:[NSColor cyanColor]];
        [self.ary addObject:[NSColor blueColor]];
        [self.ary addObject:[NSColor purpleColor]];
    }
    return self;
}

- (void)reset {
    do {
        self.idx = 0;
    } while (NO);
}

- (NSColor *)next {
    NSColor *result = nil;
    do {
        self.idx = (self.idx >= self.ary.count) ? (self.idx % self.ary.count) : self.idx;
        result = self.ary[self.idx];
    } while (NO);
    return result;
}

@end
