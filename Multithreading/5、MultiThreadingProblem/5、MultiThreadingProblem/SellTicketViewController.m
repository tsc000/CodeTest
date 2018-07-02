//
//  SellTicketViewController.m
//  5、MultiThreadingProblem
//
//  Created by 童世超 on 2018/6/29.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "SellTicketViewController.h"
#import <libkern/OSAtomic.h>

@interface SellTicketViewController ()
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) OSSpinLock lock;
@end

@implementation SellTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.count = 15;
    self.lock = OS_SPINLOCK_INIT;
    [self sellTickets];
}

//卖票问题
- (void)sellTickets {
    
    dispatch_queue_t queue = dispatch_queue_create("sellTicket", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            [self sellOneTicket];
        }
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            [self sellOneTicket];
        }
    });
    
    dispatch_async(queue, ^{
        
        for (NSInteger i = 0; i < 5; i ++) {
            [self sellOneTicket];
        }
    });
}

- (void)sellOneTicket {
    
    //    [self locklessSellOneTicket]; //无锁
    [self spinLockSellOneTicket];   //自旋锁
}

//没有加锁的卖票
- (void)locklessSellOneTicket {
    NSInteger cnt = self.count;
    sleep(.2);
    cnt --;
    self.count = cnt;
    NSLog(@"还剩%ld张票: %@", self.count, [NSThread currentThread]);
}

//自旋锁
- (void)spinLockSellOneTicket {
    
    //自旋锁会让其它也准备进入临界区的线程处于 忙等状态，可能会发生优先级反转
    OSSpinLockLock(&_lock);
    
    NSInteger cnt = self.count;
    sleep(.2);
    cnt --;
    self.count = cnt;
    NSLog(@"还剩%ld张票: %@", self.count, [NSThread currentThread]);
    
    OSSpinLockUnlock(&_lock);
}

@end
