//
//  AutomaticArchive.m
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import "AutomaticArchive.h"
#import <objc/message.h> //调用所需头文件

@implementation AutomaticArchive


+ (instancetype)automaticArchiveWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initAutomaticArchiveWithDict:dict];
}

- (instancetype)initAutomaticArchiveWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([self class], &count);
    for (NSInteger i = 0; i < count ; i ++) {
        Ivar var = vars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [coder encodeObject:value forKey:key];
    }

}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self == [super init]) {

        unsigned int  count = 0;
        Ivar *vars = class_copyIvarList([self class], &count);
        for (NSInteger i = 0; i < count; i ++) {
            Ivar var = vars[i];
            const char *name = ivar_getName(var);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }

    }
    
    return self;
}




@end
