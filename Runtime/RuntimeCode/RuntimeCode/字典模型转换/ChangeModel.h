//
//  ChangeModel.h
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeModel : NSObject

@property(nonatomic, copy) NSString* ID;
@property(nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) ChangeModel *model;

@end
