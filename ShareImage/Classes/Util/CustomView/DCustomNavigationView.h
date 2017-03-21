//
//  DCustomNavigationView.h
//  ShareImage
//
//  Created by DaiSuke on 2017/3/5.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCustomNavigationView : UIView

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *navLeftItem;
@property (nonatomic, strong) UIButton *navRightItem;
@property (nonatomic, strong) UIButton *navTitleItem;


@property (nonatomic, copy) NSString *title;

/**
 控制栏左边按钮类型
 */
@property (nonatomic, assign) DNavigationItemType navLeftItemType;
/**
 控制栏右边按钮类型
 */
@property (nonatomic, assign) DNavigationItemType navRighItemType;

@end
