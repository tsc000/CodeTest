//
//  Son.m
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import "Son.h"

@implementation Son

- (instancetype)init
{
    self = [super init];
    if (self) {
        //两个类方法的receiver都是self，所以结果一样都是Son

        NSLog(@"%@", NSStringFromClass([self class]));
////        ((Class (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("class")))
        NSLog(@"%@", NSStringFromClass([super class]));
        
//    ((Class (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)(
//        (__rw_objc_super){
//          (id)self,
//          (id)class_getSuperclass(objc_getClass("Son"))
//        },
//        sel_registerName("class"))
//    )
        
//    第一步先构造 objc_super 结构体，结构体第一个成员就是 self。第二个成员是 (id)class_getSuperclass(objc_getClass(“Son”)).
//
//    第二步是去 Father 这个类里去找 - (Class)class，没有，然后去 NSObject 类去找，找到了。最后内部是使用 objc_msgSend(objc_super->receiver, @selector(class)) 去调用，此时已经和 [self class] 调用相同了，所以两个输出结果都是 Son。
        
    }
    return self;
}
@end
