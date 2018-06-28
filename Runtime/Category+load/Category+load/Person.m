//
//  Person.m
//  Category+load
//
//  Created by 童世超 on 2018/5/16.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import "Person.h"

@implementation Person
+ (void)load {
    NSLog(@"Person +load");
}

+ (void)test {
    NSLog(@"Person +test");
}

+ (NSString *)printMethod:(Class)cls {
    NSMutableString *temp = [@"" mutableCopy];
    
    unsigned int count = 0;
    
    Method *list = class_copyMethodList(cls, &count);
    
    for (NSInteger i = 0; i < count ; i ++) {
        Method method = list[i];
        SEL sel = method_getName(method);
        NSString *name = NSStringFromSelector(sel);
        [temp appendString:name];
        [temp appendString:@","];
    }
    
    free(list);
    return temp;
}
@end
