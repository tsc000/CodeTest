//
//  main.m
//  RumtimeCustomObject
//
//  Created by 童世超 on 2018/5/14.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>


struct Student_IMPL {
    Class isa;
    int _no;
    int _age;
    int _name;
};

@interface Student: NSObject
{
    @public
    int _no;
    int _age;
    int _name;
}
@end

@implementation Student

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Student *student = [[Student alloc] init];
        student -> _no = 4;
        student -> _age = 5;
        
        //runtime 方法 获取实例大小(内存对齐之后实际占用的空间),
        size_t count1 = class_getInstanceSize([student class]);
        
        //malloc 方法 获取分配的大小,
        size_t count2 = malloc_size((__bridge const void *)(student));
        
        //sizeof 方法, 这个标识符只是测试变量占用多少字节
        NSInteger count3 = sizeof(student);
        
        NSLog(@"class_getInstanceSize---%ld", count1);
        NSLog(@"malloc_size---%ld", count2);
        NSLog(@"sizeof---%ld", count3);
        
        NSLog(@"*********************************************");
        /*********************************************/
        
        
        struct Student_IMPL *impl = (__bridge struct Student_IMPL *)(student);
        NSLog(@"%d, %d", impl -> _no, impl -> _age);
        
        
    }
    return 0;
}
