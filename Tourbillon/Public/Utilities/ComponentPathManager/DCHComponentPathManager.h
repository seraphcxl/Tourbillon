//
//  DCHComponentPathManager.h
//  Tourbillon
//
//  Created by Derek Chen on 7/11/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHTree.h"

extern NSString * const kDCHComponentPathManagerArchiveTree;

@class DCHComponentPathManager;

@protocol DCHComponentPathManagerDelegate <NSObject>

- (void)componentPathMgr:(DCHComponentPathManager *)mgr willUndo:(DCHTree *)currentTree;
- (void)componentPathMgr:(DCHComponentPathManager *)mgr didUndo:(DCHTree *)currentTree;
- (void)componentPathMgr:(DCHComponentPathManager *)mgr willRedo:(DCHTree *)currentTree;
- (void)componentPathMgr:(DCHComponentPathManager *)mgr didRedo:(DCHTree *)currentTree;
- (void)componentPathMgr:(DCHComponentPathManager *)mgr willResetPath:(NSString *)desc from:(DCHTree *)currentTree;
- (void)componentPathMgr:(DCHComponentPathManager *)mgr didResetPath:(NSString *)desc from:(DCHTree *)currentTree;

@end

@interface DCHComponentPathManager : NSObject

@property (weak, nonatomic) id<DCHComponentPathManagerDelegate> delegate;
@property (strong, nonatomic, readonly) NSURL *archiveURL;
@property (strong, nonatomic, readonly) DCHTree *tree;

//DEFINE_SINGLETON_FOR_HEADER(DCHComponentPathManager)

- (instancetype)initWithRootNodeKey:(NSString *)key andValue:(id<NSCoding>)value;
- (instancetype)initWithArchive:(NSURL *)url;

- (BOOL)archiveTo:(NSURL *)url;

- (void)undo;
- (void)redo;

- (BOOL)resetPathWithNodeDescription:(NSString *)desc andActionBlock:(DCHTreeActionBlock)actionBlock;

- (NSString *)keyLevelTraversal:(BOOL)needLevelSeparator;

@end
