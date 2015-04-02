//
//  DCHUIColorEnumerator.h
//  Tourbillon
//
//  Created by Derek Chen on 10/10/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCHSingletonTemplate.h"

@interface DCHUIColorEnumerator : NSObject

DCH_DEFINE_SINGLETON_FOR_HEADER(DCHUIColorEnumerator)

- (void)reset;
- (UIColor *)next;

@end
