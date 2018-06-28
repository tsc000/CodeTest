//
//  main.m
//  Category+load
//
//  Created by 童世超 on 2018/5/16.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"
#import "Person+Person1.h"
#import "Person+Person2.h"
#import <objc/runtime.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [Person new];
        
        [person test];
        
        NSLog(@"%@", [Person printMethod:object_getClass([person class])]);
    }
    return 0;
}
