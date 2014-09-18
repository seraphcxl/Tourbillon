//
//  DCMemoryUsageReporter.m
//  Tourbillon
//
//  Created by Derek Chen on 9/18/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCMemoryUsageReporter.h"
#import "DCCommonFuncations.h"
#import "mach/mach.h"

@interface DCMemoryUsageReporter () {
}

- (vm_size_t)usedMemory;
- (vm_size_t)freeMemory;

@end

@implementation DCMemoryUsageReporter

@synthesize prevMemUsage = _prevMemUsage;
@synthesize curMemUsage = _curMemUsage;
@synthesize memUsageDiff = _memUsageDiff;
@synthesize curFreeMem = _curFreeMem;
@synthesize minMemUsageDiff = _minMemUsageDiff;

- (id)init {
    self = [super init];
    if (self) {
        _prevMemUsage = 0;
        _curMemUsage = 0;
        _memUsageDiff = 0;
        _curFreeMem = 0;
        _minMemUsageDiff = 102400;
    }
    return self;
}

- (void)dealloc {
    do {
        _prevMemUsage = 0;
        _curMemUsage = 0;
        _memUsageDiff = 0;
        _curFreeMem = 0;
        _minMemUsageDiff = 0;
    } while (NO);
}

- (void)reportMemoryUsage {
    _prevMemUsage = _curMemUsage;
    _curMemUsage = [self usedMemory];
    _memUsageDiff = _curMemUsage - _prevMemUsage;
    _curFreeMem = [self freeMemory];
}

- (NSString *)log {
    NSString *result = nil;
    do {
        [self reportMemoryUsage];
        if (ABS(_memUsageDiff) > _minMemUsageDiff) {
            result = [NSString stringWithFormat:@"Memory used %7.1f (%+5.0f), free %7.1f kb", DCCalcMemorySizeFormIntToKB(_curMemUsage), DCCalcMemorySizeFormIntToKB(_memUsageDiff), DCCalcMemorySizeFormIntToKB(_curFreeMem)];
            NSLog(@"%@", result);
        }
    } while (NO);
    return result;
}

- (vm_size_t)usedMemory {
    struct task_basic_info info;
    mach_msg_type_number_t size = TASK_BASIC_INFO_COUNT;
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0; // size in bytes
}

- (vm_size_t)freeMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return (vm_stat.free_count * pagesize);
}

@end
