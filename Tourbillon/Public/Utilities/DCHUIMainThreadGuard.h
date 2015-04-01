//
//  DCHUIMainThreadGuard.h
//  Tourbillon
//
//  Created by Derek Chen on 4/1/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

// Compile-time selector checks.
#ifndef DCHUIMainThreadGuard_PROPERTY
#define DCHUIMainThreadGuard_PROPERTY
#if DEBUG
#define PROPERTY(propName) NSStringFromSelector(@selector(propName))
#else
#define PROPERTY(propName) @#propName
#endif
#endif

@interface DCHUIMainThreadGuard : NSObject

+ (void)assertIfNotMainThread;
+ (void)guarding;

@end
