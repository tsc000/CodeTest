//
//  main.m
//  RuntimeDeep
//
//  Created by 童世超 on 2018/5/15.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Person: NSObject
{
@public
    int _age;
}
@end

@implementation Person

@end

struct tsc_objc_class {
    Class isa;
    Class super_class
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [[Person alloc] init]; //person->isa： 0x001d800100001179
        Class personClass = [person class]; //personClass：0x0000000100001178
        Class personMetaClass = object_getClass(personClass); //0x0000000100001150
        
        //强制转换，打印出isa
        struct tsc_objc_class *tscClass = (__bridge struct tsc_objc_class *)(personClass);
        //64位之后位操作之后才会得到类对象的地址
//        person->isa： 0x001d800100001179 & 0x00007ffffffffff8 = 0x0000000100001178
        
        
        NSLog(@"%p,%p,%p", person, personClass, personMetaClass);
        
    }
    return 0;
}
