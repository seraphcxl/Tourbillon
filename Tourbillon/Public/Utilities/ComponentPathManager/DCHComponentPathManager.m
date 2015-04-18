//
//  DCHComponentPathManager.m
//  Tourbillon
//
//  Created by Derek Chen on 7/11/14.
//  Copyright (c) 2014 CaptainSolid Studio. All rights reserved.
//

#import "DCHComponentPathManager.h"
#import "DCHCommonConstants.h"
#import "DCHStack.h"
#import "NSData+DCHGZipExtension.h"

NSString * const kDCHComponentPathManagerArchiveTree = @"DCHComponentPathManagerArchiveTree";

@interface DCHComponentPathManager () <DCHTreeDelegate>

@property (strong, nonatomic) NSURL *archiveURL;
@property (strong, nonatomic) DCHTree *tree;
@property (strong, nonatomic) DCHStack *undoStack;
@property (strong, nonatomic) DCHStack *redoStack;

- (NSData *)archiveTree;
- (void)unarchiveTreeFromData:(NSData *)data;

@end

@implementation DCHComponentPathManager

@synthesize delegate = _delegate;
@synthesize archiveURL = _archiveURL;
@synthesize tree = _tree;
@synthesize undoStack = _undoStack;
@synthesize redoStack = _redoStack;

//DEFINE_SINGLETON_FOR_CLASS(DCHComponentPathManager)

- (instancetype)initWithRootNodeKey:(NSString *)key andValue:(id<NSCoding>)value {
    DCHAssert(key != nil && [key length] != 0 && value != nil);
    self = [self init];
    if (self) {
        self.delegate = nil;
        self.archiveURL = nil;
        self.tree = [[DCHTree alloc] initWithRootNodeKey:key andValue:value];
        self.tree.delegate = self;
        self.undoStack = [[DCHStack alloc] init];
        self.redoStack = [[DCHStack alloc] init];
    }
    return self;
}

- (instancetype)initWithArchive:(NSURL *)url {
    DCHAssert(url != nil);
    self = [self init];
    if (self) {
        self.delegate = nil;
        self.archiveURL = [url copy];
        NSData *compressedData = [NSData dataWithContentsOfURL:url];
        NSError *err = nil;
        NSData *rawData = [compressedData dch_decompressByGZipWithError:&err];
        DCHAssert(err == nil);
        [self unarchiveTreeFromData:rawData];
        self.undoStack = [[DCHStack alloc] init];
        self.redoStack = [[DCHStack alloc] init];
    }
    return self;
}

- (void)dealloc {
    do {
        self.redoStack = nil;
        self.undoStack = nil;
        self.tree.delegate = nil;
        self.tree = nil;
        self.archiveURL = nil;
        self.delegate = nil;
    } while (NO);
}

- (BOOL)archiveTo:(NSURL *)url {
    BOOL result = NO;
    do {
        if (!self.tree || !url) {
            break;
        }
        self.archiveURL = [url copy];
        NSData *rwaData = [self archiveTree];
        NSError *err = nil;
        NSData *compressedData = [rwaData dch_compressByGZipWithError:&err];
        if (err) {
            NSLog(@"%@", [err localizedDescription]);
            break;
        }
        result = [compressedData writeToURL:url atomically:YES];
    } while (NO);
    return result;
}

- (void)undo {
    do {
        if (!self.tree || !self.undoStack || self.undoStack.count == 0 || !self.redoStack) {
            break;
        }
        NSData *data = [self archiveTree];
        NSError *err = nil;
        NSData *compressedData = [data dch_compressByGZipWithError:&err];
        if (err) {
            NSLog(@"%@", [err localizedDescription]);
            break;
        }
        [self.redoStack pushObject:compressedData];
        data = [self.undoStack popObject];
        NSData *rawData = [data dch_decompressByGZipWithError:&err];
        if (err) {
            NSLog(@"%@", [err localizedDescription]);
            break;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(componentPathMgr:willUndo:)]) {
            [self.delegate componentPathMgr:self willUndo:self.tree];
        }
        [self unarchiveTreeFromData:rawData];
        if (self.delegate && [self.delegate respondsToSelector:@selector(componentPathMgr:didUndo:)]) {
            [self.delegate componentPathMgr:self didUndo:self.tree];
        }
    } while (NO);
}

- (void)redo {
    do {
        if (!self.tree || !self.undoStack || !self.redoStack || self.redoStack.count == 0) {
            break;
        }
        NSData *data = [self archiveTree];
        NSError *err = nil;
        NSData *compressedData = [data dch_compressByGZipWithError:&err];
        if (err) {
            NSLog(@"%@", [err localizedDescription]);
            break;
        }
        [self.undoStack pushObject:compressedData];
        data = [self.redoStack popObject];
        NSData *rawData = [data dch_decompressByGZipWithError:&err];
        if (err) {
            NSLog(@"%@", [err localizedDescription]);
            break;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(componentPathMgr:willRedo:)]) {
            [self.delegate componentPathMgr:self willRedo:self.tree];
        }
        [self unarchiveTreeFromData:rawData];
        if (self.delegate && [self.delegate respondsToSelector:@selector(componentPathMgr:didRedo:)]) {
            [self.delegate componentPathMgr:self didRedo:self.tree];
        }
    } while (NO);
}

- (BOOL)resetPathWithNodeDescription:(NSString *)desc andActionBlock:(DCHTreeActionBlock)actionBlock {
    BOOL result = NO;
    do {
        if (!self.tree) {
            break;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(componentPathMgr:willResetPath:from:)]) {
            [self.delegate componentPathMgr:self willResetPath:desc from:self.tree];
        }
        result = [self.tree actionWithNodeByTreeNodeDescription:desc andActionBlock:actionBlock];
        if (self.delegate && [self.delegate respondsToSelector:@selector(componentPathMgr:didResetPath:from:)]) {
            [self.delegate componentPathMgr:self didResetPath:desc from:self.tree];
        }
        if (result && self.redoStack) {
            [self.redoStack resetStack];
        }
    } while (NO);
    return result;
}

- (NSString *)keyLevelTraversal:(BOOL)needLevelSeparator {
    NSString *result = nil;
    do {
        if (!self.tree) {
            break;
        }
        result = [self.tree keyLevelTraversal:needLevelSeparator];
    } while (NO);
    return result;
}

- (NSData *)archiveTree {
    NSMutableData *result = nil;
    do {
        if (!self.tree) {
            break;
        }
        result = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:result];
        [archiver encodeObject:self.tree forKey:kDCHComponentPathManagerArchiveTree];
        [archiver finishEncoding];
    } while (NO);
    return result;
}

- (void)unarchiveTreeFromData:(NSData *)data {
    do {
        if (!data) {
            break;
        }
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.tree = [unarchiver decodeObjectForKey:kDCHComponentPathManagerArchiveTree];
        self.tree.delegate = self;
        [unarchiver finishDecoding];
    } while (NO);
}

#pragma mark - DCHTreeDelegate
- (void)Tree:(DCHTree *)tree didActionWithNode:(DCHTreeNode *)node {
    do {
        if (!tree || tree != self.tree || !node) {
            break;
        }
    } while (NO);
}

@end
