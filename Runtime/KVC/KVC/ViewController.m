//
//  ViewController.m
//  KVC
//
//  Created by 童世超 on 2018/5/16.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[Person alloc] init];
//    self.person ->_test = 10;
//    self.person -> _isTest = 11;
//    self.person -> test = 12;
//    self.person -> isTest = 13;
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;
    [self.person addObserver:self forKeyPath:@"age" options:options context:nil];
    [self.person addObserver:self forKeyPath:@"no" options:options context:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //self.person.isa ==== NSKVONotifying_Person
//    [self.person setAge:10];
    
    //1kvc 也会触发kvo
//    [self.person setValue:@"10" forKey:@"age"];


    //2如果没有set方法 _set方法， 也没有_no, _isNo, no, isNo,直接崩溃,不会执行setValueForundefinedkey
//    [self.person setValue:@20 forKey:@"no"];
    
    //3取值 getTest方法 也没有_test, _isTest, test, isTest,如果没有调用valueForundefinekey，没有重写这个方法，直接崩溃
    NSLog(@"%@", [self.person valueForKey:@"test"]);
}

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"监听到%@的%@的属性值改变 --%@", object, keyPath, change);
}

@end
