//
//  ViewController.m
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import "ViewController.h"
#import "TestMsgClass.h"
#import <objc/message.h> //调用所需头文件
#import "UIButton+Click.h" //click button
#import "AutomaticArchive.h"
#import "ChangeModel.h"
#import "NSObject+TSCKeyValue.h"
#import "Cat.h"
#import "Son.h"
#import "NSObject+Sark.h"
#import "StackOffset.h"

@interface ViewController ()

@property(nonatomic, strong) NSDictionary *dictionary;
@property(nonatomic, strong) NSDictionary *dictionary1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dictionary1 = @{
                   @"ID":@"123456",
                   @"name":@"tsc",
                   @"age":@"tsc",
                   @"model":@{
                       @"ID":@"123456",
                       @"name":@"tsc",
                       @"age":@"tsc"
                    }
                   };
    
    self.dictionary = @{
                        @"ID":@"123456",
                        @"name":@"tsc"
                        };
}

- (IBAction)offsetButtonDidClick:(UIButton *)sender {
    
    NSString *name = @"tsc";
    id cls = [StackOffset class];
    void *obj = &cls;
    [(__bridge id)obj speak];
    
}

//测试分类方法
- (IBAction)sarkButtonDidClick:(UIButton *)sender {
    
    //    // 测试代码
    [NSObject foo];
    [[NSObject new] foo];
    
    id isa = [NSObject valueForKey:@"isa"];
//    id class = [NSObject class];
//    NSLog(@"%@", class);
    
    NSLog(@"%@", isa);
}

//动态方法解析
- (IBAction)resolveButtonDidClick:(UIButton *)sender {
    Cat *cat = [[Cat alloc] init];
    
    ( (void (*)(id, SEL))(void *)objc_msgSend ) ( (id)cat, sel_registerName("fly") );
    
}

//模型字典转换
- (IBAction)changeButtonDidClick:(UIButton *)sender {
    ChangeModel *change = [ChangeModel objectWithKeyValues:self.dictionary1];
    
    NSLog(@"change.ID is %@",change.ID);
    NSLog(@"change.name is %@",change.name);
    NSLog(@"change.model.name is %@",change.model.name);
    
    NSDictionary *dict = [change keyValuesWithObject];
    NSLog(@"dict: %@", dict);
}

//归档
- (IBAction)archiveButtonDidClick:(UIButton *)sender {
    
    AutomaticArchive *test = [AutomaticArchive automaticArchiveWithDict:self.dictionary];
    NSLog(@"test.ID is %@",test.ID);
    NSLog(@"test.name is %@",test.name);
    
    //保存到本地
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"test"];
    [NSKeyedArchiver archiveRootObject:test toFile:path];
    
    AutomaticArchive *model = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"model is %@",model.ID);
    NSLog(@"model is %@",model.name);

    
}

//为现有类添加属性
- (IBAction)associateButtonDidClick:(UIButton *)sender {
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clickButton.frame = CGRectMake(0, 30, 200, 20);
    CGPoint center = clickButton.center;
    center.x = self.view.center.x;
    clickButton.center = center;
    
    [clickButton setTitle:@"button分类测试" forState:UIControlStateNormal];
    [clickButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    clickButton.click = ^{
        NSLog(@"点击事件");
    };
    
    [self.view addSubview:clickButton];
}


- (IBAction)fatherSonButtonDidClICK:(UIButton *)sender {

    Son *son = [[Son alloc] init];
    

//    objc_setAssociatedObject
    //    objc_super;
    //    objc_getClass;
    
}

//objc_msgSend 测试
- (IBAction)msgsendButtonDidClick:(UIButton *)sender {
    TestMsgClass *test = [[TestMsgClass alloc] init];
    
    //利用clang获取的方法调用testMethod
//    ((void (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("testMethod"));
    
    //MARK: showAge方法调用
    //无参无返回值(id, SEL) 参数类型， 第一个void 返回值类型
    ( (void (*)(id, SEL))(void *)objc_msgSend ) ( (id)test, sel_registerName("showAge") );
    //上面也可写成
    ( (void (*)(TestMsgClass*, SEL))(void *)objc_msgSend ) ( test, sel_registerName("showAge") );
    
    //MARK: showName方法调用
    //无参无返回值(id, SEL, NSString *) 参数类型， 第一个void 返回值类型
    ( (void (*)(id, SEL, NSString *))(void *)objc_msgSend ) ( (id)test, sel_registerName("showName:"),  @"tsc");
    
    //MARK: showSizeWithWidth方法调用
    //无参无返回值(id, SEL, float, float) 参数类型， 第一个void 返回值类型
    ( (void (*)(id, SEL, float, float))(void *)objc_msgSend ) ( (id)test, sel_registerName("showSizeWithWidth:andHeight:"),  10, 20);
    
    //MARK: getHeight方法调用
    //无参无返回值(id, SEL) 参数类型， 第一个float 返回值类型
    float result = ( (float (*)(id, SEL))(void *)objc_msgSend ) ( (id)test, sel_registerName("getHeight"));
    NSLog(@"%f", result);
    
    //MARK: getInfo方法调用
    //无参无返回值(id, SEL) 参数类型， 第一个NSString 返回值类型
    NSString *result1 = ( (NSString * (*)(id, SEL))(void *)objc_msgSend ) ( (id)test, sel_registerName("getInfo"));
    NSLog(@"%@", result1);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
