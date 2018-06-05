//
//  main.m
//  Clang
//
//  Created by 童世超 on 2018/5/14.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>
//类的底层大致结构，就是一个结构体
struct NSObject_IMPL {
    Class isa;
};
//xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc 源文件 -o 目标文件
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSObject *obj = [[NSObject alloc] init];
        
        //runtime 方法 获取实例大小(实际占用的空间),
        size_t count1 = class_getInstanceSize([obj class]);
        
        //malloc 方法 获取分配的大小,
        size_t count2 = malloc_size((__bridge const void *)(obj));
        
        //sizeof 方法，这个标识符只是测试变量占用多少字节
        NSInteger count3 = sizeof(obj);
        
        NSLog(@"class_getInstanceSize---%ld", count1);
        NSLog(@"malloc_size---%ld", count2);
        NSLog(@"sizeof---%ld", count3);
    }
    return 0;
}
