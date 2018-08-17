//
//  GuideInterface.m
//  Driver
//
//  Created by 童世超 on 2018/8/14.
//  Copyright © 2018年 Aerozhonghuan. All rights reserved.
//

#import "GuideInterface.h"
#import <UIKit/UIKit.h>

@interface GuideInterface ()

@property (nonatomic, copy) CompletionBlock finish;
@property (nonatomic, copy) NSString *guidePageKey;
@property (nonatomic, assign) GuideInterfaceType guidePageType;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation GuideInterface

+ (instancetype)shareManager {
    static GuideInterface *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)showGuideInterfaceWithType:(GuideInterfaceType)type {
    [self setupControlWithType:type completion:NULL];
}

- (void)showGuideInterfaceWithType:(GuideInterfaceType)type completion:(CompletionBlock)completion
{
    [self setupControlWithType:type completion:completion];
}

- (void)setupControlWithType:(GuideInterfaceType)type completion:(CompletionBlock)completion
{
    _finish = completion;
    
    // 遮盖视图
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    //我知道了
    UIButton *knowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [knowButton setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [knowButton setImage:[UIImage imageNamed:@"button"] forState:UIControlStateSelected];
    [knowButton sizeToFit];
    knowButton.userInteractionEnabled = true;
    [knowButton addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *image = @"";
    if (type == GuideInterfaceTypeFault) {
        image = @"30";
    } else {
        image = @"29";
    }
    UIImageView* arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    [arrowImageView sizeToFit];
    
    image = @"";
    if (type == GuideInterfaceTypeFault) {
        image = @"ic_gzzd_xgnyd";
    } else {
        image = @"ic-woygc-xgnyd";
    }
    UIImageView* targetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    
    // 信息提示视图
    UIImageView *tipsImageView = [[UIImageView alloc] init];
    
    [bgView addSubview:tipsImageView];
    [bgView addSubview:knowButton];
    [bgView addSubview:arrowImageView];
    [bgView addSubview:targetImageView];
    
    self.bgView = bgView;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat y = screenWidth * 0.59;
    BOOL isIPhoneX = ([UIScreen mainScreen].bounds.size.height == 812);
    
    if (isIPhoneX) {
        y += 88;
    } else {
        y += 64;
    }
    
    if (screenHeight == 667) {
        y += 5;
    } else if (isIPhoneX) {
        y += 10;
    } else {
        y += 10;
    }
    
    CGFloat width = screenWidth / 4.0;
    
    CGFloat x = width - 2;
    CGRect rect = CGRectMake(x, y, width + 5, width + 5);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    switch (type) {
        case GuideInterfaceTypeFault:

            [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(x + rect.size.width / 2.0, y + rect.size.width / 2.0) radius:rect.size.width / 2.0 startAngle:0 endAngle:2 * M_PI clockwise:NO]];
            targetImageView.frame = rect;
            
            if (screenHeight == 667) {
                arrowImageView.frame = CGRectMake(CGRectGetMaxX(targetImageView.frame), CGRectGetMaxY(rect), 200 , arrowImageView.frame.size.height * 200 / arrowImageView.frame.size.width);
                arrowImageView.center = CGPointMake(x + rect.size.width / 2.0 + 20, y + rect.size.width + 60);
            } else {
                arrowImageView.frame = CGRectMake(CGRectGetMaxX(targetImageView.frame), CGRectGetMaxY(rect), arrowImageView.frame.size.width , arrowImageView.frame.size.height);
                arrowImageView.center = CGPointMake(x + rect.size.width / 2.0 + 10, y + rect.size.width + 65);
            }
   
            _guidePageKey = GuidePageHomeKey;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:_guidePageKey];
            break;
            
        case GuideInterfaceTypeBuycar:

            x = width * 2 - 2;
            y += width;
            
            CGRect rect = CGRectMake(x, y, width + 5, width + 5);
            
            [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(x + rect.size.width / 2.0, y + rect.size.width / 2.0) radius:rect.size.width / 2.0 startAngle:0 endAngle:2 * M_PI clockwise:NO]];
            targetImageView.frame = rect;
            
            if (screenHeight == 667) {
                arrowImageView.frame = CGRectMake(CGRectGetMaxX(targetImageView.frame), CGRectGetMaxY(rect), 200, arrowImageView.frame.size.height * 200 / arrowImageView.frame.size.width);
                arrowImageView.center = CGPointMake(x - rect.size.width / 2.0 - 10, y + rect.size.width + 30);
            } else {
                arrowImageView.frame = CGRectMake(CGRectGetMaxX(targetImageView.frame), CGRectGetMaxY(rect), arrowImageView.frame.size.width , arrowImageView.frame.size.height);
                arrowImageView.center = CGPointMake(x - rect.size.width / 2.0 - 10, y + rect.size.width + 40);
            }

            _guidePageKey = GuidePageMajorKey;
            break;
            
        default:
            break;
    }
    
    CGFloat buttonY = 0;
    
    if (isIPhoneX) {
        buttonY = screenHeight - 83 - 20;
    } else {
        buttonY = screenHeight - 49 - 20;
    }
    
    buttonY -= knowButton.frame.size.height;
    if (screenHeight <= 667) {
        buttonY += 20;
    }
    
    knowButton.frame = CGRectMake( (screenWidth - knowButton.frame.size.width )/2.0, buttonY, knowButton.frame.size.width, knowButton.frame.size.height);

    
    // 绘制透明区域
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [bgView.layer setMask:shapeLayer];
}

- (void)buttonDidClick {
    
    UIView *bgView = self.bgView;
    [bgView removeFromSuperview];
    
    [[bgView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    bgView = nil;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:_guidePageKey];
    if (_finish) _finish();
}

- (void)tap:(UITapGestureRecognizer *)recognizer {

}

- (void)faultGuide {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:GuidePageHomeKey]) {
        // 显示
        [[GuideInterface shareManager] showGuideInterfaceWithType:GuideInterfaceTypeFault completion:^{
            [[GuideInterface shareManager] showGuideInterfaceWithType:GuideInterfaceTypeBuycar];
        }];
    }
}
@end



