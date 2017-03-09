//
//  DMeHeaderView.h
//  ShareImage
//
//  Created by DaiSuke on 2017/3/7.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DMeHeaderView;
@protocol MeHeaderViewDelegate <NSObject>

@optional
- (void)meHeaderView:(DMeHeaderView *)meHeaderView didSelectIndex:(NSInteger)index;

@end

@interface DMeHeaderView : UIView

@property (nonatomic, strong) UIImageView *bgImbageView;
//@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, weak) id<MeHeaderViewDelegate> delegate;

- (void)reloadData;

@end
