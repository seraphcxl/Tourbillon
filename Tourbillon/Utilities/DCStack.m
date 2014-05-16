//
//  DCStack.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-15.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "DCStack.h"

@interface DCStack () {
}

@property (nonatomic, SAFE_ARC_PROP_STRONG) NSMutableArray *objects;

@end

@implementation DCStack

- (id)init {
    @synchronized(self) {
        self = [self initWithArray:nil];
        return self;
    }
}

- (id)initWithArray:(NSArray *)array {
    @synchronized(self) {
        self = [super init];
        if (self) {
            self.objects = [NSMutableArray arrayWithArray:array];
        }
        return self;
    }
}

- (void)dealloc {
    do {
        @synchronized(self) {
            self.objects = nil;
        }
        SAFE_ARC_SUPER_DEALLOC();
    } while (NO);
}

- (NSUInteger)count {
    NSUInteger result = 0;
    do {
        if (!self.objects) {
            break;
        }
        result = [self.objects count];
    } while (NO);
    return result;
}

- (void)pushObject:(id)object {
    do {
        if (!object || !self.objects) {
            break;
        }
        @synchronized(self) {
            [self.objects addObject:object];
        }
    } while (NO);
}

- (void)pushObjects:(NSArray *)objects {
    do {
        if (!objects || ([objects count] == 0) || !self.objects) {
            break;
        }
        @synchronized(self) {
            for (id obj in objects) {
                [self.objects addObject:obj];
            }
        }
    } while (NO);
}

- (id)popObject {
    id result = nil;
    do {
        if (!self.objects || [self.objects count] == 0) {
            break;
        }
        @synchronized(self) {
            result = [self peekObject];
            [self.objects removeLastObject];
        }
    } while (NO);
    return result;
}

- (id)peekObject {
    id result = nil;
    do {
        if (!self.objects || [self.objects count] == 0) {
            break;
        }
        @synchronized(self) {
            result = [self.objects objectAtIndex:([self.objects count] - 1)];
        }
    } while (NO);
    return result;
}

#pragma mark - DCStack - NSFastEnumeration
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len {
    return [self.objects countByEnumeratingWithState:state objects:buffer count:len];
}

@end
