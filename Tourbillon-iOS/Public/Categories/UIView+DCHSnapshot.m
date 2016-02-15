//
//  UIView+DCHSnapshot.m
//  Tourbillon
//
//  Created by Derek Chen on 2/15/16.
//  Copyright © 2016 Derek Chen. All rights reserved.
//

#import "UIView+DCHSnapshot.h"

@implementation UIView (DCHSnapshot)

- (UIImage *)dch_snapshot {
    return [self dch_snapshotAfterScreenUpdates:NO];
}

- (UIImage *)dch_snapshotAfterScreenUpdates:(BOOL)afterUpdates {
    UIImage *result = nil;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    do {
        if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
        } else {
            [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        }
        result = UIGraphicsGetImageFromCurrentImageContext();
    } while (NO);
    UIGraphicsEndImageContext();
    return result;
}

@end
