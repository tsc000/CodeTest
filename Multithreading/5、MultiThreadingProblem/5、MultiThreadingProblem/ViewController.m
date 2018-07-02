//
//  ViewController.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/6/29.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "ViewController.h"
#import "SellTicketViewController.h"
#import "BankMoneyViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)sellTicks:(UIButton *)sender {
    
    SellTicketViewController *controller = [[SellTicketViewController alloc] init];
    [self.navigationController pushViewController:controller animated:true];
}

- (IBAction)bankMoney:(UIButton *)sender {
    BankMoneyViewController *controller = [[BankMoneyViewController alloc] init];
    [self.navigationController pushViewController:controller animated:true];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}



@end
