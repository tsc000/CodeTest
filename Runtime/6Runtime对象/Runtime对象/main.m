//
//  main.m
//  Runtime对象
//
//  Created by 童世超 on 2018/5/14.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>



@interface Person: NSObject
{
@public
    int _age;
}
@end

@implementation Person

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSObject *obj1 = [[NSObject alloc] init];
        NSObject *obj2 = [[NSObject alloc] init];
        
        Class classOjb1 = [obj1 class];
        Class classOjb2 = [obj1 class];
        Class classOjb3 = [NSObject class];
        Class classOjb4 = object_getClass(obj1);
        
        Class metaObj1 = object_getClass(classOjb1);
        
        NSLog(@"实例对象--------------");
        NSLog(@"%@---%@", obj1, obj2);
        NSLog(@"类对象--------------");
        NSLog(@"%p--%p--%p--%p", classOjb1, classOjb2, classOjb3, classOjb4);
        NSLog(@"元类对象--------------");
        NSLog(@"%p", metaObj1);
        
    }
    return 0;
}
