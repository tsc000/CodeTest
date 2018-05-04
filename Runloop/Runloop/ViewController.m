//
//  ViewController.m
//  Runloop
//
//  Created by tsc on 2018/5/4.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
}


- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = @"adsf";
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (IBAction)buttonDidclick:(UIButton *)sender {
    NSLog(@"buttonDidclick");
    NSLog(@"%@", [NSRunLoop currentRunLoop]);
}


- (UITableView *)tableview {
    
    if (!_tableview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableview = tableView;
    }
    
    return _tableview;
}


@end

