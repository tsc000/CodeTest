//
//  SpinLock.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/7/2.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "SpinLock.h"
#import <libkern/OSAtomic.h>

@interface SpinLock ()

//@property (nonatomic, assign) OSSpinLock ticketLock;
@property (nonatomic, assign) OSSpinLock moneyLock;

@end

@implementation SpinLock

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.ticketLock = OS_SPINLOCK_INIT;
        self.moneyLock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)saveMoney {
    
    OSSpinLockLock(&_moneyLock);
    [super saveMoney];
    OSSpinLockUnlock(&_moneyLock);
}

- (void)withdrawMoney {
    OSSpinLockLock(&_moneyLock);
    [super withdrawMoney];
    OSSpinLockUnlock(&_moneyLock);
}


- (void)sellOneTicket {
    static OSSpinLock _ticketLock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&_ticketLock);
    [super sellOneTicket];
    OSSpinLockUnlock(&_ticketLock);
}

@end
