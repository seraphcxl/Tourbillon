//
//  DCHTourbillon.h
//  Tourbillon
//
//  Created by Derek Chen on 1/29/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#ifndef Tourbillon_DCHTourbillon_h
#define Tourbillon_DCHTourbillon_h

#pragma mark - Tree
#import "DCHTreeNode.h"
#import "DCHTree.h"

#pragma mark - ComponentPathManager
#import "DCHComponentPathManager.h"

#pragma mark - Encrypt
#import "DCHXOREncryptedInputStream.h"
#import "DCHXOREncryptedOutputStream.h"
#import "DCHXOREncryptUtility.h"

#pragma mark - Operation
#import "DCHWatchedOperation.h"

#pragma mark - GZip
#import "DCHGZipCompressor.h"
#import "DCHGZipDecompressor.h"

#pragma mark - Hash
#import "DCHBase64Define.h"
#import "NSData+DCHBase64.h"
#import "NSString+DCHBase64.h"
#import "DCHHashUtility.h"
#import "NSData+DCHHex.h"
#import "NSData+DCHHash.h"
#import "NSString+DCHHash.h"

#pragma mark - Categories
#import "NSObject+DCHSwizzle.h"
#import "NSObject+DCHAssociatedObjectExtension.h"
#import "NSObject+DCHUUIDExtension.h"
#import "NSString+DCHURLCoding.h"
#import "NSBundle+DCHBundleResourceSupport.h"
#import "NSData+DCHBundleResourceSupport.h"
#import "NSDictionary+DCHSortable.h"
#import "NSNumber+DCHRandom.h"

#pragma mark - GCDThreadSafe
#import "NSObject+DCHThreadSafe.h"
#import "NSMutableArray+DCHThreadSafe.h"
#import "NSMutableData+DCHThreadSafe.h"
#import "NSMutableDictionary+DCHThreadSafe.h"
#import "NSMutableSet+DCHThreadSafe.h"
#import "NSMutableString+DCHThreadSafe.h"

#pragma mark - SafeCRUD
#import "NSArray+DCHSafeCRUD.h"
#import "NSDictionary+DCHSafeCRUD.h"
#import "NSString+DCHSafeCRUD.h"
#import "NSMutableArray+DCHSafeCRUD.h"
#import "NSMutableDictionary+DCHSafeCRUD.h"
#import "NSMutableSet+DCHSafeCRUD.h"
#import "NSMutableString+DCHSafeCRUD.h"

#pragma mark - Common
#import "DCHSafeARC.h"
#import "DCHCommonConstants.h"
#import "DCHCommonFuncations.h"
#import "DCHSingletonTemplate.h"

#pragma mark - Utilities
#import "DCHStack.h"
#import "DCHUIMainThreadGuard.h"

#pragma mark - Testers
#import "DCHAsyncTest.h"

#if TARGET_OS_IPHONE
// iOS
#import "UIColor+DCHAdditions.h"
#import "UIColor+DCHColorful.h"
#else
// Mac OS X
#import "NSColor+DCHAdditions.h"
#import "NSColor+DCHColorful.h"
#endif

#endif
