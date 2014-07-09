//
//  DCUIMainThreadGuard.m
//  Tourbillon
//
//  Created by Derek Chen on 10/13/13.
//  Copyright (c) 2013 CaptainSolid Studio. All rights reserved.
//

#import "DCUIMainThreadGuard.h"
#import "DCLogger.h"
#import "NSObject+DCSwizzle.h"
#import <objc/message.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#endif
///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Tracks down calls to UI from a Thread other than Main

static void DCAssertIfNotMainThread(void) {
    DCAssert(NSThread.isMainThread, @"\nERROR: All calls to UI need to happen on the main thread. You have a bug in your code. Use dispatch_async(dispatch_get_main_queue(), ^{ ... }); if you're unsure what thread you're in.\n\nBreak on DCAssertIfNotMainThread to find out where.\n\nStacktrace: %@", [NSThread callStackSymbols]);
}

// This installs a small guard that checks for the most common threading-errors in UI.
// This won't really slow down performance but still only is compiled in DEBUG versions.
// @note No private API is used here.
__attribute__((constructor)) static void DCUIMainThreadGuard(void) {
    @autoreleasepool {
        for (NSString *selStr in @[PROPERTY(setNeedsLayout), PROPERTY(setNeedsDisplay), PROPERTY(setNeedsDisplayInRect:)]) {
            SEL selector = NSSelectorFromString(selStr);
            SEL newSelector = NSSelectorFromString([NSString stringWithFormat:@"DC_%@", selStr]);
            if ([selStr hasSuffix:@":"]) {
#if TARGET_OS_IPHONE
                DCReplaceMethodWithBlock(UIView.class, selector, newSelector, ^(__unsafe_unretained UIView *_self, CGRect r) {
                    DCAssertIfNotMainThread();
                    ((void ( *)(id, SEL, CGRect))objc_msgSend)(_self, newSelector, r);
                });
#else
                DCReplaceMethodWithBlock(NSView.class, selector, newSelector, ^(__unsafe_unretained NSView *_self, CGRect r) {
                    DCAssertIfNotMainThread();
                    ((void ( *)(id, SEL, CGRect))objc_msgSend)(_self, newSelector, r);
                });
#endif
                
            }else {
#if TARGET_OS_IPHONE
                DCReplaceMethodWithBlock(UIView.class, selector, newSelector, ^(__unsafe_unretained UIView *_self) {
                    DCAssertIfNotMainThread();
                    ((void ( *)(id, SEL))objc_msgSend)(_self, newSelector);
                });
#else
                DCReplaceMethodWithBlock(NSView.class, selector, newSelector, ^(__unsafe_unretained NSView *_self) {
                    DCAssertIfNotMainThread();
                    ((void ( *)(id, SEL))objc_msgSend)(_self, newSelector);
                });
#endif
                
            }
        }
    }
}