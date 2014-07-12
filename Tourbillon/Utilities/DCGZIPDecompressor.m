//
//  DCGZipDecompressor.m
//  Tourbillon
//
//  Created by Derek Chen on 7/12/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCGZipDecompressor.h"
#import <zlib.h>

NSString * const kDCGZipDecompressorErrorDomain = @"com.DCGZipDecompressor.error";

static const int kDCGZipDecompressorChunkSize = 262144;
static const int kDCGZipDecompressorDefaultWindowBits = 15;
static const int kDCGZipDecompressorDefaultWindowBitsWithGZipHeader = (32 + kDCGZipDecompressorDefaultWindowBits);

NSString * const kDCGZipDecompressorOption_WindowSize = @"DCGZipDecompressorOption_WindowSize";

@interface DCGZipDecompressor () {
    z_stream _zStream;
}

@property(assign, nonatomic) BOOL streamReady;

- (BOOL)setupStreamWithOptions:(NSDictionary *)options error:(NSError *__autoreleasing *)err;
- (BOOL)closeStream:(NSError *__autoreleasing *)err;

+ (NSDictionary *)createDefaultOptions;
+ (NSError *)createErrorWithCode:(NSInteger)code selector:(SEL)selector description:(NSString *)desc;

- (NSData *)decompressBytes:(Bytef *)bytes length:(NSUInteger)length error:(NSError *__autoreleasing *)err;

@end

@implementation DCGZipDecompressor

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

+ (NSData *)decompressData:(NSData *)compressedData error:(NSError *__autoreleasing *)err {
    return [DCGZipDecompressor decompressData:compressedData options:[DCGZipDecompressor createDefaultOptions] error:err];
}

+ (NSData *)decompressData:(NSData *)compressedData options:(NSDictionary *)options error:(NSError *__autoreleasing *)err {
    NSData *result = nil;
    DCGZipDecompressor *decompressor = nil;
    do {
        if (!compressedData || !options) {
            break;
        }
        
        decompressor = [[DCGZipDecompressor alloc] init];
        if (!decompressor) {
            break;
        }
        if (![decompressor setupStreamWithOptions:options error:err] || *err) {
            break;
        }
        result = [decompressor decompressBytes:(Bytef *)[compressedData bytes] length:[compressedData length] error:err];
        if (*err) {
            result = nil;
            break;
        }
    } while (NO);
    decompressor = nil;
    return result;
}

+ (BOOL)decompressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath error:(NSError *__autoreleasing *)err {
    return [DCGZipDecompressor decompressDataFromFile:sourcePath toFile:destinationPath options:[DCGZipDecompressor createDefaultOptions] error:err];
}

+ (BOOL)decompressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath options:(NSDictionary *)options error:(NSError *__autoreleasing *)err {
    BOOL result = NO;
    do {
        if (!sourcePath || !destinationPath || !options) {
            break;
        }
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        if (![fileMgr createFileAtPath:destinationPath contents:[NSData data] attributes:nil]) {
            if (err) {
                *err = [DCGZipDecompressor createErrorWithCode:0 selector:_cmd description:[NSString stringWithFormat:@"Can't create %@", destinationPath]];
            }
            break;
        }
        
        if (![fileMgr fileExistsAtPath:sourcePath]) {
            if (err) {
                *err = [DCGZipDecompressor createErrorWithCode:0 selector:_cmd description:[NSString stringWithFormat:@"%@ not exsited", sourcePath]];
            }
            break;
        }
        
        NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:sourcePath];
        [inputStream open];
        NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:destinationPath append:NO];
        [outputStream open];
        
        result = [DCGZipDecompressor decompressDataFromStream:inputStream toStream:outputStream options:options error:err];
        
        [inputStream close];
        [outputStream close];
    } while (NO);
    return result;
}

+ (BOOL)decompressDataFromStream:(NSInputStream *)sourceStream toStream:(NSOutputStream *)destinationStream error:(NSError *__autoreleasing *)err {
    return [DCGZipDecompressor decompressDataFromStream:sourceStream toStream:destinationStream options:[DCGZipDecompressor createDefaultOptions] error:err];
}

