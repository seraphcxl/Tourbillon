//
//  NSObject+DCHUUIDExtension.h
//  Tourbillon
//
//  Created by Derek Chen on 2/13/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DCHUUIDExtension)

- (NSString *)createMemoryID;
+ (NSString *)createUUID;

@end
