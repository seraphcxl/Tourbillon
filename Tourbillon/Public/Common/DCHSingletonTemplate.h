//
//  DCHSingletonTemplate.h
//  Tourbillon
//
//  Created by Derek Chen on 1/29/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#ifndef Tourbillon_DCHSingletonTemplate_h
#define Tourbillon_DCHSingletonTemplate_h

/**** **** **** **** **** **** **** ****/
#define DCH_DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className; \
+ (void)staticRelease;

/**** **** **** **** **** **** **** ****/
#if __has_feature(objc_arc)

#define DCH_DEFINE_SINGLETON_FOR_CLASS(className) \
\
static className *shared##className = nil; \
\
+ (className *)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
} \
\
+ (void)staticRelease {}

#else

#define DCH_DEFINE_SINGLETON_FOR_CLASS(className) \
\
static className *shared##className = nil; \
\
+ (className *)shared##className { \
@synchronized(self) { \
if (shared##className == nil) { \
[[self alloc] init]; \
} \
} \
return shared##className; \
} \
\
+ (void)staticRelease { \
@synchronized(self) { \
if (shared##className) { \
[shared##className dealloc]; \
shared##className = nil; \
} \
} \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
@synchronized(self) { \
if (shared##className == nil) { \
shared##className = [super allocWithZone:zone]; \
return shared##className; \
} \
} \
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone { return self; } \
\
- (id)retain { return self; } \
\
- (NSUInteger)retainCount { return UINT_MAX; } \
\
- (oneway void)release {} \
\
- (id)autorelease { return self; }

#endif  // __has_feature(objc_arc)

#endif
