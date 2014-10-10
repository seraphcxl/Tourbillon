//
//  DCColorEnumerator.m
//  Tourbillon
//
//  Created by Derek Chen on 10/10/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCColorEnumerator.h"

@interface DCColorEnumerator ()

@property (assign, nonatomic) NSUInteger idx;
@property (strong, nonatomic) NSMutableArray *ary;

@end

@implementation DCColorEnumerator

@synthesize idx = _idx;
@synthesize ary = _ary;

DEFINE_SINGLETON_FOR_CLASS(DCColorEnumerator)

- (id)init {
    self = [super init];
    if (self) {
        _idx = 0;
        self.ary = [NSMutableArray array];
        
        [self.ary addObject:[UIColor clearColor]];
        
        [self.ary addObject:[UIColor blackColor]];
        [self.ary addObject:[UIColor darkGrayColor]];
        [self.ary addObject:[UIColor grayColor]];
        [self.ary addObject:[UIColor lightGrayColor]];
        [self.ary addObject:[UIColor whiteColor]];
        
        [self.ary addObject:[UIColor redColor]];
        [self.ary addObject:[UIColor orangeColor]];
        [self.ary addObject:[UIColor yellowColor]];
        [self.ary addObject:[UIColor greenColor]];
        [self.ary addObject:[UIColor cyanColor]];
        [self.ary addObject:[UIColor blueColor]];
        [self.ary addObject:[UIColor purpleColor]];
    }
    return self;
}

- (void)reset {
    do {
        self.idx = 0;
    } while (NO);
}

- (UIColor *)next {
    UIColor *result = nil;
    do {
        self.idx = self.idx >= self.ary.count ? self.idx % self.ary.count : self.idx;
        result = self.ary[self.idx];
    } while (NO);
    return result;
}

@end
