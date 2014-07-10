//
//  NSString+DCURLCoding.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "NSString+DCURLCoding.h"

@implementation NSString (DCURLCoding)

- (NSString *)urlDecodedString {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodedString {
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", kCFStringEncodingUTF8);
}

- (NSDictionary *)dictionaryFromQueryString {
    NSMutableDictionary *result = nil;
    do {
        @synchronized(self) {
            result = [NSMutableDictionary dictionary];
            
            NSArray *pairs = [self componentsSeparatedByString:@"&"];
            for (NSString *pair in pairs) {
                NSArray *kv = [pair componentsSeparatedByString:@"="];
                if (kv.count == 2) {
                    [result setValue:[(NSString *)[kv objectAtIndex:1] urlEncodedString] forKey:[(NSString *)[kv objectAtIndex:0] urlEncodedString]];
                }
            }
        }
    } while (NO);
    return result;
}

@end
