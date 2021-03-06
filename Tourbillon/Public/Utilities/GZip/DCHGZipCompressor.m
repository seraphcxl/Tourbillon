//
//  DCHGZipCompressor.m
//  Tourbillon
//
//  Created by Derek Chen on 4/1/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "DCHGZipCompressor.h"
#import <zlib.h>

NSString * const kDCHGZipCompressorErrorDomain = @"com.DCHGZipCompressor.error";

static const int kDCHGZipCompressorChunkSize = 262144;
static const int kDCHGZipCompressorDefaultMemoryLevel = 8;
static const int kDCHGZipCompressorDefaultWindowBits = 15;
static const int kDCHGZipCompressorDefaultWindowBitsWithGZipHeader = (16 + kDCHGZipCompressorDefaultWindowBits);

NSString * const kDCHGZipCompressorOption_Level = @"DCHGZipCompressorOption_Level";
NSString * const kDCHGZipCompressorOption_WindowSize = @"DCHGZipCompressorOption_WindowSize";
NSString * const kDCHGZipCompressorOption_MemoryLevel = @"DCHGZipCompressorOption_MemoryLevel";
NSString * const kDCHGZipCompressorOption_Strategy = @"DCHGZipCompressorOption_Strategy";

@interface DCHGZipCompressor () {
    z_stream _zStream;
}

@property(assign, nonatomic) BOOL streamReady;

- (BOOL)setupStreamWithOptions:(NSDictionary *)options error:(NSError *__autoreleasing *)err;
- (BOOL)closeStream:(NSError *__autoreleasing *)err;

+ (NSDictionary *)createDefaultOptions;
+ (NSError *)createErrorWithCode:(NSInteger)code selector:(SEL)selector description:(NSString *)desc;

- (NSData *)compressBytes:(Bytef *)bytes length:(NSUInteger)length error:(NSError **)err shouldFinish:(BOOL)shouldFinish;

@end

@implementation DCHGZipCompressor

@synthesize streamReady = _streamReady;

#pragma mark - Public
- (void)dealloc {
    do {
        if (self.streamReady) {
            NSError *err = nil;
            if (![self closeStream:&err] || err) {
                NSLog(@"%@", [err localizedDescription]);
            }
        }
    } while (NO);
}

+ (NSData *)compressData:(NSData *)rawData error:(NSError *__autoreleasing *)err {
    return [DCHGZipCompressor compressData:rawData options:[DCHGZipCompressor createDefaultOptions] error:err];
}

+ (NSData *)compressData:(NSData *)rawData options:(NSDictionary *)options error:(NSError *__autoreleasing *)err {
    NSData *result = nil;
    DCHGZipCompressor *compressor = nil;
    do {
        if (!rawData || !options) {
            break;
        }
        
        compressor = [[DCHGZipCompressor alloc] init];
        if (!compressor) {
            break;
        }
        if (![compressor setupStreamWithOptions:options error:err] || *err) {
            break;
        }
        result = [compressor compressBytes:(Bytef *)[rawData bytes] length:[rawData length] error:err shouldFinish:YES];
        if (*err) {
            result = nil;
            break;
        }
    } while (NO);
    compressor = nil;
    return result;
}

+ (BOOL)compressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath error:(NSError *__autoreleasing *)err {
    return [DCHGZipCompressor compressDataFromFile:sourcePath toFile:destinationPath options:[DCHGZipCompressor createDefaultOptions] error:err];
}

+ (BOOL)compressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath options:(NSDictionary *)options error:(NSError *__autoreleasing *)err {
    BOOL result = NO;
    do {
        if (!sourcePath || !destinationPath || !options) {
            break;
        }
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        if (![fileMgr createFileAtPath:destinationPath contents:[NSData data] attributes:nil]) {
            if (err) {
                *err = [DCHGZipCompressor createErrorWithCode:0 selector:_cmd description:[NSString stringWithFormat:@"Can't create %@", destinationPath]];
            }
            break;
        }
        
        if (![fileMgr fileExistsAtPath:sourcePath]) {
            if (err) {
                *err = [DCHGZipCompressor createErrorWithCode:0 selector:_cmd description:[NSString stringWithFormat:@"%@ not exsited", sourcePath]];
            }
            break;
        }
        
        NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:sourcePath];
        [inputStream open];
        NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:destinationPath append:NO];
        [outputStream open];
        
        result = [DCHGZipCompressor compressDataFromStream:inputStream toStream:outputStream options:options error:err];
        
        [inputStream close];
        [outputStream close];
    } while (NO);
    return result;
}

