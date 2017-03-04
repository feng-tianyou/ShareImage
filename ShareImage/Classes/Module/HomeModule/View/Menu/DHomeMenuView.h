//
//  DHomeMenuView.h
//  ShareImage
//
//  Created by FTY on 2017/2/28.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DHomeMenuView, DHomeMenuHeader;
@protocol DHomeMenuViewDelegate <NSObject>

@optional
- (void)homeMenuView:(DHomeMenuView *)homeMenuView didSelectIndex:(NSInteger)selectIndex;
- (void)homeMenuView:(DHomeMenuView *)homeMenuView didClickHeaderView:(DHomeMenuHeader *)headerView;


@end

@interface DHomeMenuView : UIView

@property (nonatomic, weak) id<DHomeMenuViewDelegate> delegate;

- (void)reloadData;


@end
