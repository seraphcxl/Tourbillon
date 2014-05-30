//
//  UIImage+DCLibrarySupport.h
//  Tourbillon
//
//  Created by Derek Chen on 5/30/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DCLibrarySupport)

+ (instancetype)ImageNamed:(NSString *)imageName inLibrary:(NSString *)libraryName;

@end
