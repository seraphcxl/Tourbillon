//
//  DCHCommonConstants.h
//  Tourbillon
//
//  Created by Derek Chen on 1/29/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#ifndef Tourbillon_DCHCommonConstants_h
#define Tourbillon_DCHCommonConstants_h
/**** **** **** **** **** **** **** ****/
#pragma mark - EXTERN
//
// For Mac OS && iOS
//

#if defined(__MACH__)

#ifdef __cplusplus
#define DCH_EXTERN extern "C"
#define DCH_PRIVATE_EXTERN __private_extern__
#else
#define DCH_EXTERN extern
#define DCH_PRIVATE_EXTERN __private_extern__
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
#define DCH_EXTERN extern "C" _NSWINDOWS_DLL_GOOP
#define DCH_PRIVATE_EXTERN extern
#else
#define DCH_EXTERN _NSWINDOWS_DLL_GOOP extern
#define DCH_PRIVATE_EXTERN extern
#endif

//
//  For Solaris
//

#elif defined(SOLARIS)

#ifdef __cplusplus
#define DCH_EXTERN extern "C"
#define DCH_PRIVATE_EXTERN extern "C"
#else
#define DCH_EXTERN extern
#define DCH_PRIVATE_EXTERN extern
#endif

#endif
/**** **** **** **** **** **** **** ****/
#pragma mark - Calc memory size
#ifndef DCH_CalcMemorySize_DEFINE
#define DCH_CalcMemorySize_DEFINE

#define DCH_MEMSIZE_KBToInt(n) ((NSUInteger)(n * 1024))
#define DCH_MEMSIZE_MBToInt(n) ((NSUInteger)(DCH_MEMSIZE_KB(n) * 1024))
#define DCH_MEMSIZE_GBToInt(n) ((NSUInteger)(DCH_MEMSIZE_MB(n) * 1024))

#define DCH_MEMSIZE_IntToKB(n) ((double)(n / 1024.0f))
#define DCH_MEMSIZE_IntToMB(n) ((double)(DCH_MEMSIZE_Int2KB(n) / 1024.0f))
#define DCH_MEMSIZE_IntToGB(n) ((double)(DCH_MEMSIZE_Int2KB(n) / 1024.0f))

#endif  // DCH_CalcMemorySize_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - RGBA convert
#ifndef DCH_RGBAConvert_DEFINE
#define DCH_RGBAConvert_DEFINE

#define DCH_RGBA_256ToPer(x) ((CGFloat)((x) / 255.0f))
#define DCH_RGBA_PerTo256(x) ((NSUInteger)((x) * 255))

#endif  // DCH_RGBAConvert_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Floating number equal
#ifndef DCH_FloatingNumberEqual_DEFINE
#define DCH_FloatingNumberEqual_DEFINE
#define DCHFloatingNumberEqual(left, right) ((!(left < right)) && (!(right < left)))
#define DCHFloatingNumberEqualToZero(num) DCHFloatingNumberEqual(num, 0.0f)
#endif  // DCH_FloatingNumberEqual_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Degree radian convert
#ifndef DCH_DegreeRadianConvert_DEFINE
#define DCH_DegreeRadianConvert_DEFINE

#define DCHDegreesToRadians(angle) (((angle) * M_PI) / 180.0f)
#define DCHRadiansToDegrees(radian) (((radian) * 180.0f) / M_PI)

#endif  // DC_DegreeRadianConvert_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Chronograph
#ifndef DCH_Chronograph_DEFINE
#define DCH_Chronograph_DEFINE
#ifdef DEBUG
#define DCHFunctionPerformanceTest(func, expectedLife, msg) \
{ \
    NSDate *start4DCHFunctionPerformanceTest = [NSDate date]; \
    { \
        func; \
    } \
    NSDate *end4DCHFunctionPerformanceTest = [NSDate date]; \
    NSTimeInterval cost4DCHFunctionPerformanceTest = [end4DCHFunctionPerformanceTest timeIntervalSinceDate:start4DCHFunctionPerformanceTest]; \
    if (cost4DCHFunctionPerformanceTest > expectedLife) { \
        NSLog(@"DCHFunctionPerformanceTest <%@> Cost: (%f)sec", msg, cost4DCHFunctionPerformanceTest); \
        NSAssert(0, @"DCHFunctionPerformanceTest failed!!!"); \
    } \
}

