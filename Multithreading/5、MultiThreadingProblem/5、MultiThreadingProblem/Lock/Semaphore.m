//
//  Semaphore.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/7/3.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "Semaphore.h"

@interface Semaphore ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation Semaphore

- (void)semaphoreTest {
    
    self.semaphore = dispatch_semaphore_create(5);
    
    //开启20个线程
    for (NSInteger i = 0; i < 20 ; i ++) {
        [[[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil] start];
    }
}

- (void)run {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    sleep(1);
    NSLog(@"%@--%s", [NSThread currentThread], __func__);
    dispatch_semaphore_signal(self.semaphore);
    
}

@end
