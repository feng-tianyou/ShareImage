//
//  DBaseViewController.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+DNetwork.h"

@interface DBaseViewController : UIViewController

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

/**
 附带信息
 */
@property (nonatomic, strong) NSMutableDictionary *networkUserInfo;



#pragma mark - navigation(子类重写方法)
/**
 导航栏左右按钮点击事件（子类重写即可）

 @param navBtn 导航按钮
 @param isLeft 是否是左按钮
 */
- (void)baseViewControllerDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft;
/**
 导航栏左按钮点击事件（子类重写即可）

 @param leftBtn 左按钮
 */
- (void)baseViewControllerDidClickNavigationLeftBtn:(UIButton *)leftBtn;
/**
 导航栏右按钮点击事件（子类重写即可）
 
 @param rightBtn 右按钮
 */
- (void)baseViewControllerDidClickNavigationRightBtn:(UIButton *)rightBtn;
/**
 导航栏标题按钮点击事件（子类重写即可）
 
 @param titleBtn 标题按钮
 */
- (void)baseViewControllerDidClickNavigationTitleBtn:(UIButton *)titleBtn;

@end
