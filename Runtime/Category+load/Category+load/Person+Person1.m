//
//  Person+Person1.m
//  Category+load
//
//  Created by 童世超 on 2018/5/16.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "Person+Person1.h"

@implementation Person (Person1)
+ (void)load {
    NSLog(@"Person (Person1) +load");
}

- (void)test {
    NSLog(@"Person (Person1) +load");
}
@end
