//
//  UIView+DCHSnapshot.h
//  Tourbillon
//
//  Created by Derek Chen on 2/15/16.
//  Copyright © 2016 Derek Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DCHSnapshot)

- (UIImage *)dch_snapshot;
- (UIImage *)dch_snapshotAfterScreenUpdates:(BOOL)afterUpdates;

@end
