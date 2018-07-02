//
//  SellTicketViewController.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/6/29.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "SellTicketViewController.h"
#import "SpinLock.h"

@interface SellTicketViewController ()

@property (nonatomic, strong) SpinLock *spinLock;

@end

@implementation SellTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.spinLock = [[SpinLock alloc] init];
    [self.spinLock sellTickets];

}

@end
