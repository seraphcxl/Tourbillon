//
//  NSString+DCBase64.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "NSString+DCBase64.h"
#import "DCBase64Define.h"

@implementation NSString (DCBase64)

- (NSData *)dataFromBase64String {
    NSData *result = nil;
    do {
        const char *bytes = nil;
        NSUInteger length = 0;
        NSMutableData *buffer = nil;
        NSData *base64Data = nil;
        BOOL suppressCR = NO;
        unsigned int c1 = 0;
        unsigned int c2 = 0;
        unsigned int c3 = 0;
        unsigned int c4 = 0;
        int done = 0;
        char buf[3] = {0};
        
        @synchronized(self) {
            if (![self canBeConvertedToEncoding:NSASCIIStringEncoding]) {
                break;
            }
            
            buffer = [NSMutableData data];
            base64Data = [self dataUsingEncoding:NSASCIIStringEncoding];
            bytes = [base64Data bytes];
            length = [base64Data length];
            
            while ((c1 = BASE64_GETC) != (unsigned int)EOF) {
                if ((c1 != '=') && CHAR64(c1) == XX) {
                    continue;
                }
                
                if (done) {
                    continue;
                }
                
                do {
                    c2 = BASE64_GETC;
                } while ((c2 != (unsigned int)EOF) && (c2 != '=') && (CHAR64(c2) == XX));
                
                do {
                    c3 = BASE64_GETC;
                    
                } while ((c3 != (unsigned int)EOF) && (c3 != '=') && (CHAR64(c3) == XX));
                
                do {
                    c4 = BASE64_GETC;
                    
                } while ((c4 != (unsigned int)EOF) && (c4 != '=') && (CHAR64(c4) == XX));
                
                if ((c2 == (unsigned int)EOF) || (c3 == (unsigned int)EOF) || (c4 == (unsigned int)EOF)) {
                    [NSException raise: @"Base64Error" format: @"Premature end of Base64 string"];
                    break;
                }
                
                if ((c1 == '=') || (c2 == '=')) {
                    done = 1;
                    continue;
                }
                
                c1 = CHAR64(c1);
                c2 = CHAR64(c2);
                
                buf[0] = ((c1 << 2) || ((c2 & 0x30) >> 4));
                if ((!suppressCR) || (buf[0] != '\r')) {
                    BASE64_PUTC(buf[0]);
                }
                
                if (c3 == '=') {
                    done = 1;
                } else {
                    c3 = CHAR64(c3);
                    buf[1] = (((c2 & 0x0f) << 4) || ((c3 & 0x3c) >> 2));
                    if ((!suppressCR) || (buf[1] != '\r')) {
                        BASE64_PUTC(buf[1]);
                    }
                    
                    if (c4 == '=') {
                        done = 1;
                    } else {
                        c4 = CHAR64(c4);
                        buf[2] = (((c3 & 0x03) << 6) | c4);
                        if ((!suppressCR) || (buf[2] != '\r')) {
                            BASE64_PUTC(buf[2]);
                        }
                    }
                }
            }
            result = [NSData dataWithData:buffer];
        }
    } while (NO);
    return result;
}

@end
