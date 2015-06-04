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
- (NSUInteger)dch_threadSafe_length;
- (const void *)dch_threadSafe_bytes NS_RETURNS_INNER_POINTER;
- (void)dch_threadSafe_getBytes:(void *)buffer length:(NSUInteger)length;
- (void)dch_threadSafe_getBytes:(void *)buffer range:(NSRange)range;
- (BOOL)dch_threadSafe_isEqualToData:(NSData *)other;
- (NSData *)dch_threadSafe_subdataWithRange:(NSRange)range;
- (BOOL)dch_threadSafe_writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)dch_threadSafe_writeToURL:(NSURL *)url atomically:(BOOL)atomically; // the atomically flag is ignored if the url is not of a type the supports atomic writes

#pragma mark - NSMutableData
- (void *)dch_threadSafe_mutableBytes NS_RETURNS_INNER_POINTER;
- (void)dch_threadSafe_setLength:(NSUInteger)length;
- (void)dch_threadSafe_appendBytes:(const void *)bytes length:(NSUInteger)length;
- (void)dch_threadSafe_appendData:(NSData *)other;
- (void)dch_threadSafe_increaseLengthBy:(NSUInteger)extraLength;
- (void)dch_threadSafe_replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes;
- (void)dch_threadSafe_resetBytesInRange:(NSRange)range;
- (void)dch_threadSafe_setData:(NSData *)data;
- (void)dch_threadSafe_replaceBytesInRange:(NSRange)range withBytes:(const void *)replacementBytes length:(NSUInteger)replacementLength;

@end
