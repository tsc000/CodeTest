//
//  GuideInterface.h
//  Driver
//
//  Created by 童世超 on 2018/8/14.
//  Copyright © 2018年 Aerozhonghuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(void);

typedef NS_ENUM(NSInteger, GuideInterfaceType) {
    GuideInterfaceTypeFault = 0,
    GuideInterfaceTypeBuycar,
};


static NSString * const GuidePageHomeKey = @"GuidePageHomeKey";
static NSString * const GuidePageMajorKey = @"GuidePageMajorKey";

@interface GuideInterface : NSObject

// 获取单例
+ (instancetype)shareManager;

/**
 显示方法
 
 @param type 指引页类型
 */
- (void)showGuideInterfaceWithType:(GuideInterfaceType)type;

/**
 显示方法
 
 @param type 指引页类型
 @param completion 完成时回调
 */
- (void)showGuideInterfaceWithType:(GuideInterfaceType)type completion:(CompletionBlock)completion;

- (void)faultGuide;
@end
