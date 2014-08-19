//
//  DCWebUtility.m
//  Tourbillon
//
//  Created by Derek Chen on 13-6-7.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "DCWebUtility.h"
#import "NSString+DCURLCoding.h"
#import "DCLogger.h"

NSString * const kGetHTTPMethod = @"GET";
NSString * const kPostHTTPMethod = @"POST";

@implementation DCWebUtility

+ (NSDictionary *)dictionaryByParsingURLQueryPart:(NSString *)encodedString {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *parts = [encodedString componentsSeparatedByString:@"&"];
    
    for (NSString *part in parts) {
        if ([part length] == 0) {
            continue;
        }
        
        NSRange index = [part rangeOfString:@"="];
        NSString *key = nil;
        NSString *value = nil;
        
        if (index.location == NSNotFound) {
            key = part;
            value = @"";
        } else {
            key = [part substringToIndex:index.location];
            value = [part substringFromIndex:index.location + index.length];
        }
        
        if (key && value) {
            [result setObject:[value urlDecodedString] forKey:[key urlDecodedString]];
        }
    }
    return result;
}

+ (NSString *)stringBySerializingQueryParameters:(NSDictionary *)queryParameters {
    NSMutableString *queryString = [NSMutableString string];
    BOOL hasParameters = NO;
    if (queryParameters) {
        for (NSString *key in queryParameters) {
            if (hasParameters) {
                [queryString appendString:@"&"];
            }
            id value = [queryParameters objectForKey:key];
            if ([value isKindOfClass:[NSString class]]) {
                NSString *escaped_value = [value urlEncodedString];
                [queryString appendFormat:@"%@=%@", key, escaped_value];
                hasParameters = YES;
            } else {
                DCLog_Debug(@"DCWebUtility error: %@", @"param is't a NSString object.");
                [NSException raise:@"DCWebUtility error" format:@"param is't a NSString object."];
            }
        }
    }
    return queryString;
}

+ (void)deleteCookies:(NSString *)baseURL {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookieStorage cookiesForURL:[NSURL URLWithString:baseURL]];
    for (NSHTTPCookie *cookie in cookies) {
        [cookieStorage deleteCookie:cookie];
    }
}

@end
