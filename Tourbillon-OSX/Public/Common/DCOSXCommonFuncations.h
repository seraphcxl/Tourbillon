//
//  DCOSXCommonFuncations.h
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCOSXCommonFuncations : NSObject

+ (NSArray *)getProcessStatusWith:(NSArray *)keywords andPID:(NSUInteger)pid;

@end
