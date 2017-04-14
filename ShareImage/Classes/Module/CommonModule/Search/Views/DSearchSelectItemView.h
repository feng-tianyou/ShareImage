//
//  DSearchSelectItemView.h
//  ShareImage
//
//  Created by DaiSuke on 2017/3/1.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSearchSelectItemView : UIControl

@property (nonatomic, strong) UIButton *photoBtn;
@property (nonatomic, strong) UIButton *userBtn;
@property (nonatomic, strong) UIButton *collectionBtn;

- (void)didCilckButton:(UIButton *)button;

@end
