//
//  ViewController.m
//  KVO
//
//  Created by 童世超 on 2018/5/16.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic, strong) Person *person;
@property (nonatomic, strong) Person *person1;
@end

@implementation ViewController

- (NSString *)printMethod:(Class)cls {

    NSMutableString *temp = [@"" mutableCopy];
    unsigned int count = 0;
    Method *list = class_copyMethodList(cls, &count);
    
    for (NSInteger i = 0; i < count; i ++) {
        Method method = list[i];
        SEL mSel = method_getName(method);
        NSString *name = NSStringFromSelector(mSel);
        [temp appendString:name];
        [temp appendString:@","];
    }

    return temp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[Person alloc] init];
    self.person1 = [[Person alloc] init];

    
    NSLog(@"KVO添加之前%p--%p", [self.person methodForSelector:@selector(setAge:)], [self.person1 methodForSelector:@selector(setAge:)]);
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;
    [self.person addObserver:self forKeyPath:@"age" options:options context:nil];
    
    NSLog(@"KVO添加之后%p--%p", [self.person methodForSelector:@selector(setAge:)], [self.person1 methodForSelector:@selector(setAge:)]);
    
    
    NSLog(@"%@--%@--%@", [self.person class], object_getClass(self.person), object_getClass(object_getClass(self.person)));
    
    NSLog(@"%@--%@--%@", [self.person1 class], object_getClass(self.person1), object_getClass(object_getClass(self.person1)));
    
    
    NSLog(@"方法打印------");
    NSLog(@"%@--%@", object_getClass(self.person), [self printMethod:object_getClass(self.person)]);
    NSLog(@"%@--%@", object_getClass(self.person1), [self printMethod:object_getClass(self.person1)]);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.person.age = 10;
    
    NSLog(@"打印顺序 ------------");
    
    //self.person.isa ==== NSKVONotifying_Person
    [self.person setAge:10];
//    [self.person1 setAge:20];
}

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"监听到%@的%@的属性值改变 --%@", object, keyPath, change);
}
@end
