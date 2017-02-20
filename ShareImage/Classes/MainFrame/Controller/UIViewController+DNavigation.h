//
//  UIViewController+DNavigation.h
//  DFrame
//
//  Created by FTY on 2017/2/13.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DNavigation)

/**
 控制栏标题按钮类型
 */
@property (nonatomic, assign) DNavigationItemType    navTitleItemType;
/**
 控制栏左边按钮类型
 */
@property (nonatomic, assign) DNavigationItemType    navLeftItemType;
/**
 控制栏右边按钮类型
 */
@property (nonatomic, assign) DNavigationItemType    navRighItemType;

#pragma mark - navigation(子类重写方法)
/**
 导航栏左右按钮点击事件（子类重写即可）
 
 @param navBtn 导航按钮
 @param isLeft 是否是左按钮
 */
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft;
/**
 导航栏左按钮点击事件（子类重写即可）
 
 @param leftBtn 左按钮
 */
- (void)navigationBarDidClickNavigationLeftBtn:(UIButton *)leftBtn;
/**
 导航栏右按钮点击事件（子类重写即可）
 
 @param rightBtn 右按钮
 */
- (void)navigationBarDidClickNavigationRightBtn:(UIButton *)rightBtn;
/**
 导航栏标题按钮点击事件（子类重写即可）
 
 @param titleBtn 标题按钮
 */
- (void)navigationBarDidClickNavigationTitleBtn:(UIButton *)titleBtn;

@end
