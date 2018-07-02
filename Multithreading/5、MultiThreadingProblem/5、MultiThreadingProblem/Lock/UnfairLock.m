//
//  UnfairLock.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/7/2.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "UnfairLock.h"
#import <os/lock.h>

@interface UnfairLock ()

@property (nonatomic, assign) os_unfair_lock moneyLock;
//@property (nonatomic, assign) os_unfair_lock ticketLock;

@end


@implementation UnfairLock
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moneyLock = OS_UNFAIR_LOCK_INIT;
//        self.ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

- (void)saveMoney {
    
    os_unfair_lock_lock(&_moneyLock);
    [super saveMoney];
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)withdrawMoney {
    os_unfair_lock_lock(&_moneyLock);
    [super withdrawMoney];
    os_unfair_lock_unlock(&_moneyLock);
}


- (void)sellOneTicket {
    static os_unfair_lock _ticketLock = OS_UNFAIR_LOCK_INIT;
    
    os_unfair_lock_lock(&_ticketLock);
    [super sellOneTicket];
    os_unfair_lock_unlock(&_ticketLock);
}

@end
