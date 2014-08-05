//
//  NSData+DCLibrarySupport.h
//  Tourbillon
//
//  Created by Derek Chen on 5/30/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DCLibrarySupport)

+ (instancetype)dataInLibrary:(NSString *)libraryName withBundleResource:(NSString *)resourceName ofType:(NSString *)type options:(NSDataReadingOptions)readOptionsMask error:(NSError **)errorPtr;
+ (instancetype)dataInLibrary:(NSString *)libraryName withBundleResource:(NSString *)resourceName ofType:(NSString *)type;

@end
