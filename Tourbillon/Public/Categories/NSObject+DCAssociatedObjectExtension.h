//
//  NSObject+DCAssociatedObjectExtension.h
//  Tourbillon
//
//  Created by Derek Chen on 8/19/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#ifndef Tourbillon_NSObject_DCAssociatedObjectExtension_h
#define Tourbillon_NSObject_DCAssociatedObjectExtension_h

#define DEFINE_ASSOCIATEDOBJECT_FOR_HEADER(propertyName) \
\
- (id)get##propertyName; \
- (void)set##propertyName:(id)newObject;

// propertyPolicy: OBJC_ASSOCIATION_ASSIGN; OBJC_ASSOCIATION_RETAIN_NONATOMIC; OBJC_ASSOCIATION_COPY_NONATOMIC; OBJC_ASSOCIATION_RETAIN; OBJC_ASSOCIATION_COPY;
#define DEFINE_ASSOCIATEDOBJECT_FOR_CLASS(propertyName, propertyKey, propertyPolicy) \
\
static void *(AssociatedObject_##propertyKey) = &(AssociatedObject_##propertyKey); \
\
- (id)get##propertyName { \
    return objc_getAssociatedObject(self, (AssociatedObject_##propertyKey)); \
} \
\
- (void)set##propertyName:(id)newObject { \
    objc_setAssociatedObject(self, (AssociatedObject_##propertyKey), (newObject), (propertyPolicy)); \
}

#endif  // Tourbillon_NSObject_DCAssociatedObjectExtension_h

@interface NSObject (DCAssociatedObjectExtension)

@end
