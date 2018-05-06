//
//  ViewController.m
//  Runloop
//
//  Created by tsc on 2018/5/4.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

//创建一个观察者
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
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
    
    // 给RunLoop添加监听者
    /*
     第一个参数 CFRunLoopRef rl：要监听哪个RunLoop,这里监听的是主线程的RunLoop
     第二个参数 CFRunLoopObserverRef observer 监听者
     第三个参数 CFStringRef mode 要监听RunLoop在哪种运行模式下的状态
     */
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    /*
     CF的内存管理（Core Foundation）
     凡是带有Create、Copy、Retain等字眼的函数，创建出来的对象，都需要在最后做一次release
     GCD本来在iOS6.0之前也是需要我们释放的，6.0之后GCD已经纳入到了ARC中，所以我们不需要管了
     */
    
    
    CFRelease(observer);
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
    // 加入到RunLoop中才可以运行
    //NSRunLoopCommonModes 代表了NSDefaultRunLoopMode 和UITrackingRunLoopMode
    //scroll滑动时进入UITrackingRunLoopMode模式，停止进入NSDefaultRunLoopMode
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]; NSLog(@"%@",[NSRunLoop mainRunLoop]);
    
    
}

-(void)show {
    NSLog(@"当前线程：%@", [NSThread currentThread]);
    NSLog(@"-------");
}


@end

