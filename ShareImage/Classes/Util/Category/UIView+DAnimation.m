//
//  UIView+DAnimation.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/11.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "UIView+DAnimation.h"

@interface UIView ()<CAAnimationDelegate>

@end

@implementation UIView (DAnimation)

- (void)setViewContentHidden:(BOOL)isHidden{
    
    if(isHidden){
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(1), @(1.2), @(0.01)];
        animation.keyTimes = @[@(0), @(0.4), @(1)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        animation.duration = 0.35;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        animation.delegate = self;
        [self.layer addAnimation:animation forKey:@"bounce"];
    }
    else{
        
        [self setHidden:NO];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
        animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        animation.duration = 0.5;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [self.layer addAnimation:animation forKey:@"bounce"];
    }
}

/**
 展示弹框动画效果
 */
- (void)alertShow{
    if(self.hidden){
        [self setHidden:NO];
        [self setAlpha:0.0];
        [UIView animateWithDuration:0.3 animations:^{
            [self setAlpha:1.0];
        }];
        [self setViewContentHidden:NO];
    }
}
/**
 隐藏弹框动画效果
 */
- (void)alertDismiss{
    if(!self.hidden){
        [self setHidden:NO];
        [self setAlpha:1.0];
        [self setViewContentHidden:YES];
        [UIView animateWithDuration:0.35 animations:^{
            [self setAlpha:0.0];
        } completion:^(BOOL finished) {
            [self setHidden:YES];
        }];
    }
}

@end
