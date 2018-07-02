//
//  MutexLock.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/7/2.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "MutexLock.h"
#import <pthread.h>

@interface MutexLock ()

@property (nonatomic, assign) pthread_mutex_t moneyLock;
@property (nonatomic, assign) pthread_mutex_t ticketLock;

@end


@implementation MutexLock

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self __initLock:&_moneyLock];
        [self __initLock:&_ticketLock];

    }
    return self;
}

- (void)__initLock:(pthread_mutex_t *)lock {
    
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    pthread_mutex_init(lock, &attr);
    pthread_mutexattr_destroy(&attr);
    
}

- (void)saveMoney {
    
    pthread_mutex_lock(&_moneyLock);
    [super saveMoney];
    pthread_mutex_unlock(&_moneyLock);
    
}

- (void)withdrawMoney {
    
    pthread_mutex_lock(&_moneyLock);
    [super withdrawMoney];
    pthread_mutex_unlock(&_moneyLock);
    
}


- (void)sellOneTicket {
    
    pthread_mutex_lock(&_ticketLock);
    [super sellOneTicket];
    pthread_mutex_unlock(&_ticketLock);
    
}

- (void)dealloc {
    pthread_mutex_destroy(&_moneyLock);
    pthread_mutex_destroy(&_ticketLock);
}

@end
