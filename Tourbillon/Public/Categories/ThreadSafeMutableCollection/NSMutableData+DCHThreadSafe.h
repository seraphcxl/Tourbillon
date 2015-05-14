//
//  NSMutableData+DCHThreadSafe.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DCHThreadSafe.h"

@interface NSMutableData (DCHThreadSafe)

#pragma mark - NSData
- (NSUInteger)DCH_threadSafe_length;
- (const void *)DCH_threadSafe_bytes NS_RETURNS_INNER_POINTER;
- (void)DCH_threadSafe_getBytes:(void *)buffer length:(NSUInteger)length;
- (void)DCH_threadSafe_getBytes:(void *)buffer range:(NSRange)range;
- (BOOL)DCH_threadSafe_isEqualToData:(NSData *)other;
- (NSData *)DCH_threadSafe_subdataWithRange:(NSRange)range;
- (BOOL)DCH_threadSafe_writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)DCH_threadSafe_writeToURL:(NSURL *)url atomically:(BOOL)atomically; // the atomically flag is ignored if the url is not of a type the supports atomic writes

#pragma mark - NSMutableData
- (void *)DCH_threadSafe_mutableBytes NS_RETURNS_INNER_POINTER;
- (void)DCH_threadSafe_setLength:(NSUInteger)length;
- (void)DCH_threadSafe_appendBytes:(const void *)bytes length:(NSUInteger)length;
- (void)DCH_threadSafe_appendData:(NSData *)other;
- (void)DCH_threadSafe_increaseLengthBy:(NSUInteger)extraLength;
- (void)DCH_threadSafe_replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes;
- (void)DCH_threadSafe_resetBytesInRange:(NSRange)range;
- (void)DCH_threadSafe_setData:(NSData *)data;
- (void)DCH_threadSafe_replaceBytesInRange:(NSRange)range withBytes:(const void *)replacementBytes length:(NSUInteger)replacementLength;

@end
