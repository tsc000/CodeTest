//
//  ViewController.m
//  Runloop
//
//  Created by tsc on 2018/5/4.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) NSThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

//创建一个观察者
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(createNewThread) object:nil];
    [self.thread start];
 
}


-(void)createNewThread {
    
    //必须要一个定时器事件或source 不能让runloop空置
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
//    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    
    //开启常驻子线程runloop
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        switch (activity) {
            case kCFRunLoopEntry:
                //1通知观察者Runloop进入 enter
                NSLog(@"Runloop进入");
                break;
            case kCFRunLoopBeforeTimers:
                //2通知观察者就绪定时器准备启动
                NSLog(@"Runloop准备处理定时器");
                break;
            case kCFRunLoopBeforeSources:
                //3通知观察者非基于端口（not port based）的输入源准备启动
                NSLog(@"Runloop准备处理Sources");
                break;
            case kCFRunLoopBeforeWaiting:
                //6通知观察者Runloop准备休眠
                NSLog(@"Runloop准备休眠");
                break;
            case kCFRunLoopAfterWaiting:
                //8通知观察者Runloop被唤醒
                NSLog(@"Runloop被唤醒");
                break;
            case kCFRunLoopExit:
                //10通知观察者Runloop退出 exit
                NSLog(@"Runloop退出");
                break;
            default:
                break;
        }
    });
    

    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);

    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"当前线程%@", [NSThread currentThread]);
 
}

- (void)show {
    NSLog(@"定时器事件");
}

- (IBAction)createATask:(UIButton *)sender {
    
    //向特定线程发任务，会导致runloop退出并重新创建一个新的runloop
    [self performSelector:@selector(task2) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)task2 {
    
    NSLog(@"新建的任务二所在线程%@", [NSThread currentThread]);
    NSLog(@"新建的任务二");
}

- (void)dealloc {
    
}

@end

