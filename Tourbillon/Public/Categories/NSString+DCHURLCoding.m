//
//  NSString+DCHURLCoding.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "NSString+DCHURLCoding.h"

@implementation NSString (DCHURLCoding)

- (NSString *)dch_urlDecodedString {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)dch_urlEncodedString {
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", kCFStringEncodingUTF8);
}

- (NSDictionary *)dch_dictionaryFromQueryString {
    NSMutableDictionary *result = nil;
    do {
        @synchronized(self) {
            result = [NSMutableDictionary dictionary];
            
            NSArray *pairs = [self componentsSeparatedByString:@"&"];
            for (NSString *pair in pairs) {
                NSArray *kv = [pair componentsSeparatedByString:@"="];
                if (kv.count == 2) {
                    [result setValue:[(NSString *)[kv objectAtIndex:1] dch_urlEncodedString] forKey:[(NSString *)[kv objectAtIndex:0] dch_urlEncodedString]];
                }
            }
        }
    } while (NO);
    return result;
}

@end