+ (BOOL)compressDataFromStream:(NSInputStream *)sourceStream toStream:(NSOutputStream *)destinationStream error:(NSError *__autoreleasing *)err {
    return [DCHGZipCompressor compressDataFromStream:sourceStream toStream:destinationStream options:[DCHGZipCompressor createDefaultOptions] error:err];
}

+ (BOOL)compressDataFromStream:(NSInputStream *)sourceStream toStream:(NSOutputStream *)destinationStream options:(NSDictionary *)options error:(NSError *__autoreleasing *)err {
    BOOL result = NO;
    DCHGZipCompressor *compressor = nil;
    do {
        if (!sourceStream || !destinationStream || !options) {
            break;
        }
        
        compressor = [[DCHGZipCompressor alloc] init];
        if (!compressor) {
            break;
        }
        if (![compressor setupStreamWithOptions:options error:err] || *err) {
            break;
        }
        
        UInt8 inputData[kDCHGZipCompressorChunkSize] = {0};
        NSData *outputData = nil;
        NSInteger readLength = 0;
        
        while ([compressor streamReady]) {
            
            // Read some data from the file
            readLength = [sourceStream read:inputData maxLength:kDCHGZipCompressorChunkSize];
            
            // Make sure nothing went wrong
            if ([sourceStream streamStatus] == NSStreamStatusError) {
                if (err) {
                    *err = [DCHGZipCompressor createErrorWithCode:0 selector:_cmd description:[NSString stringWithFormat:@"sourceStream status error %@", [[sourceStream streamError] localizedDescription]]];
                }
                [compressor closeStream:nil];
                break;
            }
            // Have we reached the end of the input data?
            if (!readLength) {
                result = YES;
                break;
            }
            
            // Attempt to deflate the chunk of data
            outputData = [compressor compressBytes:inputData length:readLength error:err shouldFinish:(readLength < kDCHGZipCompressorChunkSize)];
            if (*err) {
                [compressor closeStream:nil];
                break;
            }
            
            // Write the deflated data out to the destination file
            [destinationStream write:(const uint8_t *)[outputData bytes] maxLength:[outputData length]];
            
            // Make sure nothing went wrong
            if ([destinationStream streamStatus] == NSStreamStatusError) {
                if (err) {
                    *err = [DCHGZipCompressor createErrorWithCode:0 selector:_cmd description:[NSString stringWithFormat:@"destinationStream status error %@", [[destinationStream streamError] localizedDescription]]];
                }
                [compressor closeStream:nil];
                break;
            }
        }
    } while (NO);
    compressor = nil;
    return result;
}

#pragma mark - Private
- (BOOL)setupStreamWithOptions:(NSDictionary *)options error:(NSError *__autoreleasing *)err {
    BOOL result = NO;
    do {
        if (self.streamReady) {
            result = YES;
            break;
        }
        
        if (!options || ![options objectForKey:kDCHGZipCompressorOption_Level] || ![options objectForKey:kDCHGZipCompressorOption_WindowSize] || ![options objectForKey:kDCHGZipCompressorOption_MemoryLevel] || ![options objectForKey:kDCHGZipCompressorOption_Strategy]) {
            break;
        }
        
        _zStream.zalloc = Z_NULL;
        _zStream.zfree = Z_NULL;
        _zStream.opaque = Z_NULL;
        _zStream.avail_in = 0;
        _zStream.next_in = 0;
        
        int level = [[options objectForKey:kDCHGZipCompressorOption_Level] intValue];
        int windowBits = [[options objectForKey:kDCHGZipCompressorOption_WindowSize] intValue];
        int memoryLevel = [[options objectForKey:kDCHGZipCompressorOption_MemoryLevel] intValue];
        int strategy = [[options objectForKey:kDCHGZipCompressorOption_Strategy] intValue];
        
        int status = deflateInit2(&_zStream, level, Z_DEFLATED, windowBits, memoryLevel, strategy);
        if (status != Z_OK) {
            if (err) {
                *err = [DCHGZipCompressor createErrorWithCode:status selector:_cmd description:@"deflateInit2 error"];
            }
        }
        self.streamReady = YES;
        result = YES;
    } while (NO);
    return result;
}

