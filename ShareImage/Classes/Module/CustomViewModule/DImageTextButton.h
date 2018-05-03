//
//  DImageTextButton.h
//  DFrame
//
//  Created by DaiSuke on 16/9/13.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DImageTextButton : UIControl

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *lblTitle;

@property (assign, nonatomic) CGSize imgSize;

@property (assign, nonatomic) CGRect imgFrame;

@property (assign, nonatomic) BOOL imgIsAtRight;

@property (assign, nonatomic) BOOL nullImg;

- (void)reloadLayoutSubviews;

@end
