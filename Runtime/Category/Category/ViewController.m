//
//  ViewController.m
//  Category
//
//  Created by 童世超 on 2018/5/16.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+Eat.h"
#import "Person+Test.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *person = [[Person alloc] init];
    [person run];
    [person eat];
    [person test];
    
    NSLog(@"%@", [self printMethod:[person class]]);
    
}


- (NSString *)printMethod:(Class)cls {

    NSMutableString *temp = [@"" mutableCopy];
    
    unsigned int count = 0;
    Method *list = class_copyMethodList(cls, &count);
    
    for (NSInteger i = 0; i < count ; i ++) {
        Method method = list[i];
        SEL msel = method_getName(method);
        NSString *name = NSStringFromSelector(msel);
        [temp appendString:name];
        [temp appendString:@","];
    }
    
    return temp;
}


@end
