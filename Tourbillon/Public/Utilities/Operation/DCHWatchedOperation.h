//
//  DCHWatchedOperation.h
//  Tourbillon
//
//  Created by Derek Chen on 4/1/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCHWatchedOperation;

typedef void(^DCHWatchedOperationCompletionHandler)(DCHWatchedOperation *operation);

@interface DCHWatchedOperation : NSOperation

- (instancetype)initWithCompletionHandler:(DCHWatchedOperationCompletionHandler)completionHandler;

@end
