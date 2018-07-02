//
//  BankMoneyViewController.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/6/29.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "BankMoneyViewController.h"
#import "SpinLock.h"
#import "UnfairLock.h"
#import "MutexLock.h"

@interface BankMoneyViewController ()

@property (nonatomic, strong) SpinLock *spinLock;
@property (nonatomic, strong) UnfairLock *unfairLock;
@property (nonatomic, strong) MutexLock *mutexLock;

@end

@implementation BankMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"存取钱问题";
//    self.spinLock = [[SpinLock alloc] init];
//    [self.spinLock bankMoney];
    
//    //不公平锁
//    self.unfairLock = [[UnfairLock alloc] init];
//    [self.unfairLock bankMoney];
    
    //互斥锁
    self.mutexLock = [[MutexLock alloc] init];
    [self.mutexLock bankMoney];
}

@end
