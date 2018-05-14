//
//  main.m
//  RuntimProperty
//
//  Created by 童世超 on 2018/5/14.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

@interface Person: NSObject
{
@public
    int _age;
}

//指针在mac 8B
@property(nonatomic, copy) NSString *no;
@end

@implementation Person

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [[Person alloc] init];
        person -> _age = 10;
        person.no = @"abc";
        NSLog(@"Person对象空间展示：");
        //runtime 方法 获取实例大小(内存对齐之后实际占用的空间),
        size_t count1 = class_getInstanceSize([person class]);
        
        //malloc 方法 获取分配的大小,
        size_t count2 = malloc_size((__bridge const void *)(person));
        
        //sizeof 方法, 这个标识符只是测试变量占用多少字节
        NSInteger count3 = sizeof(person);
        
        NSLog(@"class_getInstanceSize---%ld", count1); // 8 + 8 + 8(4B已用，4B未用)
        NSLog(@"malloc_size---%ld", count2);
        NSLog(@"sizeof---%ld", count3);
    }
    return 0;
}