- (BOOL)closeStream:(NSError *__autoreleasing *)err {
    BOOL result = NO;
    do {
        if (!self.streamReady) {
            result = YES;
            break;
        }
        self.streamReady = NO;
        int status = deflateEnd(&_zStream);
        if (status != Z_OK) {
            if (err) {
                *err = [DCHGZipCompressor createErrorWithCode:status selector:_cmd description:@"deflateEnd error"];
            }
        }
        result = YES;
    } while (NO);
    return result;
}

+ (NSDictionary *)createDefaultOptions {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:Z_DEFAULT_COMPRESSION], kDCHGZipCompressorOption_Level, [NSNumber numberWithInt:kDCHGZipCompressorDefaultWindowBitsWithGZipHeader], kDCHGZipCompressorOption_WindowSize, [NSNumber numberWithInt:kDCHGZipCompressorDefaultMemoryLevel], kDCHGZipCompressorOption_MemoryLevel, [NSNumber numberWithInt:Z_DEFAULT_STRATEGY], kDCHGZipCompressorOption_Strategy, nil];
}

+ (NSError *)createErrorWithCode:(NSInteger)code selector:(SEL)selector description:(NSString *)desc {
    NSDictionary *userInfo = nil;
    if (desc && selector) {
        userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"DCHGZipCompressor %@ %@ error", NSStringFromSelector(selector), desc] forKey:NSLocalizedDescriptionKey];
    } else if (selector) {
        userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"DCHGZipCompressor %@ error", NSStringFromSelector(selector)] forKey:NSLocalizedDescriptionKey];
    } else if (desc) {
        userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"DCHGZipCompressor %@ error", desc] forKey:NSLocalizedDescriptionKey];
    } else {
        userInfo = [NSDictionary dictionaryWithObject:@"DCHGZipCompressor error" forKey:NSLocalizedDescriptionKey];
    }
    
    return [NSError errorWithDomain:kDCHGZipCompressorErrorDomain code:code userInfo:userInfo];
}

- (NSData *)compressBytes:(Bytef *)bytes length:(NSUInteger)length error:(NSError **)err shouldFinish:(BOOL)shouldFinish {
    NSMutableData *result = nil;
    do {
        if (!bytes || length == 0) {
            break;
        }
        
        NSUInteger halfLength = (length / 2);
        
        // We'll take a guess that the compressed data will fit in half the size of the original (ie the max to compress at once is half DATA_CHUNK_SIZE), if not, we'll increase it below
        result = [NSMutableData dataWithLength:halfLength];
        
        int status = 0;
        
        _zStream.next_in = bytes;
        _zStream.avail_in = (unsigned int)length;
        _zStream.avail_out = 0;
        
        NSInteger bytesProcessedAlready = _zStream.total_out;
        
        while (_zStream.avail_out == 0) {
            NSInteger size = _zStream.total_out - bytesProcessedAlready;
            if (size >= [result length]) {
                [result increaseLengthBy:halfLength];
            }
            
            _zStream.next_out = (Bytef *)[result mutableBytes] + size;
            _zStream.avail_out = (unsigned int)([result length] - size);
            status = deflate(&_zStream, shouldFinish ? Z_FINISH : Z_NO_FLUSH);
            
            if (status == Z_STREAM_END) {
                break;
            } else if (status != Z_OK) {
                if (err) {
                    *err = [DCHGZipCompressor createErrorWithCode:status selector:_cmd description:@"deflate error"];
                }
                result = nil;
                break;
            }
        }
        
        // Set real length
        if (result) {
            [result setLength:(_zStream.total_out - bytesProcessedAlready)];
        }
    } while (NO);
    return result;
}

@end
