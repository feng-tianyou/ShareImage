//
//  DCustomAlertView.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/23.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCustomAlertViewDelegate <NSObject>

- (void)customAlertViewDidPressToAction;

@end

@interface DCustomAlertView : UIControl

@property (nonatomic, weak) id<DCustomAlertViewDelegate> delegate;

- (void)setImage:(UIImage *)img title:(NSString *)title content:(NSString *)content btnTitle:(NSString *)btnTitle;


@end
