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
    
    /*
        // Run Loop Observer Activities
        typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
            kCFRunLoopEntry = (1UL << 0),
            kCFRunLoopBeforeTimers = (1UL << 1),
            kCFRunLoopBeforeSources = (1UL << 2),
            kCFRunLoopBeforeWaiting = (1UL << 5),
            kCFRunLoopAfterWaiting = (1UL << 6),
            kCFRunLoopExit = (1UL << 7),
            kCFRunLoopAllActivities = 0x0FFFFFFFU
        };
     */
    
//    NSLog(@"当前线程:%@",[NSRunLoop currentRunLoop]);
//    NSLog(@"-------------------------------------------");
//    NSLog(@"主线程 :%@",[NSRunLoop mainRunLoop]);
//
//    NSLog(@"===========================================");
//    NSLog(@"当前线程:%@",CFRunLoopGetCurrent() );
//    NSLog(@"-------------------------------------------");
//    NSLog(@"主线程 :%@",CFRunLoopGetMain());

    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"Runloop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"Runloop准备处理定时器");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"Runloop准备处理Sources");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"Runloop准备休眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"Runloop被唤醒");
                break;
            case kCFRunLoopExit:
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
}
@end

