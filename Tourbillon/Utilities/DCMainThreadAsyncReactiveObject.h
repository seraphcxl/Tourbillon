//
//  DCMainThreadAsyncReactiveObject.h
//  Tourbillon
//
//  Created by Derek Chen on 5/16/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCMainThreadAsyncReactiveObject : NSObject {
}

@property (strong, atomic, readonly) NSOperationQueue *asyncReactiveQueue;

- (void)addOperationForAsyncReactiveInMainThreadWithBlock:(void (^)(id strongSelf))block;

@end
