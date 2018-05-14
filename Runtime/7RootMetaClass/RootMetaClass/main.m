//
//  main.m
//  RootMetaClass
//
//  Created by 童世超 on 2018/5/14.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Test.h"

@interface Person: NSObject
+ (void)test;
@end

@implementation Person
//+ (void)test {
//    NSLog(@"[Person test]-%p", self);
//}
@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"[Person class]--%p", [Person class]);
        NSLog(@"[NSObject class]--%p", [NSObject class]);
        
        //下面执行的是对象的方法（类方法没有实现）
        //只有NSObject的元类对象指向自己的类对象
        [Person test];
        [NSObject test];
        
    }
    return 0;
}
