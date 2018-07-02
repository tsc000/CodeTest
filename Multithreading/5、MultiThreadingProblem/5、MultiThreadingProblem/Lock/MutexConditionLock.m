//
//  MutexConditionLock.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/7/2.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "MutexConditionLock.h"
#import <pthread.h>

@interface MutexConditionLock ()

@property (nonatomic, assign) pthread_mutex_t lock;
@property (nonatomic, assign) pthread_cond_t condition;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end


@implementation MutexConditionLock

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self __initLock:&_lock];
        self.dataArray = [@[] mutableCopy];
    }
    return self;
}

- (void)__initLock:(pthread_mutex_t *)lock {
    
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    //    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL);//死锁
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(lock, &attr);
    pthread_mutexattr_destroy(&attr);
    
    //初始化 互斥锁条件
    pthread_cond_init(&_condition, NULL);
}

- (void)conditionTest {
    [[[NSThread alloc] initWithTarget:self selector:@selector(__remove) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__append) object:nil] start];
}


- (void)__remove {
    pthread_mutex_lock(&_lock);
    
    if (self.dataArray.count == 0) {
        pthread_cond_wait(&_condition, &_lock);
        NSLog(@"__remove接收到信号量");
    }
    
    [self.dataArray removeLastObject];
    NSLog(@"__remove删除数据");
    
    pthread_mutex_unlock(&_lock);
    NSLog(@"__remove退出临界区");
}

- (void)__append {
    pthread_mutex_lock(&_lock);
    
    sleep(1);
    
    NSLog(@"__append添加数据");
    [self.dataArray addObject:@"test"];
    
    NSLog(@"__append发送信号");
    //产生数据之后，发送信号
    pthread_cond_signal(&_condition);
    
    NSLog(@"__append发送信号之后");
    
    pthread_mutex_unlock(&_lock);
    
    NSLog(@"__append退出临界区");
}



@end
