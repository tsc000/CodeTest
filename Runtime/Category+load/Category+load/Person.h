//
//  Person.h
//  Category+load
//
//  Created by 童世超 on 2018/5/16.
//  Copyright © 2018年 童世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Person : NSObject

+ (void)load;
+ (void)test;

+ (NSString *)printMethod:(Class)cls;
@end
