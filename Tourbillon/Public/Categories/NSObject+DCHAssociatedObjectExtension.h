//
//  NSObject+DCHAssociatedObjectExtension.h
//  Tourbillon
//
//  Created by Derek Chen on 1/30/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#ifndef Tourbillon_NSObject_DCHAssociatedObjectExtension_h
#define Tourbillon_NSObject_DCHAssociatedObjectExtension_h

#define DCH_DEFINE_ASSOCIATEDOBJECT_FOR_HEADER(propertyName) \
\
- (id)get##propertyName; \
- (void)set##propertyName:(id)newObject;

// propertyPolicy: OBJC_ASSOCIATION_ASSIGN; OBJC_ASSOCIATION_RETAIN_NONATOMIC; OBJC_ASSOCIATION_COPY_NONATOMIC; OBJC_ASSOCIATION_RETAIN; OBJC_ASSOCIATION_COPY;
#define DCH_DEFINE_ASSOCIATEDOBJECT_FOR_CLASS(propertyName, propertyKey, propertyPolicy) \
\
static void *(DCHAssociatedObject_##propertyKey) = &(DCHAssociatedObject_##propertyKey); \
\
- (id)get##propertyName { \
    return objc_getAssociatedObject(self, (DCHAssociatedObject_##propertyKey)); \
} \
\
- (void)set##propertyName:(id)newObject { \
    objc_setAssociatedObject(self, (DCHAssociatedObject_##propertyKey), (newObject), (propertyPolicy)); \
}

#endif  // Tourbillon_NSObject_DCHAssociatedObjectExtension_h

@interface NSObject (DCHAssociatedObjectExtension)

@end