+ (BOOL)decompressDataFromStream:(NSInputStream *)sourceStream toStream:(NSOutputStream *)destinationStream options:(NSDictionary *)options error:(NSError *__autoreleasing *)err {
    BOOL result = NO;
    DCGZipDecompressor *decompressor = nil;
    do {
        if (!sourceStream || !destinationStream || !options) {
            break;
        }
        
        decompressor = [[DCGZipDecompressor alloc] init];
        if (!decompressor) {
            break;
        }
        if (![decompressor setupStreamWithOptions:options error:err] || *err) {
            break;
        }
        
        UInt8 inputData[kDCGZipDecompressorChunkSize] = {0};
        NSData *outputData = nil;
        NSInteger readLength = 0;
        
        while ([decompressor streamReady]) {
            
            // Read some data from the file
            readLength = [sourceStream read:inputData maxLength:kDCGZipDecompressorChunkSize];
            
            // Make sure nothing went wrong
            if ([sourceStream streamStatus] == NSStreamStatusError) {
                if (err) {
                    *err = [DCGZipDecompressor createErrorWithCode:0 selector:_cmd description:[NSString stringWithFormat:@"sourceStream status error %@", [[sourceStream streamError] localizedDescription]]];
                }
                [decompressor closeStream:nil];
                break;
            }
            // Have we reached the end of the input data?
            if (!readLength) {
                result = YES;
                break;
            }
            
            // Attempt to deflate the chunk of data
            outputData = [decompressor decompressBytes:inputData length:readLength error:err];
            if (*err) {
                [decompressor closeStream:nil];
                break;
            }
            
            // Write the deflated data out to the destination file
            [destinationStream write:(const uint8_t *)[outputData bytes] maxLength:[outputData length]];
            
            // Make sure nothing went wrong
            if ([destinationStream streamStatus] == NSStreamStatusError) {
                if (err) {
                    *err = [DCGZipDecompressor createErrorWithCode:0 selector:_cmd description:[NSString stringWithFormat:@"destinationStream status error %@", [[destinationStream streamError] localizedDescription]]];
                }
                [decompressor closeStream:nil];
                break;
            }
        }
    } while (NO);
    decompressor = nil;
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
        
        if (!options || ![options objectForKey:kDCGZipDecompressorOption_WindowSize]) {
            break;
        }
        
        _zStream.zalloc = Z_NULL;
        _zStream.zfree = Z_NULL;
        _zStream.opaque = Z_NULL;
        _zStream.avail_in = 0;
        _zStream.next_in = 0;
        
        int windowBits = [[options objectForKey:kDCGZipDecompressorOption_WindowSize] intValue];
        
        int status = inflateInit2(&_zStream, windowBits);
        if (status != Z_OK) {
            if (err) {
                *err = [DCGZipDecompressor createErrorWithCode:status selector:_cmd description:@"inflateInit2 error"];
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
        int status = inflateEnd(&_zStream);
        if (status != Z_OK) {
            if (err) {
                *err = [DCGZipDecompressor createErrorWithCode:status selector:_cmd description:@"inflateEnd error"];
            }
        }
        result = YES;
    } while (NO);
    return result;
}

+ (NSDictionary *)createDefaultOptions {
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kDCGZipDecompressorDefaultWindowBitsWithGZipHeader], kDCGZipDecompressorOption_WindowSize, nil];
}

+ (NSError *)createErrorWithCode:(NSInteger)code selector:(SEL)selector description:(NSString *)desc {
    NSDictionary *userInfo = nil;
    if (desc && selector) {
        userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"DCGZipDecompressor %@ %@ error", NSStringFromSelector(selector), desc] forKey:NSLocalizedDescriptionKey];
    } else if (selector) {
        userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"DCGZipDecompressor %@ error", NSStringFromSelector(selector)] forKey:NSLocalizedDescriptionKey];
    } else if (desc) {
        userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"DCGZipDecompressor %@ error", desc] forKey:NSLocalizedDescriptionKey];
    } else {
        userInfo = [NSDictionary dictionaryWithObject:@"DCGZipDecompressor error" forKey:NSLocalizedDescriptionKey];
    }
    
    return [NSError errorWithDomain:kDCGZipDecompressorErrorDomain code:code userInfo:userInfo];
}

- (NSData *)decompressBytes:(Bytef *)bytes length:(NSUInteger)length error:(NSError *__autoreleasing *)err {
    NSMutableData *result = nil;
    do {
        if (!bytes || length == 0) {
            break;
        }
        
        NSUInteger halfLength = (length / 2);
        
        result = [NSMutableData dataWithLength:(length + halfLength)];
        
        int status = 0;
        
        _zStream.next_in = bytes;
        _zStream.avail_in = (unsigned int)length;
        _zStream.avail_out = 0;
        
        NSInteger bytesProcessedAlready = _zStream.total_out;
        while (_zStream.avail_in != 0) {
            NSInteger size = _zStream.total_out - bytesProcessedAlready;
            if (size >= [result length]) {
                [result increaseLengthBy:halfLength];
            }
            
            _zStream.next_out = (Bytef *)[result mutableBytes] + size;
            _zStream.avail_out = (unsigned int)([result length] - size);
            
            status = inflate(&_zStream, Z_NO_FLUSH);
            
            if (status == Z_STREAM_END) {
                break;
            } else if (status != Z_OK) {
                if (err) {
                    *err = [DCGZipDecompressor createErrorWithCode:status selector:_cmd description:@"deflate error"];;
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
