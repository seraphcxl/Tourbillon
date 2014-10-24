//
//  DCLogger.h
//  Tourbillon
//
//  Created by Derek Chen on 13-7-1.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DCCommonConstants.h"
#import "DCSingletonTemplate.h"

typedef enum {
    DCLL_DEBUG = 0,
    DCLL_INFO,
    DCLL_WARN,
    DCLL_ERROR,
    DCLL_FATAL,
} DCLogLevel;

@interface DCLogger : NSObject {
}

@property (nonatomic, assign) DCLogLevel logLevel;
@property (nonatomic, assign) BOOL enableLogToFile;
@property (nonatomic, assign) BOOL enableTimestamp;
@property (nonatomic, assign) BOOL enableSourceCodeInfo;
@property (nonatomic, assign) BOOL enableThreadInfo;
@property (nonatomic, strong, readonly) NSFileHandle *fileHandle;
@property (nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

DEFINE_SINGLETON_FOR_HEADER(DCLogger)

+ (void)logWithLevel:(DCLogLevel)level andFormat:(NSString *)format, ...;
+ (void)dumpClass:(Class)cls;

#define DCLog_Debug(format, ...) [DCLogger logWithLevel:DCLL_DEBUG andFormat:format, ## __VA_ARGS__]
#define DCLog_Info(format, ...) [DCLogger logWithLevel:DCLL_INFO andFormat:format, ## __VA_ARGS__]
#define DCLog_Warn(format, ...) [DCLogger logWithLevel:DCLL_WARN andFormat:format, ## __VA_ARGS__]
#define DCLog_Error(format, ...) [DCLogger logWithLevel:DCLL_ERROR andFormat:format, ## __VA_ARGS__]
#define DCLog_Fatal(format, ...) [DCLogger logWithLevel:DCLL_FATAL andFormat:format, ## __VA_ARGS__]

#define DCLog_DumpClass(class) [DCLogger dumpClass:class]

@end
