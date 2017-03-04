//
//  UIView+DAnimation.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/11.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DAnimation)

/**
 展示弹框动画效果(条件：view.hidden = yes)
 */
- (void)alertShow;
/**
 隐藏弹框动画效果
 */
- (void)alertDismiss;

/**
 添加旋转动画
 */
- (void)addRotate;

@end
