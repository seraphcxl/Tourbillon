//
//  DCRPNUtility.m
//  Tourbillon
//
//  Created by Derek Chen on 13-7-15.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#import "DCRPNUtility.h"
#import "DCStack.h"

NSString *const DCRPNUtilityUnknownOperatorException = @"DCRPNUtilityUnknownOperatorException";
NSString *const DCRPNUtilityInvalidInstructionException = @"DCRPNUtilityInvalidInstructionException";
NSString *const DCRPNUtilityInstuctionUnderrunException = @"DCRPNUtilityInstuctionUnderrunException";

@interface DCRPNUtility () {
}

@property (nonatomic, strong) DCStack *instructions;

- (NSNumber *)_handleNextInstruction;

@end

@implementation DCRPNUtility

@synthesize instructions = _instructions;

- (id)init {
    @synchronized(self) {
        self = [self initWithInstructions:nil];
        return self;
    }
}

- (id)initWithInstructions:(NSArray *)instructions {
    @synchronized(self) {
        self = [super init];
        if (self) {
            _instructions = [[DCStack alloc] initWithArray:instructions];
        }
        return self;
    }
}

- (NSNumber *)currentResult {
    NSNumber *result = nil;
    do {
        if (!self.instructions || [self.instructions count] == 0) {
            break;
        }
        @synchronized(self) {
            result = [self.instructions peekObject];
            if ([result isKindOfClass:[NSNumber class]]) {
                ;
            } else {
                result = nil;
            }
        }
    } while (NO);
    return result;
}

- (void)addInstruction:(id)instruction {
    do {
        if (!instruction || !self.instructions) {
            break;
        }
        @synchronized(self) {
            [self.instructions pushObject:instruction];
        }
    } while (NO);
}

- (void)addInstructions:(NSArray *)instructions {
    do {
        if (!instructions || [instructions count] == 0 || !self.instructions) {
            break;
        }
        @synchronized(self) {
            [self.instructions pushObjects:instructions];
        }
    } while (NO);
}

- (NSNumber *)performInstructions {
    NSNumber *result = nil;
    do {
        @synchronized(self) {
            result = [self _handleNextInstruction];
            [self.instructions pushObject:result];
        }
    } while (NO);
    return result;
}

- (NSNumber *)_handleNextInstruction {
    NSNumber *result = nil;
    do {
        if (!self.instructions || [self.instructions count] == 0) {
            @throw [NSException exceptionWithName:DCRPNUtilityInstuctionUnderrunException reason:@"Ran out of instuctions." userInfo:nil];
            break;
        }
        @synchronized(self) {
            id nextInstruction = [_instructions popObject];
            if ([nextInstruction isKindOfClass:[NSString class]]) {
                NSString *operator = (NSString *)nextInstruction;
                
                NSNumber *operandA = [self _handleNextInstruction];
                NSNumber *operandB = [self _handleNextInstruction];
                
                if ([operator isEqualToString:@"+"]) {
                    return [NSNumber numberWithDouble:([operandB doubleValue] + [operandA doubleValue])];
                } else if ([operator isEqualToString:@"-"]) {
                    return [NSNumber numberWithDouble:([operandB doubleValue] - [operandA doubleValue])];
                } else if ([operator isEqualToString:@"*"]) {
                    return [NSNumber numberWithDouble:([operandB doubleValue] * [operandA doubleValue])];
                } else if ([operator isEqualToString:@"/"]) {
                    return [NSNumber numberWithDouble:([operandB doubleValue] / [operandA doubleValue])];
                } else {
                    @throw [NSException exceptionWithName:DCRPNUtilityUnknownOperatorException reason:[NSString stringWithFormat:@"\"%@\" is an unknown operator.", operator] userInfo:nil];
                }
            } else if ([nextInstruction isKindOfClass:[NSNumber class]]) {
                result = (NSNumber *)nextInstruction;
            } else {
                @throw [NSException exceptionWithName:DCRPNUtilityInvalidInstructionException reason:[NSString stringWithFormat:@"\"%@\" is an invalid instruction.", nextInstruction] userInfo:nil];
            }
        }
    } while (NO);
    return result;
}

@end
