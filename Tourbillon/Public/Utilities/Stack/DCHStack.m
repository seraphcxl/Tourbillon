//
//  DCHStack.m
//  Tourbillon
//
//  Created by Derek Chen on 2/13/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "DCHStack.h"
#import "NSMutableArray+DCHThreadSafe.h"

const NSUInteger kDCHStackDefaultCount = 128;

@interface DCHStack () {
}

@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, strong) NSMutableArray *objects;

- (void)removeFirstObject;
- (void)removeObjectsInRange:(NSRange)range;

@end

@implementation DCHStack

@synthesize count = _count;
@synthesize maxCount = _maxCount;
@synthesize objects = _objects;

- (instancetype)init {
    @synchronized(self) {
        self = [self initWithArray:@[]];
        return self;
    }
}

- (instancetype)initWithArray:(NSArray *)array {
    @synchronized(self) {
        self = [super init];
        if (self) {
            self.maxCount = kDCHStackDefaultCount;
            self.objects = [[NSMutableArray arrayWithArray:array] DCH_threadSafe_init:YES];
        }
        return self;
    }
}

- (void)setMaxCount:(NSUInteger)newMaxCount {
    do {
        if (newMaxCount <= 0) {
            break;
        }
        NSInteger diff = _maxCount - newMaxCount;
        if (diff > 0) {
            NSRange removeRange = NSMakeRange(0, diff);
            [self removeObjectsInRange:removeRange];
        }
        _maxCount = newMaxCount;
    } while (NO);
}

- (void)resetStack {
    do {
        [self.objects DCH_threadSafe_removeAllObjects];
    } while (NO);
}

- (void)dealloc {
    do {
        [self.objects DCH_threadSafe_removeAllObjects];
        [self.objects DCH_threadSafe_uninit];
        self.objects = nil;
        self.maxCount = kDCHStackDefaultCount;
    } while (NO);
}

- (NSUInteger)count {
    NSUInteger result = 0;
    do {
        if (!self.objects) {
            break;
        }
        result = [self.objects DCH_threadSafe_count];
    } while (NO);
    return result;
}

- (void)pushObject:(id)object {
    do {
        if (!object || !self.objects) {
            break;
        }
        if (self.count == self.maxCount) {
            [self removeFirstObject];
        }
        [self.objects DCH_threadSafe_addObject:object];
    } while (NO);
}

- (void)pushObjects:(NSArray *)objects {
    do {
        if (!objects || (objects.count == 0) || !self.objects) {
            break;
        }
        NSInteger diff = self.count + objects.count - self.maxCount;
        if (diff > 0) {
            NSRange removeRange = NSMakeRange(0, diff);
            [self removeObjectsInRange:removeRange];
        }
        [self.objects DCH_threadSafe_addObjectsFromArray:objects];
    } while (NO);
}

- (id)popObject {
    id result = nil;
    do {
        if (!self.objects || self.count == 0) {
            break;
        }
        result = [self peekObject];
        [self.objects DCH_threadSafe_removeLastObject];
    } while (NO);
    return result;
}

- (id)peekObject {
    id result = nil;
    do {
        if (!self.objects || self.count == 0) {
            break;
        }
        result = [self.objects DCH_threadSafe_lastObject];
    } while (NO);
    return result;
}

- (id)firstObject {
    id result = nil;
    do {
        if (!self.objects || self.count == 0) {
            break;
        }
        result = [self.objects DCH_threadSafe_firstObject];
    } while (NO);
    return result;
}

- (id)lastObject {
    id result = nil;
    do {
        if (!self.objects || self.count == 0) {
            break;
        }
        result = [self.objects DCH_threadSafe_lastObject];
    } while (NO);
    return result;
}

#pragma mark - NSFastEnumeration
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len {
    return [self.objects countByEnumeratingWithState:state objects:buffer count:len];
}

#pragma mark - Private
- (void)removeFirstObject {
    do {
        if (!self.objects || self.count == 0) {
            break;
        }
        @synchronized (self) {
            [self.objects DCH_threadSafe_removeObjectAtIndex:0];
        }
    } while (NO);
}

- (void)removeObjectsInRange:(NSRange)range {
    do {
        if (!self.objects || self.count < (range.location + range.length)) {
            break;
        }
        @synchronized (self) {
            [self.objects DCH_threadSafe_removeObjectsInRange:range];
        }
    } while (NO);
}

@end
