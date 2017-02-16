//
//  DHeaderView.h
//  DFrame
//
//  Created by DaiSuke on 2017/2/8.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DHeaderView;
@protocol DHeaderViewDelegate <NSObject>

@optional
- (void)headerView:(DHeaderView *)headerView didSelectWithIndex:(NSInteger)index;

@end

@interface DHeaderView : UIView

@property (nonatomic, weak) id<DHeaderViewDelegate> delegate;

@end
