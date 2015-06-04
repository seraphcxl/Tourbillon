//
//  NSString+DCHBase64.h
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DCHBase64)

- (NSData *)dch_dataFromBase64String;

@end
