//
//  Cat.m
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import "Cat.h"
#import "Bird.h"
#import "Swan.h"
#import <objc/runtime.h>

@implementation Cat

- (void)run {
    NSLog(@"cat can run fast");
}

//1.进入 resolveInstanceMethod: 方法，指定是否动态添加方法。若返回NO，则进入下一步，
//若返回YES，则通过 class_addMethod 函数动态地添加方法，消息得到处理，此流程完毕。
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
#if 1
    return NO;
#else
    //参数1：self要添加sel这个方法
    //参数2：要添加的sel方法
    //参数3：sel方法的实现
    //参数4：types An array of characters that describe the types of the arguments to the method.
    class_addMethod(self, sel, class_getMethodImplementation(self, sel_registerName("run")), "v@:");
    //点击之后只执行了一次， 第一次添加的时候已经添加到cache
    
    return [super resolveInstanceMethod:sel];
#endif
}

//+ (BOOL)resolveClassMethod:(SEL)sel

//2.resolveInstanceMethod: 方法返回 NO 时，就会进入 forwardingTargetForSelector: 方法，
//这是 Runtime 给我们的第二次机会，用于指定哪个对象响应这个 selector。返回nil，进入下一步，返回某个对象，则会调用该对象的方法。
- (id)forwardingTargetForSelector:(SEL)aSelector {
#if 1
    return nil;
#else
    return [[Bird alloc] init];
#endif
}

//3获取方法签名进入下一步，进行消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}


//4消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation {

    [anInvocation invokeWithTarget:[[Swan alloc] init]];
}
@end
