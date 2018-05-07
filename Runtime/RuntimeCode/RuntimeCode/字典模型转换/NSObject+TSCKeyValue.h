//
//  NSObject+TSCKeyValue.h
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TSCKeyValue)

+ (id)objectWithKeyValues:(NSDictionary *)aDictionary;
- (NSDictionary *)keyValuesWithObject;

@end
