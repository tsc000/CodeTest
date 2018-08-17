//
//  GuideInterface.h
//  Driver
//
//  Created by 童世超 on 2018/8/14.
//  Copyright © 2018年 Aerozhonghuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(void);
//类型自行更改
typedef NS_ENUM(NSInteger, GuideInterfaceType) {
    GuideInterfaceTypeOne = 0,
    GuideInterfaceTypeTwo,
};

//KEY自行更改
static NSString * const GuideInterfaceOneKey = @"GuidePageHomeOneKey";
static NSString * const GuideInterfaceTwoKey = @"GuideInterfaceTwoKey";

@interface GuideInterface : NSObject

// 获取单例
+ (instancetype)shareInstance;

/**
 显示方法

 @param type 指引页类型
 */
- (void)showGuideInterfaceWith:(GuideInterfaceType)type;

/**
 显示方法
 
 @param type 指引页类型
 @param completion 完成时回调
 */
- (void)showGuideInterfaceWith:(GuideInterfaceType)type completion:(CompletionBlock)completion;

//显示引导
- (void)showGuide;

@end
