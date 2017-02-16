//
//  DMenuAlertView.h
//  DFrame
//
//  Created by DaiSuke on 16/9/13.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DMenuAlertViewDirectionType) {
    DMenuAlertViewDirectionTopRightType,
    DMenuAlertViewDirectionTopLeftType,
    DMenuAlertViewDirectionBotomRightType,
    DMenuAlertViewDirectionBotomLeftType
};


@class DMenuAlertView;
@protocol DMenuAlertViewDelegate <NSObject>

- (void)menuAlertView:(DMenuAlertView *)menuAlertView didSelectIndex:(NSInteger)index;

@end

@interface DMenuAlertView : UIControl

- (instancetype)initWithType:(DMenuAlertViewDirectionType)type;

@property (assign, nonatomic) DMenuAlertViewDirectionType type;
@property (strong, nonatomic) UIView *customView;

- (void)setTitleArrary:(NSArray *)titleArr viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight;
- (void)setLeftImageArrary:(NSArray *)leftImageArr rightTitleArrary:(NSArray *)rightTitleArr viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight;

- (void)show;
- (void)hide;

@property (weak, nonatomic) id<DMenuAlertViewDelegate> delegate;

@end
