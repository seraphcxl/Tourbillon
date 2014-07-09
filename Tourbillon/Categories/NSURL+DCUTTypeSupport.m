//
//  NSURL+DCUTTypeSupport.m
//  Tourbillon
//
//  Created by Derek Chen on 7/1/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSURL+DCUTTypeSupport.h"

#if TARGET_OS_IPHONE
#import <MobileCoreServices/MobileCoreServices.h>
#else
#endif

@implementation NSURL (DCUTTypeSupport)

- (NSString *)getUTType {
    CFStringRef fileExtension = (__bridge CFStringRef)(self.pathExtension);
    CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
    return (__bridge NSString *)(fileUTI);
}

@end
