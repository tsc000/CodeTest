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
#import "OtherViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *controllerArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.controllerArray[indexPath.row];
    
    Class class = NSClassFromString(name);
    
    UIViewController *controller = [[class alloc] init];
    
    if ([controller isKindOfClass:[OtherViewController class]]) {
        OtherViewController *c = (OtherViewController *)controller;
        c.type = indexPath.row - 2;
        [self.navigationController pushViewController:controller animated:true];
        return;
    }
    
    [self.navigationController pushViewController:controller animated:true];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[@"卖票问题", @"存取钱问题", @"互斥递归锁",  @"互斥条件锁"] mutableCopy];
    }
    return _dataArray;
}

- (NSMutableArray *)controllerArray {
    if (!_controllerArray) {
        _controllerArray = [@[@"SellTicketViewController", @"BankMoneyViewController", @"OtherViewController", @"OtherViewController"] mutableCopy];
    }
    return _controllerArray;
}

@end
