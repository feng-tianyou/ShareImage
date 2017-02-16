//
//  DTabBar.h
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DTabBar;

@protocol DTabBarDelegate <NSObject>

@optional
- (void)tabBar:(DTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
///**点击中间按钮*/
//- (void)tabBarDidClickedPlusButton;
@end

@interface DTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;



@property (nonatomic, weak) id<DTabBarDelegate> delagate;

@end
