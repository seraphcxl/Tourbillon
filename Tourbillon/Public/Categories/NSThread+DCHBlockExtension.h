//
//  NSThread+DCHBlockExtension.h
//  Tourbillon
//
//  Created by Derek Chen on 4/4/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (DCHBlockExtension)

+ (void)dch_runInMain:(void (^)(void))block;

+ (void)dch_runInBackground:(void (^)(void))block;

@end
