//
//  DCHWeakObjectWrapper.h
//  Tourbillon
//
//  Created by Derek Chen on 8/28/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCHWeakObjectWrapper : NSObject

@property (nonatomic, weak, readonly) id object;

- (instancetype)initWithObject:(id)object;

- (NSString *)uuid;

@end
