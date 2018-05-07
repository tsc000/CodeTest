//
//  NSObject+TSCKeyValue.m
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import "NSObject+TSCKeyValue.h"
#import <objc/message.h> //调用所需头文件

@implementation NSObject (TSCKeyValue)

+ (id)objectWithKeyValues:(NSDictionary *)aDictionary {
    id obj = [[self alloc] init];
    
    //遍历字典，依次设置对应key的value
    for (NSString *key in aDictionary.allKeys) {
        id value = aDictionary[key];
        //获取对应类中对应名字的属性
        objc_property_t property = class_getProperty(self, key.UTF8String);
        unsigned int count = 0;
        //返回对应属性的所有特征Attribute（attributeList相当于数组的首地址）
        objc_property_attribute_t *attributeList = property_copyAttributeList(property, &count);
        //取数组的第一个元素
        objc_property_attribute_t attribute = attributeList[0];
        NSString *typeString = [NSString stringWithUTF8String:attribute.value];
        
        if ([typeString isEqualToString:@"@\"ChangeModel\""]) {
            value = [self objectWithKeyValues:value];
        }
//        NSLog(@"%s", attribute.name);
//        NSLog(@"%s", attribute.value);
        
        //配置setter方法,
        NSString *setMethod = [NSString stringWithFormat:@"set%@%@:", [key substringToIndex:1].uppercaseString, [key substringFromIndex:1]];
        //注册方法
        SEL sel = sel_registerName(setMethod.UTF8String);
        if ([obj respondsToSelector:sel]) {
            ( (void (*)(id, SEL, id))(void *)objc_msgSend ) ( obj, sel,  value);
        }
        
        //释放分配的内存 must be free'd() by the caller.
        free(attributeList);

    }
    
    return obj;
}

- (NSDictionary *)keyValuesWithObject {
    
    unsigned int count = 0;
    //propertyList相当于数组的首地址,利用返回的count防止数组越界
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    for (NSInteger i = 0; i < count; i ++) {
    
        //获取单一属性
        objc_property_t property = propertyList[i];
        //获取属性名
        const char *propertyName = property_getName(property);
        //注册getter方法
        SEL getter = sel_registerName(propertyName);
        
        if ([self respondsToSelector:getter]) {
            id value = ((id (*) (id,SEL)) objc_msgSend) (self, getter);
            
            //如果是对应的模型
            if ([value isKindOfClass:[self class]] && value) {
                value = [value keyValuesWithObject];
            }
            
            if (value) {
                NSString *key = [NSString stringWithUTF8String:propertyName];
                dict[key] = value;
            }
        }
    }
    
    free(propertyList);
    return dict;
}


@end
