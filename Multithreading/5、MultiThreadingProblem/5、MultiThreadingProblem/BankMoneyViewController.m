//
//  BankMoneyViewController.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/6/29.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "BankMoneyViewController.h"
#import <libkern/OSAtomic.h>

@interface BankMoneyViewController ()
@property (nonatomic, assign) NSInteger money;

@property (nonatomic, assign) OSSpinLock moneyLock;
@end

@implementation BankMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.money = 100;
    self.moneyLock = OS_SPINLOCK_INIT;
    
    [self bankMoney];
}

//存取钱问题
- (void)bankMoney {
    
    dispatch_queue_t queue = dispatch_queue_create("bankmoney", DISPATCH_QUEUE_CONCURRENT);
    
    //存5次钱
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            [self saveMoney];
        }
    });
    
    //取5次钱
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            [self withdrawMoney];
        }
    });
    
}

- (void)saveMoney {
    //    [self locklessSaveMoney]; //无锁
    [self spinLockSaveMoney];   //自旋锁
}

- (void)withdrawMoney {
    //    [self locklessSellOneTicket];  //无锁
    [self spinLockWithdrawMoney];   //自旋锁
}

//没有加锁的存钱
- (void)locklessSaveMoney {
    NSInteger money = self.money;
    sleep(.2);
    money += 50;
    self.money = money;
    NSLog(@"还剩%ld多少钱: %@", self.money, [NSThread currentThread]);
}

//没有加锁的取钱
- (void)locklessWithdrawMoney {
    NSInteger money = self.money;
    sleep(.2);
    money -= 20;
    self.money = money;
    NSLog(@"还剩%ld多少钱: %@", self.money, [NSThread currentThread]);
}

//自旋锁存钱
- (void)spinLockSaveMoney {
    OSSpinLockLock(&_moneyLock);
    
    NSInteger money = self.money;
    sleep(.2);
    money += 50;
    self.money = money;
    NSLog(@"还剩%ld多少钱: %@", self.money, [NSThread currentThread]);
    
    OSSpinLockUnlock(&_moneyLock);
}

//自旋锁取钱
- (void)spinLockWithdrawMoney {
    OSSpinLockLock(&_moneyLock);
    
    NSInteger money = self.money;
    sleep(.2);
    money -= 20;
    self.money = money;
    NSLog(@"还剩%ld多少钱: %@", self.money, [NSThread currentThread]);
    
    OSSpinLockUnlock(&_moneyLock);
}


@end
