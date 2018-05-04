//
//  main.m
//  Runloop
//
//  Created by tsc on 2018/5/4.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        //如果直接返回一个值，相当于线程执行一次，直接结束
        //return 0;
        
        int ret = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        //因为主线程默认开启了runloop，导致不会执行下面的代码
        printf("这里的打印执行不到");
        return ret;
    }
}
