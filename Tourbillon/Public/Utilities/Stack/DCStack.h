//
//  DCStack.h
//  Tourbillon
//
//  Created by Derek Chen on 13-7-15.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCStack : NSObject <NSFastEnumeration> {
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
