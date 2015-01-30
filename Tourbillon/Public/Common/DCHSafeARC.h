//
//  DCHSafeARC.h
//  Tourbillon
//
//  Created by Derek Chen on 1/29/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#ifndef Tourbillon_DCHSafeARC_h
#define Tourbillon_DCHSafeARC_h

/**** **** **** **** **** **** **** ****/
#if !defined(__clang__) || __clang_major__ < 3
#ifndef __bridge
#define __bridge
#endif

#ifndef __bridge_retain
#define __bridge_retain
#endif

#ifndef __bridge_retained
#define __bridge_retained
#endif

#ifndef __autoreleasing
#define __autoreleasing
#endif

#ifndef __strong
#define __strong
#endif

#ifndef __unsafe_unretained
#define __unsafe_unretained
#endif

#ifndef __weak
#define __weak
#endif
#endif

/**** **** **** **** **** **** **** ****/
#pragma mark - Safe ARC
#ifndef DCH_SAFE_ARC_DEFINES
#define DCH_SAFE_ARC_DEFINES

#if __has_feature(objc_arc)
#define DCH_SAFE_ARC_PROP_STRONG strong
#define DCH_SAFE_ARC_RETAIN(x)
#define DCH_SAFE_ARC_RELEASE(x)
#define DCH_SAFE_ARC_SAFERELEASE(x)
#define DCH_SAFE_ARC_AUTORELEASE(x)
#define DCH_SAFE_ARC_BLOCK_COPY(x)
#define DCH_SAFE_ARC_BLOCK_RELEASE(x)
#define DCH_SAFE_ARC_SUPER_DEALLOC()
#define DCH_SAFE_ARC_AUTORELEASE_POOL_START() @autoreleasepool {
#define DCH_SAFE_ARC_AUTORELEASE_POOL_END() }
#define DCH_SAFE_ARC_BRIDGE __bridge

#if TARGET_OS_IPHONE
// Compiling for iOS
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
// iOS 6.0 or later
#define DCH_SAFE_ARC_DISPATCHQUEUERELEASE(x)
#else
// iOS 5.X or earlier
#define DCH_SAFE_ARC_DISPATCHQUEUERELEASE(x) (dispatch_release(x));
#endif
#else
// Compiling for Mac OS X
#if MAC_OS_X_VERSION_MIN_REQUIRED >= 1080
// Mac OS X 10.8 or later
#define DCH_SAFE_ARC_DISPATCHQUEUERELEASE(x)
#else
// Mac OS X 10.7 or earlier
#define DCH_SAFE_ARC_DISPATCHQUEUERELEASE(x) (dispatch_release(x));
#endif
#endif

#else
#define DCH_SAFE_ARC_PROP_STRONG retain
#define DCH_SAFE_ARC_RETAIN(x) ([(x) retain])
#define DCH_SAFE_ARC_RELEASE(x) ([(x) release])
#define DCH_SAFE_ARC_SAFERELEASE(x) ({[(x) release]; (x) = nil;})
#define DCH_SAFE_ARC_AUTORELEASE(x) ([(x) autorelease])
#define DCH_SAFE_ARC_BLOCK_COPY(x) (Block_copy(x))
#define DCH_SAFE_ARC_BLOCK_RELEASE(x) (Block_release(x))
#define DCH_SAFE_ARC_SUPER_DEALLOC() ([super dealloc])
#define DCH_SAFE_ARC_AUTORELEASE_POOL_START() NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#define DCH_SAFE_ARC_AUTORELEASE_POOL_END() [pool drain];
#define DCH_SAFE_ARC_BRIDGE
#define DCH_SAFE_ARC_DISPATCHQUEUERELEASE(x) (dispatch_release(x));
#endif

#if __has_feature(objc_arc_weak)
#define DCH_SAFE_ARC_PROP_WEAK weak
#define __DCH_SAFE_ARC_PROP_WEAK __weak
#elif __has_feature(objc_arc)
#define DCH_SAFE_ARC_PROP_WEAK unsafe_unretained
#define __DCH_SAFE_ARC_PROP_WEAK __unsafe_unretained
#else
#define DCH_SAFE_ARC_PROP_WEAK assign
#define __DCH_SAFE_ARC_PROP_WEAK __unsafe_unretained
#endif

#endif

/**** **** **** **** **** **** **** ****/

#endif
