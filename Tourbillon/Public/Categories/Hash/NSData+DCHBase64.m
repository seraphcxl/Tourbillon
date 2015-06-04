//
//  NSData+DCHBase64.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "NSData+DCHBase64.h"
#import "DCHBase64Define.h"

@implementation NSData (DCHBase64)

- (NSString *)dch_base64EncodedString {
    NSString *result = nil;
    do {
        NSMutableData *buffer = [NSMutableData data];
        unsigned int c1 = 0;
        unsigned int c2 = 0;
        unsigned int c3 = 0;
        
        @synchronized(self) {
            const unsigned char *bytes = [self bytes];
            NSUInteger length = [self length];

            while ((c1 = BASE64_GETC) != (unsigned int)EOF) {
                c2 = BASE64_GETC;
                if (c2 == (unsigned int)EOF) {
                    dch_output64Chunk(c1, 0, 0, 2, buffer);
                } else {
                    c3 = BASE64_GETC;
                    if (c3 == (unsigned int)EOF) {
                        dch_output64Chunk(c1, c2, 0, 1, buffer);
                    } else {
                        dch_output64Chunk(c1, c2, c3, 0, buffer);
                    }
                }
            }
            
            result = [[NSString alloc] initWithData:buffer encoding:NSASCIIStringEncoding];
        }
    } while (NO);
    return result;
}

@end
