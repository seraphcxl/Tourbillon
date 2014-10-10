//
//  DCColorEnumerator.h
//  Tourbillon
//
//  Created by Derek Chen on 10/10/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCSingletonTemplate.h"

@interface DCColorEnumerator : NSObject

DEFINE_SINGLETON_FOR_HEADER(DCColorEnumerator)

- (void)reset;
- (UIColor *)next;

@end
