//
//  DSearchBar.h
//  ShareImage
//
//  Created by FTY on 2017/3/2.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTextField.h"

@interface DSearchBar : UIView

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *searchIcon;
@property (nonatomic, strong) DTextField *searchTextField;
@property (nonatomic, strong) UIButton *clearButton;

@end
