//
//  AutomaticArchive.h
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutomaticArchive : NSObject<NSCoding>

@property(nonatomic, copy) NSString* ID;
@property(nonatomic, copy) NSString* name;

+ (instancetype)automaticArchiveWithDict:(NSDictionary *)dict;
@end
