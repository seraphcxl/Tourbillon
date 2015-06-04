//
//  NSBundle+DCHBundleResourceSupport.h
//  Tourbillon
//
//  Created by Derek Chen on 5/30/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (DCHBundleResourceSupport)

+ (NSBundle *)dch_libraryResourcesBundle:(NSString *)libraryName;

+ (void)dch_removeAllLibraryResourcesBundles;

@end