#define DCHChronographSet \
NSDate *start4DCHChronograph = nil; \
NSDate *end4DCHChronograph = nil; \
NSTimeInterval cost4DCHChronograph = 0; \

#define DCHChronographReset \
start4DCHChronograph = nil; \
end4DCHChronograph = nil; \
cost4DCHChronograph = 0; \

#define DCHChronographStart start4DCHChronograph = [NSDate date];

#define DCHChronographStop(msg) \
end4DCHChronograph = [NSDate date]; \
cost4DCHChronograph = [end4DCHChronograph timeIntervalSinceDate:start4DCHChronograph]; \
NSLog(@"DCHChronograph <%@> Cost: (%f)sec", msg, cost4DCHChronograph); \

#define DCHChronographBlockStart(identifier) NSDate *start##identifier = [NSDate date];

#define DCHChronographBlockStop(identifier, msg) \
NSDate *end##identifier = [NSDate date]; \
NSTimeInterval cost##identifier = [end##identifier timeIntervalSinceDate:start##identifier]; \
NSLog(@"DCHChronographBlock <%@> Cost: (%f)sec", msg, cost##identifier); \

#else
#define DCHFunctionPerformanceTest(func, expectedLife, msg) \
{ \
    func; \
}

#define DCHChronographSet
#define DCHChronographReset
#define DCHChronographStart
#define DCHChronographStop(msg)

#define DCHChronographBlockStart(identifier)
#define DCHChronographBlockStop(identifier, msg)

#endif  // DEBUG
#endif  // DCH_Chronograph_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Int float convert
#ifndef DCH_IntFloatConvert_DEFINE
#define DCH_IntFloatConvert_DEFINE

#define DCHRoundingFloatToInt(x) ((int)((x) + 0.5f))
#define DCHMakeIntegerRect(x, y, w, h) (NSMakeRect(DCHRoundingFloatToInt(x), DCHRoundingFloatToInt(y), DCHRoundingFloatToInt(w), DCHRoundingFloatToInt(h)))

#endif  // DCH_IntFloatConvert_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Calc count of params
#ifndef DCH_CalcCountOfParams_DEFINE
#define DCH_CalcCountOfParams_DEFINE

#define DCHCalcCountOfParams2(_a1, _a2, _a3, _a4, _a5, RESULT, ...) RESULT
#define DCHCalcCountOfParams(...) DCHCalcCountOfParams2(__VA_ARGS__, 5, 4, 3, 2, 1)

#endif  // DCH_CalcCountOfParams_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Preprocess assert
#ifndef DCH_PreprocessAssert_DEFINE
#define DCH_PreprocessAssert_DEFINE

#define DCHPreprocessAssert(test) \
    switch(0) { \
        case 0: \
        case test:; \
} \

#endif  // DCH_PreprocessAssert_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Anti ARC
#ifndef DCH_AntiARC_DEFINE
#define DCH_AntiARC_DEFINE

#define DCHAntiARCRetain(...) void *retainedThing = (__bridge_retained void *)__VA_ARGS__; retainedThing = retainedThing
#define DCHAntiARCRelease(...) void *retainedThing = (__bridge void *) __VA_ARGS__; id unretainedThing = (__bridge_transfer id)retainedThing; unretainedThing = nil

#endif  // DCH_AntiARC_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Set current thread name
#ifndef DCH_SetCurrentThreadName_DEFINE
#define DCH_SetCurrentThreadName_DEFINE
#define DCH_SetCurrentThreadName_ThreadNameLength (32)
#ifdef DEBUG
// threadNameStr.length < 32
#define DCHSetCurrentThreadName(threadNameStr) \
{ \
    NSString *tmpThdName = threadNameStr; \
    if (tmpThdName.length > DCH_SetCurrentThreadName_ThreadNameLength) { \
        tmpThdName = [tmpThdName substringToIndex:DCH_SetCurrentThreadName_ThreadNameLength]; \
    } \
    NSUInteger maxLen = 56 - tmpThdName.length; \
    NSString *fpStr = [[[NSString stringWithFormat:@"%s", __FILE__] pathComponents] lastObject]; \
    if (fpStr.length > maxLen) { \
        fpStr = [fpStr substringFromIndex:(fpStr.length - maxLen)]; \
    } \
    [[NSThread currentThread] setName:[NSString stringWithFormat: @"%@<%@:%d>", tmpThdName, fpStr, __LINE__]]; \
}

#define DCHSetCurrentThreadDebugName DCHSetCurrentThreadName(NSStringFromSelector(_cmd))
#else
// threadNameStr.length < 32
#define DCHSetCurrentThreadName(threadNameStr) \
{ \
    NSString *tmpThdName = threadNameStr; \
    if (tmpThdName.length > DCH_SetCurrentThreadName_ThreadNameLength) { \
        tmpThdName = [tmpThdName substringToIndex:DCH_SetCurrentThreadName_ThreadNameLength]; \
    } \
    [[NSThread currentThread] setName:[NSString stringWithFormat: @"%@", tmpThdName]]; \
}

#define DCHSetCurrentThreadDebugName DCHSetCurrentThreadName(NSStringFromSelector(_cmd))
#endif  // DEBUG
#endif  // DCH_SetCurrentThreadName_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Assert
#ifndef DCH_Assert_DEFINE
#define DCH_Assert_DEFINE
// A better assert. NSAssert is too runtime dependant, and assert() doesn't log.
// http://www.mikeash.com/pyblog/friday-qa-2013-05-03-proper-use-of-asserts.html
// Accepts both:
// - DCHAssert(x > 0);
// - DCHAssert(y > 3, @"Bad value for y");
#define DCHAssert(expression, ...) \
do { \
    if (!(expression)) { \
        NSLog(@"%@", [NSString stringWithFormat: @"Assertion failure: %s in %s on line %s:%d. %@", #expression, __PRETTY_FUNCTION__, __FILE__, __LINE__, [NSString stringWithFormat:@"" __VA_ARGS__]]); \
        abort(); \
    } \
} while(NO)
#endif  // DCH_Assert_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Debug log
#ifndef DCH_DebugLog_DEFINE
#define DCH_DebugLog_DEFINE
#ifdef DEBUG
#define DCHDebugLog(...) NSLog(__VA_ARGS__)
#else
#define DCHDebugLog(...)
#endif  // DEBUG
#endif  // DCH_DebugLog_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Debug assert
#ifndef DCH_DebugAssert_DEFINE
#define DCH_DebugAssert_DEFINE
#ifdef DEBUG
#define DCHDebugAssert(expression, ...) DCHAssert(expression, __VA_ARGS__)
#else
#define DCHDebugAssert(expression, ...)
#endif  // DEBUG
#endif  // DCH_DebugAssert_DEFINE
/**** **** **** **** **** **** **** ****/
#pragma mark - Conditional run block
#ifndef DCH_ConditionalRunBlock_DEFINE
#define DCH_ConditionalRunBlock_DEFINE

#define DCHConditionalRunBlock(conditional, runBlock) if (conditional) { runBlock } else { DCHDebugAssert((conditional)); }

#endif  // DCH_ConditionalRunBlock_DEFINE
/**** **** **** **** **** **** **** ****/
/**** **** **** **** **** **** **** ****/
#pragma mark - Is empty
static inline BOOL DCH_IsEmpty(id thing) {
    return thing == nil || ([thing isEqual:[NSNull null]]) || ([thing respondsToSelector:@selector(length)] && [thing length] == 0) || ([thing respondsToSelector:@selector(count)] && [thing count] == 0);
}
/**** **** **** **** **** **** **** ****/
#endif  // Tourbillon_DCHCommonConstants_h
