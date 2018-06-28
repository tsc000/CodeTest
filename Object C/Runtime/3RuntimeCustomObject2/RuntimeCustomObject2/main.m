//
//  main.m
//  RuntimeCustomObject2
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
@end

@implementation Person

@end

@interface Student: Person
{
@public
    int _no;
}
@end

@implementation Student

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Student *student = [[Student alloc] init];
        student -> _no = 4;
        student -> _age = 5;
        
        Person *person = [[Person alloc] init];
        
        NSLog(@"Stuent对象空间展示：");
        //runtime 方法 获取实例大小(内存对齐之后实际占用的空间),
        size_t count1 = class_getInstanceSize([student class]);
        
        //malloc 方法 获取分配的大小,
        size_t count2 = malloc_size((__bridge const void *)(student));
        
        //sizeof 方法, 这个标识符只是测试变量占用多少字节
        NSInteger count3 = sizeof(student);
        
        NSLog(@"class_getInstanceSize---%ld", count1);
        NSLog(@"malloc_size---%ld", count2);
        NSLog(@"sizeof---%ld", count3);
        
        NSLog(@"Person对象空间展示：");
        
        //runtime 方法 获取实例大小(实际占用的空间),
        size_t count4 = class_getInstanceSize([person class]);
        
        //malloc 方法 获取分配的大小,
        size_t count5 = malloc_size((__bridge const void *)(person));
        
        //sizeof 方法, 这个标识符只是测试变量占用多少字节
        NSInteger count6 = sizeof(person);
        
        NSLog(@"class_getInstanceSize---%ld", count4);
        NSLog(@"malloc_size---%ld", count5);
        NSLog(@"sizeof---%ld", count6);
        
        
    }
    return 0;
}
