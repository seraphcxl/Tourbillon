//
//  DCCommonConstants.h
//  Tourbillon
//
//  Created by Derek Chen on 13-6-7.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#ifndef Tourbillon_DCCommonConstants_h
#define Tourbillon_DCCommonConstants_h

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
#ifndef DC_CalcMemorySize_DEFINE
#define DC_CalcMemorySize_DEFINE

#define DC_MEMSIZE_KBToInt(n) ((NSUInteger)(n * 1024))
#define DC_MEMSIZE_MBToInt(n) ((NSUInteger)(DC_MEMSIZE_KB(n) * 1024))
#define DC_MEMSIZE_GBToInt(n) ((NSUInteger)(DC_MEMSIZE_MB(n) * 1024))

#define DC_MEMSIZE_IntToKB(n) ((double)(n / 1024.0f))
#define DC_MEMSIZE_IntToMB(n) ((double)(DC_MEMSIZE_Int2KB(n) / 1024.0f))
#define DC_MEMSIZE_IntToGB(n) ((double)(DC_MEMSIZE_Int2KB(n) / 1024.0f))

#endif  // DC_CalcMemorySize_DEFINE
/**** **** **** **** **** **** **** ****/
#ifndef DC_RGBAConvert_DEFINE
#define DC_RGBAConvert_DEFINE

#define DC_RGBA_256ToPer(x) ((CGFloat)((x) / 255.0f))
#define DC_RGBA_PerTo256(x) ((NSUInteger)((x) * 255))

#endif  // DC_RGBAConvert_DEFINE
/**** **** **** **** **** **** **** ****/
#ifndef DC_FloatingNumberEqual_DEFINE
#define DC_FloatingNumberEqual_DEFINE
#define DCFloatingNumberEqual(left, right) ((!(left < right)) && (!(right < left)))
#define DCFloatingNumberEqualToZero(num) DCFloatingNumberEqual(num, 0.0f)
#endif  // DC_FloatingNumberEqual_DEFINE
/**** **** **** **** **** **** **** ****/
#ifndef DC_DegreeRadianConvert_DEFINE
#define DC_DegreeRadianConvert_DEFINE

#define DCDegreesToRadians(angle) (((angle) * M_PI) / 180.0f)
#define DCRadiansToDegrees(radian) (((radian) * 180.0f) / M_PI)

#endif  // DC_DegreeRadianConvert_DEFINE
/**** **** **** **** **** **** **** ****/
#ifndef DC_FunctionPerformancePeriodTest_DEFINE
#define DC_FunctionPerformancePeriodTest_DEFINE
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
#endif  // DEBUG
#endif  // DC_FunctionPerformancePeriodTest_DEFINE
/**** **** **** **** **** **** **** ****/
#ifndef DC_IntFloatConvert_DEFINE
#define DC_IntFloatConvert_DEFINE

#define DCRoundingFloatToInt(x) ((int)((x) + 0.5f))
#define DCMakeIntegerRect(x, y, w, h) (NSMakeRect(DCRoundingFloatToInt(x), DCRoundingFloatToInt(y), DCRoundingFloatToInt(w), DCRoundingFloatToInt(h)))

#endif  // DC_IntFloatConvert_DEFINE
/**** **** **** **** **** **** **** ****/
#ifndef DC_CalcCountOfParams_DEFINE
#define DC_CalcCountOfParams_DEFINE

#define DCCalcCountOfParams2(_a1, _a2, _a3, _a4, _a5, RESULT, ...) RESULT
#define DCCalcCountOfParams(...) DCCalcCountOfParams2(__VA_ARGS__, 5, 4, 3, 2, 1)

#endif  // DC_CalcCountOfParams_DEFINE
/**** **** **** **** **** **** **** ****/
#ifndef DC_PreprocessAssert_DEFINE
#define DC_PreprocessAssert_DEFINE

#define DCPreprocessAssert(test) \
    switch(0) { \
        case 0: \
        case test:; \
} \

#endif  // DC_PreprocessAssert_DEFINE
/**** **** **** **** **** **** **** ****/
#ifndef DC_AntiARC_DEFINE
#define DC_AntiARC_DEFINE

#define DCAntiARCRetain(...) void *retainedThing = (__bridge_retained void *)__VA_ARGS__; retainedThing = retainedThing
#define DCAntiARCRelease(...) void *retainedThing = (__bridge void *) __VA_ARGS__; id unretainedThing = (__bridge_transfer id)retainedThing; unretainedThing = nil

#endif  // DC_AntiARC_DEFINE
/**** **** **** **** **** **** **** ****/
#ifndef DC_SetCurrentThreadName_DEFINE
#define DC_SetCurrentThreadName_DEFINE
#ifdef DEBUG
#define DCSetCurrentThreadName(...) \
    [[NSThread currentThread] setName:[NSString stringWithFormat: @"%@ (set in %s on line %s:%d)", [NSString stringWithFormat:@"" __VA_ARGS__], __PRETTY_FUNCTION__, __FILE__, __LINE__]];
#else
#define DCSetCurrentThreadName(...) \
    [[NSThread currentThread] setName:[NSString stringWithFormat:@"" __VA_ARGS__]];
#endif  // DEBUG
#endif  // DC_SetCurrentThreadName_DEFINE
/**** **** **** **** **** **** **** ****/
#endif  // Tourbillon_DCCommonConstants_h


