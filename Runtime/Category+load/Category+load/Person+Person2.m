//
//  Person+Person2.m
//  Category+load
//
//  Created by 童世超 on 2018/5/16.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "Person+Person2.h"

@implementation Person (Person2)
+ (void)load {
    NSLog(@"Person (Person2) +load");
}

- (void)test {
    NSLog(@"Person (Person2) +load");
}
@end
