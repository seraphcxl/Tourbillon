//
//  DCHNSColorEnumerator.h
//  Tourbillon
//
//  Created by Derek Chen on 10/10/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHSingletonTemplate.h"

@interface DCHNSColorEnumerator : NSObject

DCH_DEFINE_SINGLETON_FOR_HEADER(DCHNSColorEnumerator)

- (void)reset;
- (NSColor *)next;

@end
