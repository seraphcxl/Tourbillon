//
//  NSString+DCParseCSV.m
//  Tourbillon
//
//  Created by Chen XiaoLiang on 9/28/13.
//  Copyright (c) 2013 CaptainSolid Studio. All rights reserved.
//

#import "NSString+DCParseCSV.h"

@implementation NSString (DCParseCSV)

- (NSArray *)csvComponents {
    NSMutableArray *components = [NSMutableArray array];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSString *quote = @"\"";
    NSString *separator = @",";
    NSString *result= nil;
    while(![scanner isAtEnd]) {
        if([scanner scanString:quote intoString:NULL]) {
            [scanner scanUpToString:quote intoString:&result];
            [scanner scanString:quote intoString:NULL];
        } else {
            [scanner scanUpToString:separator intoString:&result];
        }
        [scanner scanString:separator intoString:NULL];
        [components addObject:result];
    }
    return components;
}

@end
