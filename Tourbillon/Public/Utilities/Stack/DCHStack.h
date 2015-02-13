//
//  DCHStack.h
//  Tourbillon
//
//  Created by Derek Chen on 2/13/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCHStack : NSObject  <NSFastEnumeration> {
}

@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, assign, readonly) NSUInteger maxCount;

- (id)initWithArray:(NSArray *)array;
- (void)setMaxCount:(NSUInteger)newMaxCount;
- (void)resetStack;

- (void)pushObject:(id)object;
- (void)pushObjects:(NSArray *)objects;

- (id)popObject;
- (id)peekObject;

- (id)firstObject;
- (id)lastObject;

@end
