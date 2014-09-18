//
//  DCOSXCommonFuncations.m
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCOSXCommonFuncations.h"

@implementation DCOSXCommonFuncations

+ (NSArray *)getProcessStatusWith:(NSArray *)keywords andPID:(NSUInteger)pid {
    NSMutableArray *result = [NSMutableArray array];
    do {
        if (!keywords || keywords.count == 0 || pid == 0) {
            break;
        }
        
        NSMutableArray *arguments = [NSMutableArray arrayWithObjects: @"-O", nil];
        [arguments addObjectsFromArray:keywords];
        [arguments addObject:@"-p"];
        [arguments addObject:[NSString stringWithFormat:@"%lu", (unsigned long)pid]];
        
        NSTask *task = [NSTask launchedTaskWithLaunchPath:@"/bin/ps" arguments:arguments];
        
        NSPipe *pipe = [NSPipe pipe];
        [task setStandardOutput: pipe];
        
        NSFileHandle *file = [pipe fileHandleForReading];
        
        [task launch];
        
        NSData *data = [file readDataToEndOfFile];
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSMutableArray *arr = (NSMutableArray *)[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [arr removeObject:@""];
        NSUInteger commandIdx = [arr indexOfObject:@"COMMAND"];
        if (arr.count >= (2 + commandIdx)) {
            NSInteger count = MIN((2 + commandIdx + keywords.count), (arr.count));
            for (NSInteger idx = (2 + commandIdx); idx < count; ++idx) {
                [result addObject:[arr objectAtIndex:idx]];
            }
        }
    } while (NO);
    return result;
}

@end
