//
//  NSDictionary+DCHSortable.h
//  Tourbillon
//
//  Created by Derek Chen on 13-7-11.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DCHSortable)

- (NSArray *)dch_sortedKeysUsingComparator:(NSComparator)comparator;
- (NSArray *)dch_sortedValuesUsingKeyComparator:(NSComparator)comparator;
- (void)dch_enumerateSortedKeysAndObjectsUsingComparator:(NSComparator)comparator usingBlock:(void (^)(id key, id value, BOOL *stop))block;

@end
