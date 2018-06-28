//
//  Person.m
//  KVO
//
//  Created by 童世超 on 2018/5/16.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)setAge:(NSInteger)age {
    _age = age;
    NSLog(@"setAge");
}

/******************set********************/
//1 如果有首先执行
//- (void)setNo:(NSInteger)no {
//    NSLog(@"setNo");
//}

//2 如果没有1，有2就执行2
//- (void)_setNo:(NSInteger)no {
//    
//    NSLog(@"_setNo");
//}

//3
+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"未找到对应的变量");
}

/******************get********************/
//1
//- (NSInteger)getTest {
//    return 19;
//}


- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}
@end
