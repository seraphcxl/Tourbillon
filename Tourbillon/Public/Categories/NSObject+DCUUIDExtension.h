//
//  NSObject+DCUUIDExtension.h
//  Tourbillon
//
//  Created by Derek Chen on 7/9/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DCUUIDExtension)

+ (NSString *)createMemoryID:(NSObject *)object;
+ (NSString *)createUniqueStrByUUID;

@end
