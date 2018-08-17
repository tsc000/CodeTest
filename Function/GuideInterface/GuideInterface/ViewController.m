//
//  ViewController.m
//  GuideInterface
//
//  Created by 童世超 on 2018/8/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "GuideInterface.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[GuideInterface shareInstance] showGuide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
