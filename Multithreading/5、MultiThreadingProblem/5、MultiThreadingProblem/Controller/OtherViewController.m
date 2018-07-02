//
//  OtherViewController.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/7/2.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "OtherViewController.h"
#import "MutexRecursiveLock.h"
#import "MutexConditionLock.h"

@interface OtherViewController ()
@property (nonatomic, strong) MutexRecursiveLock *recursiveLock;
@property (nonatomic, strong) MutexConditionLock *conditionLock;

@property (nonatomic, strong) NSMutableArray *selectorArray;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleArray[self.type];
    
    NSString *selectorName = self.selectorArray[self.type];
    SEL sel = NSSelectorFromString(selectorName);
    [self performSelector:sel];
}

- (void)recursiveLockTest {
    self.recursiveLock = [[MutexRecursiveLock alloc] init];
    
    [self.recursiveLock recursiveTest];
}

- (void)conditionLockTest {
    self.conditionLock = [[MutexConditionLock alloc] init];
    [self.conditionLock conditionTest];
}

- (NSMutableArray *)selectorArray {
    if (!_selectorArray) {
        _selectorArray = [@[@"recursiveLockTest", @"conditionLockTest"] mutableCopy];
    }
    return _selectorArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [@[@"互斥递归锁测试", @"互斥条件锁测试"] mutableCopy];
    }
    return _titleArray;
}
@end
