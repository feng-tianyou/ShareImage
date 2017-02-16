//
//  DTabBar.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DTabBar.h"
#import "DTabBarButton.h"

@interface DTabBar ()
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
// 中间按钮
//@property (nonatomic, weak) UIButton *plusButton;
@property (nonatomic, weak) DTabBarButton *selectedButton;

@end

@implementation DTabBar

- (NSMutableArray *)tabBarButtons{
    
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 添加中间按钮
//        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
//        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
//        
//        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
//        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
//        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
//        [self addSubview:plusButton];
//        [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        self.plusButton = plusButton;
        
        self.dk_backgroundColorPicker = DKColorPickerWithKey(TABBAR);
    }
    return self;
}

//- (void)plusButtonClick{
//    
//    // 通知代理
//    if ([self.delagate respondsToSelector:@selector(tabBarDidClickedPlusButton)]) {
//        [self.delagate tabBarDidClickedPlusButton];
//    }
//}

/**
 添加TabBar按钮
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    // 创建按钮
    DTabBarButton *button = [[DTabBarButton alloc] init];
    [self addSubview:button];
    
    // 添加到数组
    [self.tabBarButtons addObject:button];
    
    // 设置数据
    button.item = item;
    
    // 监听按钮
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 默认选中第一个
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
    
}


/**
 监听按钮点击
 */
- (void)buttonClick:(DTabBarButton *)button{
    
    // 通知代理
    if ([self.delagate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delagate tabBar:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    
    // 设置按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 设置加好按钮的frame
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
//    self.plusButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置按钮的frame
    CGFloat buttonW = width / self.subviews.count;
    CGFloat buttonH = height;
    CGFloat buttonY = 0;
    for (int index = 0; index < self.tabBarButtons.count; index++) {
        
        // 取出按钮
        DTabBarButton *button = self.tabBarButtons[index];
        
        CGFloat buttonX = index * buttonW;
//        if (index > 1) {
//            buttonX += buttonW;
//        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 按钮绑定tag
        button.tag = index;
    }
}

@end
