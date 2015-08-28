//
//  DCHTrigger.h
//  Tourbillon
//
//  Created by Derek Chen on 8/28/15.
//  Copyright (c) 2015 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const key_DCHTrigger_Observable;
extern NSString * const key_DCHTrigger_NotificationName;
extern NSString * const key_DCHTrigger_Notification;
extern NSString * const key_DCHTrigger_KeyPath;
extern NSString * const key_DCHTrigger_Object;

@class DCHTrigger;
@class DCHTriggerCallbackPair;

typedef BOOL(^DCHTriggerConditionBlock)(DCHTrigger *trigger, NSDictionary *exInfo);
typedef void(^DCHTriggerActionBlock)(DCHTrigger *trigger, NSDictionary *exInfo);
typedef void(^DCHTriggerEnumCallbackBlock)(DCHTriggerCallbackPair *pair, BOOL *stop);

@interface DCHTriggerCallbackPair : NSObject

@property (nonatomic, strong, readonly) NSString *uuid;
@property (nonatomic, copy, readonly) DCHTriggerConditionBlock condition;
@property (nonatomic, copy, readonly) DCHTriggerActionBlock action;

- (instancetype)initWithUUID:(NSString *)uuid action:(DCHTriggerActionBlock)action onCondition:(DCHTriggerConditionBlock)condition;

@end

@interface DCHTrigger : NSObject

- (void)addAction:(DCHTriggerActionBlock)action onCondition:(DCHTriggerConditionBlock)condition withUUID:(NSString *)uuid;
- (void)removeCallbackPairWithUUID:(NSString *)uuid;
- (void)enumCallBackPiars:(DCHTriggerEnumCallbackBlock)enumCallbackBlock;

- (void)observe:(id)observable notification:(NSString *)notificationName;
- (void)unobserve:(id)observable notification:(NSString *)notificationName;

- (void)observe:(id)observable keyPath:(NSString *)keyPath;
- (void)unobserve:(id)observable keyPath:(NSString *)keyPath;

- (void)unobserveAllNotifications;
- (void)unobserveAllKeyPaths;
- (void)unobserveAll;

@end
