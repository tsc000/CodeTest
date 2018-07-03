//
//  LockViewController.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/7/3.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "LockViewController.h"
#import "MutexRecursiveLock.h"
#import "MutexConditionLock.h"
#import "NSRecursiveLockDemo.h"
#import "NSConditionDemo.h"
#import "NSConditionLockDemo.h"
#import "Semaphore.h"
#import "SpinLock.h"
#import "UnfairLock.h"
#import "MutexLock.h"
#import "NSLockDemo.h"
#import "SerialQueueSync.h"
#import "SemaphoreSync.h"

@interface LockViewController ()

//卖票 存取钱
@property (nonatomic, strong) SpinLock *spinLock;
@property (nonatomic, strong) UnfairLock *unfairLock;
@property (nonatomic, strong) MutexLock *mutexLock;
@property (nonatomic, strong) NSLockDemo *nslockLock;
@property (nonatomic, strong) SerialQueueSync *serialQueueSync;
@property (nonatomic, strong) SemaphoreSync *semaphoreSync;

//其它
@property (nonatomic, strong) MutexRecursiveLock *recursiveLock;
@property (nonatomic, strong) MutexConditionLock *conditionLock;
@property (nonatomic, strong) NSRecursiveLockDemo *nsRecursiveLock;
@property (nonatomic, strong) NSConditionDemo *nsCondition;
@property (nonatomic, strong) NSConditionLockDemo *nsConditionLock;
@property (nonatomic, strong) Semaphore *semaphore;

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleArray[self.type];
    
    NSString *selectorName = self.selectorArray[self.type];
    NSLog(@"方法名：%@", selectorName);
    SEL sel = NSSelectorFromString(selectorName);
    [self performSelector:sel];
    
}


#pragma 卖票
- (void)spinLockTicketTest {
    //自旋锁
    self.spinLock = [[SpinLock alloc] init];
    [self.spinLock sellTickets];
}

- (void)unfairLockTicketTest {
    //不公平锁
    self.unfairLock = [[UnfairLock alloc] init];
    [self.unfairLock sellTickets];
}

- (void)mutexLockTicketTest {
    //互斥锁
    self.mutexLock = [[MutexLock alloc] init];
    [self.mutexLock sellTickets];
}

- (void)NSLockTicketTest {
    //mutex对象封装
    self.nslockLock = [[NSLockDemo alloc] init];
    [self.nslockLock sellTickets];
}

- (void)serialQueueTicketTest {
    //串行队列保证任务同步
    self.serialQueueSync = [[SerialQueueSync alloc] init];
    [self.serialQueueSync sellTickets];
}

- (void)semaphoreTicketTest {
    //信号量
    self.semaphoreSync = [[SemaphoreSync alloc] init];
    [self.semaphoreSync sellTickets];
}

#pragma 存取钱


- (void)spinLockMoneyTest {
    //自旋锁
    self.spinLock = [[SpinLock alloc] init];
    [self.spinLock bankMoney];
}

- (void)unfairLockMoneyTest {
    //不公平锁
    self.unfairLock = [[UnfairLock alloc] init];
    [self.unfairLock bankMoney];
}

- (void)mutexLockMoneyTest {
    //互斥锁
    self.mutexLock = [[MutexLock alloc] init];
    [self.mutexLock bankMoney];
}

- (void)serialQueueMoneyTest {
    //串行队列保证任务同步
    self.serialQueueSync = [[SerialQueueSync alloc] init];
    [self.serialQueueSync bankMoney];
}

- (void)NSLockMoneyTest {
    //mutex对象封装
    self.nslockLock = [[NSLockDemo alloc] init];
    [self.nslockLock bankMoney];
}

- (void)semaphoreMoneyTest {
    //信号量
    self.semaphoreSync = [[SemaphoreSync alloc] init];
    [self.semaphoreSync bankMoney];
}
#pragma 其它锁

//pthread 递归锁
- (void)recursiveLockTest {
    self.recursiveLock = [[MutexRecursiveLock alloc] init];
    
    [self.recursiveLock recursiveTest];
}

//pthread 条件锁
- (void)conditionLockTest {
    self.conditionLock = [[MutexConditionLock alloc] init];
    [self.conditionLock conditionTest];
}

//NSRecursiveLock
- (void)NSRecursiveLockTest {
    self.nsRecursiveLock = [[NSRecursiveLockDemo alloc] init];
    [self.nsRecursiveLock recursiveTest];
}

//NSConditionLock
- (void)NSConditionTest {
    self.nsCondition= [[NSConditionDemo alloc] init];
    [self.nsCondition conditionTest];
}

//线程依赖NSConditionLock
- (void)NSConditionLockTest {
    self.nsConditionLock = [[NSConditionLockDemo alloc] init];
    [self.nsConditionLock conditionLockTest];
}

//dispatch_semaphore_t  信号量，最大并发数
- (void)semaphoreMaxConcurrentCount {
    self.semaphore = [[Semaphore alloc] init];
    [self.semaphore semaphoreTest];
}

- (NSMutableArray *)selectorArray {
    if (!_selectorArray) {
        _selectorArray = [[NSMutableArray alloc] init];
    }
    return _selectorArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}


@end
