//
//  DCustomButton.m
//  DFrame
//
//  Created by DaiSuke on 2017/2/9.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCustomButton.h"

// 图片占据按钮的比例
#define DTabBarButtonImageRatio 0.6

@implementation DCustomButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        // 设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        }
        
        
        
    }
    return self;
}

// 消除高亮状态
- (void)setHighlighted:(BOOL)highlighted{}

#pragma mark - 重写布局

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * DTabBarButtonImageRatio;
    
    return CGRectMake(0, 0, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * DTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}




@end
