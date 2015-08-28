//
//  DCHTrigger.m
//  Tourbillon
//
//  Created by Derek Chen on 8/28/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import "DCHTrigger.h"
#import <FXNotifications/FXNotifications.h>
#import <KVOController/FBKVOController.h>
#import <libextobjc/EXTScope.h>
#import "DCHCommonConstants.h"
#import "DCHWeakObjectWrapper.h"
#import "NSMutableArray+DCHThreadSafe.h"
#import "NSMutableDictionary+DCHThreadSafe.h"

NSString * const key_DCHTrigger_Observable = @"key_DCHTrigger_Observable";
NSString * const key_DCHTrigger_NotificationName = @"key_DCHTrigger_NotificationName";
NSString * const key_DCHTrigger_Notification = @"key_DCHTrigger_Notification";
NSString * const key_DCHTrigger_KeyPath = @"key_DCHTrigger_KeyPath";
NSString * const key_DCHTrigger_Object = @"key_DCHTrigger_Object";

@interface DCHTriggerCallbackPair ()

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, copy) DCHTriggerConditionBlock condition;
@property (nonatomic, copy) DCHTriggerActionBlock action;

@end

@implementation DCHTriggerCallbackPair

- (void)dealloc {
    self.action = nil;
    self.condition = nil;
}

- (instancetype)initWithUUID:(NSString *)uuid action:(DCHTriggerActionBlock)action onCondition:(DCHTriggerConditionBlock)condition {
    if (DCH_IsEmpty(uuid) || DCH_IsEmpty(condition) || DCH_IsEmpty(action)) {
        return nil;
    }
    self = [self init];
    if (self) {
        self.uuid = uuid;
        self.condition = condition;
        self.action = action;
    }
    return self;
}

@end

@interface DCHTrigger ()

@property (nonatomic, strong) NSMutableDictionary *callbackPairDic;
@property (nonatomic, strong) NSMutableDictionary *keyPathObservableDic;

- (void)runCallbacks:(NSDictionary *)exInfo;

@end

@implementation DCHTrigger

- (void)dealloc {
    do {
        [self unobserveAll];
        
        [self.callbackPairDic dch_threadSafe_uninit];
        self.callbackPairDic = nil;
        
        [self.keyPathObservableDic dch_threadSafe_uninit];
        self.keyPathObservableDic = nil;
    } while (NO);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.callbackPairDic = [[NSMutableDictionary dictionary] dch_threadSafe_init:NO];
        self.keyPathObservableDic = [[NSMutableDictionary dictionary] dch_threadSafe_init:NO];
    }
    return self;
}

- (void)addAction:(DCHTriggerActionBlock)action onCondition:(DCHTriggerConditionBlock)condition withUUID:(NSString *)uuid {
    do {
        if (DCH_IsEmpty(uuid) || !action || !condition) {
            break;
        }
        DCHTriggerCallbackPair *pair = [[DCHTriggerCallbackPair alloc] initWithUUID:uuid action:action onCondition:condition];
        [self.callbackPairDic dch_threadSafe_setObject:pair forKey:uuid];
    } while (NO);
}

- (void)removeCallbackPairWithUUID:(NSString *)uuid {
    do {
        if (DCH_IsEmpty(uuid)) {
            break;
        }
        [self.callbackPairDic dch_threadSafe_removeObjectForKey:uuid];
    } while (NO);
}

- (void)enumCallBackPiars:(DCHTriggerEnumCallbackBlock)enumCallbackBlock {
    do {
        if (!enumCallbackBlock) {
            break;
        }
        [self.callbackPairDic dch_threadSafe_enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            do {
                if (DCH_IsEmpty(obj) || ![obj isKindOfClass:[DCHTriggerCallbackPair class]]) {
                    break;
                }
                DCHTriggerCallbackPair *pair = (DCHTriggerCallbackPair *)obj;
                if (enumCallbackBlock) {
                    enumCallbackBlock(pair, stop);
                }
            } while (NO);
        }];
    } while (NO);
}

- (void)observe:(id)observable notification:(NSString *)notificationName {
    if (DCH_IsEmpty(observable) || DCH_IsEmpty(notificationName)) {
        return;
    }
    
    @weakify(observable, notificationName, self)
    [[NSNotificationCenter defaultCenter] addObserver:self forName:notificationName object:nil queue:nil usingBlock:^(NSNotification *note, id observer) {
        @strongify(observable, notificationName, self)
        if (!DCH_IsEmpty(note) && !DCH_IsEmpty(observable) && !DCH_IsEmpty(notificationName) && note.object == observable) {
            NSDictionary *exInfo = @{key_DCHTrigger_Observable: observable, key_DCHTrigger_NotificationName: notificationName, key_DCHTrigger_Notification: note};
            [self runCallbacks:exInfo];
        }
    }];
}

- (void)unobserve:(id)observable notification:(NSString *)notificationName {
    if (DCH_IsEmpty(observable) || DCH_IsEmpty(notificationName)) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
}

- (void)observe:(id)observable keyPath:(NSString *)keyPath {
    if (DCH_IsEmpty(observable) || DCH_IsEmpty(keyPath)) {
        return;
    }
    
    DCHWeakObjectWrapper *wrapper = [[DCHWeakObjectWrapper alloc] initWithObject:observable];
    if (!DCH_IsEmpty(wrapper) && !DCH_IsEmpty(wrapper.uuid)) {
        [self.keyPathObservableDic setObject:wrapper forKey:wrapper.uuid];
    }
    
    @weakify(observable, keyPath, self)
    [self.KVOController observe:observable keyPath:keyPath options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        @strongify(observable, keyPath, self)
        if (!DCH_IsEmpty(object) && !DCH_IsEmpty(observable) && !DCH_IsEmpty(keyPath)) {
            NSDictionary *exInfo = @{key_DCHTrigger_Observable: observable, key_DCHTrigger_KeyPath: keyPath, key_DCHTrigger_Object: object};
            [self runCallbacks:exInfo];
        }
    }];
}

- (void)unobserve:(id)observable keyPath:(NSString *)keyPath {
    if (DCH_IsEmpty(observable) || DCH_IsEmpty(keyPath)) {
        return;
    }
    
    [self.KVOController unobserve:observable keyPath:keyPath];
}

- (void)unobserveAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)unobserveAllKeyPaths {
    @weakify(self)
    [self.keyPathObservableDic dch_threadSafe_enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        @strongify(self)
        do {
            if (DCH_IsEmpty(obj) || ![obj isKindOfClass:[DCHWeakObjectWrapper class]]) {
                break;
            }
            DCHWeakObjectWrapper *wrapper = (DCHWeakObjectWrapper *)obj;
            if (wrapper.object) {
                [self.KVOController unobserve:wrapper.object];
            }
        } while (NO);
    }];
    self.keyPathObservableDic = [[NSMutableDictionary dictionary] dch_threadSafe_init:NO];
}

- (void)unobserveAll {
    [self unobserveAllNotifications];
    [self unobserveAllKeyPaths];
}

- (void)runCallbacks:(NSDictionary *)exInfo {
    @weakify(self, exInfo)
    [self.callbackPairDic dch_threadSafe_enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        do {
            if (DCH_IsEmpty(obj) || ![obj isKindOfClass:[DCHTriggerCallbackPair class]]) {
                break;
            }
            @strongify(self, exInfo)
            DCHTriggerCallbackPair *pair = (DCHTriggerCallbackPair *)obj;
            if (pair.condition && pair.condition(self, exInfo)) {
                if (pair.action) {
                    pair.action(self, exInfo);
                }
            }
        } while (NO);
    }];
}

@end
