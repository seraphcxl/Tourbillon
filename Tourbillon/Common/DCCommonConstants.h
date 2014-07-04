//
//  DCCommonConstants.h
//  CodeGear_ObjC
//
//  Created by Derek Chen on 13-6-7.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#ifndef CodeGear_ObjC_DCCommonConstants_h
#define CodeGear_ObjC_DCCommonConstants_h

/**** **** **** **** **** **** **** ****/
//
// For Mac OS && iOS
//

#if defined(__MACH__)

#ifdef __cplusplus
#define DC_EXTERN extern "C"
#define DC_PRIVATE_EXTERN __private_extern__
#else
#define DC_EXTERN extern
#define DC_PRIVATE_EXTERN __private_extern__
#endif

//
// For Windows
//

#elif defined(WIN32)

#ifndef _NSBUILDING_COREDATA_DLL
#define _NSWINDOWS_DLL_GOOP __declspec(dllimport)
#else
#define _NSWINDOWS_DLL_GOOP __declspec(dllexport)
#endif

#ifdef __cplusplus
#define DC_EXTERN extern "C" _NSWINDOWS_DLL_GOOP
#define DC_PRIVATE_EXTERN extern
#else
#define DC_EXTERN _NSWINDOWS_DLL_GOOP extern
#define DC_PRIVATE_EXTERN extern
#endif

//
//  For Solaris
//

#elif defined(SOLARIS)

#ifdef __cplusplus
#define DC_EXTERN extern "C"
#define DC_PRIVATE_EXTERN extern "C"
#else
#define DC_EXTERN extern
#define DC_PRIVATE_EXTERN extern
#endif

#endif

/**** **** **** **** **** **** **** ****/
#define DC_MEMSIZE_KB(n) ((NSUInteger)(n * 1024))
#define DC_MEMSIZE_MB(n) ((NSUInteger)(DC_MEMSIZE_KB(n) * 1024))
#define DC_MEMSIZE_GB(n) ((NSUInteger)(DC_MEMSIZE_MB(n) * 1024))
/**** **** **** **** **** **** **** ****/
#ifndef DC_RGB256_DEFINE
#define DC_RGB256_DEFINE
#define DC_RGB256(x) ((CGFloat)((x) / 255.0f))
#endif
/**** **** **** **** **** **** **** ****/

#define DEGREES_TO_RADIANS(angle) (((angle) * M_PI) / 180.0f)
#define RADIANS_TO_DEGREES(radian) (((radian) * 180.0f) / M_PI)

#define M_E 2.71828182845904523536028747135266250  // e
#define M_LOG2E 1.44269504088896340735992468100189214  // log 2e
#define M_LOG10E 0.434294481903251827651128918916605082  // log 10e
#define M_LN2 0.693147180559945309417232121458176568  // log e2
#define M_LN10 2.30258509299404568401799145468436421  // log e10
#define M_PI 3.14159265358979323846264338327950288  // pi
#define M_PI_2 1.57079632679489661923132169163975144  // pi/2
#define M_PI_4 0.785398163397448309615660845819875721  // pi/4
#define M_1_PI 0.318309886183790671537767526745028724  // 1/pi
#define M_2_PI 0.636619772367581343075535053490057448  // 2/pi
#define M_2_SQRTPI 1.12837916709551257389615890312154517  // 2/sqrt(pi)
#define M_SQRT2 1.41421356237309504880168872420969808  // sqrt(2)
#define M_SQRT1_2 0.707106781186547524400844362104849039  // 1/sqrt(2)

#ifdef DEBUG
#define DCFunctionPerformancePeriodTest(func, expectedLife, msg) \
{ \
    NSDate *start = [NSDate date]; \
    { \
        func; \
    } \
    NSDate *end = [NSDate date]; \
    NSTimeInterval cost = [end timeIntervalSinceDate:start]; \
    if (cost > expectedLife) { \
        NSLog(@"%@ Cost: <%f>sec", msg, cost); \
        NSAssert(0, @"DCFunctionPerformancePeriodTest failed!!!"); \
    } \
}

#define DCFunctionPerformanceTimingBegin NSDate *start = [NSDate date];
#define DCFunctionPerformanceTimingEnd(msg) \
{ \
    NSDate *end = [NSDate date]; \
    NSTimeInterval cost = [end timeIntervalSinceDate:start]; \
    NSLog(@"%@ Cost: <%f>sec", msg, cost); \
}

#else
#define DCFunctionPerformancePeriodTest(func, expectedLife, msg) \
{ \
    func; \
}
#define DCFunctionPerformanceTimingBegin
#define DCFunctionPerformanceTimingEnd(msg)
#endif

#endif


