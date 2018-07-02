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
#import "NSRecursiveLockDemo.h"
#import "NSConditionDemo.h"

@interface OtherViewController ()
@property (nonatomic, strong) MutexRecursiveLock *recursiveLock;
@property (nonatomic, strong) MutexConditionLock *conditionLock;
@property (nonatomic, strong) NSRecursiveLockDemo *nsRecursiveLock;
@property (nonatomic, strong) NSConditionDemo *nsConditionLock;

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

//pthread 递归锁
- (void)recursiveLockTest {
    self.recursiveLock = [[MutexRecursiveLock alloc] init];
    
    [self.recursiveLock recursiveTest];
}

//pthread 条件锁
- (void)conditionLockTest {
    self.conditionLock = [[MutexConditionLock alloc] init];
    [self.conditionLock conditionTest];
}

//NSRecursiveLock
- (void)NSRecursiveLockTest {
    self.nsRecursiveLock = [[NSRecursiveLockDemo alloc] init];
    [self.nsRecursiveLock recursiveTest];
}

//NSConditionLock
- (void)NSConditionLockTest {
    self.nsConditionLock = [[NSConditionDemo alloc] init];
    [self.nsConditionLock conditionTest];
}


- (NSMutableArray *)selectorArray {
    if (!_selectorArray) {
        _selectorArray = [@[@"recursiveLockTest", @"conditionLockTest", @"NSRecursiveLockTest", @"NSConditionLockTest"] mutableCopy];
    }
    return _selectorArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [@[@"互斥递归锁测试", @"互斥条件锁测试", @"NSRecursiveLock", @"NSConditionLock"] mutableCopy];
    }
    return _titleArray;
}
@end
