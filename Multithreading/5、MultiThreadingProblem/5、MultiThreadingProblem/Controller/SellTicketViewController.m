//
//  SellTicketViewController.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/6/29.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "SellTicketViewController.h"
#import "SpinLock.h"
#import "UnfairLock.h"
#import "MutexLock.h"

@interface SellTicketViewController ()

@property (nonatomic, strong) SpinLock *spinLock;
@property (nonatomic, strong) UnfairLock *unfairLock;
@property (nonatomic, strong) MutexLock *mutexLock;

@end

@implementation SellTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"卖票问题";
    //自旋锁
//    self.spinLock = [[SpinLock alloc] init];
//    [self.spinLock sellTickets];

//    //不公平锁
//    self.unfairLock = [[UnfairLock alloc] init];
//    [self.unfairLock sellTickets];
    
    //互斥锁
    self.mutexLock = [[MutexLock alloc] init];
    [self.mutexLock sellTickets];
}

@end
