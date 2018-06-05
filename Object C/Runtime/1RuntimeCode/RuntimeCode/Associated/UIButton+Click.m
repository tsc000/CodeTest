//
//  UIButton+Click.m
//  RuntimeCode
//
//  Created by tsc on 2018/5/7.
//  Copyright © 2018年 tsc. All rights reserved.
//

#import "UIButton+Click.h"
#import <objc/message.h> //调用所需头文件

static const void *AssociatedKey = @"AssociatedKey";

@implementation UIButton (Click)

- (void)setClick:(Click)click {
    objc_setAssociatedObject(self, AssociatedKey, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    if (click) {
        [self addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (Click)click {
    return objc_getAssociatedObject(self, AssociatedKey);
}

- (void)buttonDidClick: (UIButton *)sender {
    if (self.click) {
        self.click();
    }
}
@end
