//
//  DCImageUtility.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-15.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "DCImageUtility.h"

@implementation DCImageUtility

+ (CGSize)fitSize:(CGSize)thisSize inSize:(CGSize)aSize {
	CGFloat scale;
	CGSize newsize = thisSize;
	
	if (newsize.height && (newsize.height > aSize.height)) {
		scale = aSize.height / newsize.height;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	
	if (newsize.width && (newsize.width >= aSize.width)) {
		scale = aSize.width / newsize.width;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	
	return newsize;
}

+ (CGSize)fitoutSize:(CGSize)thisSize inSize:(CGSize)aSize {
	CGFloat scale;
	CGSize newsize = thisSize;
	
	if (newsize.height && (newsize.height > aSize.height)) {
		scale = aSize.height / newsize.height;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	
	if (newsize.width && (newsize.width < aSize.width)) {
		scale = aSize.width / newsize.width;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	
	return newsize;
}

+ (CGRect)frameSize:(CGSize)thisSize inSize:(CGSize)aSize {
	CGSize size = [self fitSize:thisSize inSize:aSize];
	float dWidth = aSize.width - size.width;
	float dHeight = aSize.height - size.height;
	
	return CGRectMake(dWidth / 2.0f, dHeight / 2.0f, size.width, size.height);
}

+ (CGFloat)degreesToRadians:(CGFloat)degrees {
    return degrees * M_PI / 180;
}

+ (CGImageSourceRef)loadImageSourceFromContentsOfFile:(NSString *)path {
    CGImageSourceRef result = nil;
    CGDataProviderRef cgDP = nil;
    do {
        if (!path) {
            break;
        }
        cgDP = CGDataProviderCreateWithFilename([path fileSystemRepresentation]);
        result = CGImageSourceCreateWithDataProvider(cgDP, NULL);
    } while (NO);
    if (cgDP) {
        CGDataProviderRelease(cgDP);
        cgDP = nil;
    }
    return result;
}

+ (CGImageRef)loadImageFromContentsOfFile:(NSString *)path withMaxPixelSize:(CGFloat)pixelSize {
    CGImageRef result = nil;
    CGImageSourceRef sourceRef = nil;
    do {
        if (!path) {
            break;
        }
        sourceRef = [DCImageUtility loadImageSourceFromContentsOfFile:path];
        if (!sourceRef) {
            break;
        }
        NSDictionary *options = nil;
        if (pixelSize > 0.0f) {
            options = [[NSDictionary alloc] initWithObjectsAndKeys:(id)kCFBooleanTrue, (id)kCGImageSourceCreateThumbnailWithTransform, (id)kCFBooleanTrue, (id)kCGImageSourceCreateThumbnailFromImageAlways, (id)[NSNumber numberWithDouble:pixelSize], (id)kCGImageSourceThumbnailMaxPixelSize, nil];
        } else {
            options = [[NSDictionary alloc] initWithObjectsAndKeys:(id)kCFBooleanTrue, (id)kCGImageSourceCreateThumbnailWithTransform, (id)kCFBooleanTrue, (id)kCGImageSourceCreateThumbnailFromImageAlways, nil];
        }
        result = CGImageSourceCreateImageAtIndex(sourceRef, 0, (SAFE_ARC_BRIDGE CFDictionaryRef)options);
        SAFE_ARC_SAFERELEASE(options);
    } while (NO);
    if (sourceRef) {
        CFRelease(sourceRef);
        sourceRef = nil;
    }
    return result;
}

@end
