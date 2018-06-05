//
//  UIButton+Click.h
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Click)(void);

@interface UIButton (Click)

- (void)setClick:(Click)click;
- (Click)click;

@end
