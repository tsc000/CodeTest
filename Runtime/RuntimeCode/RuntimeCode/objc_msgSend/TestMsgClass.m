//
//  TestMsgClass.m
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import "TestMsgClass.h"

@implementation TestMsgClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self testMethod];
    }
    return self;
}

//clang测试
- (void)testMethod {
    NSLog(@"clang测试方法");
}

-(void)showAge{
    NSLog(@"24");
}
-(void)showName:(NSString *)aName{
    NSLog(@"name is %@",aName);
}
-(void)showSizeWithWidth:(float)aWidth andHeight:(float)aHeight{
    NSLog(@"size is %.2f * %.2f",aWidth, aHeight);
}
-(float)getHeight{
    return 187.5f;
}
-(NSString *)getInfo{
    return @"Hi, getInfo";
}

@end
