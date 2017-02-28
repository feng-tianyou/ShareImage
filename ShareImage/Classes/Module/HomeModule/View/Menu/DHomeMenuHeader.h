//
//  DHomeMenuHeader.h
//  ShareImage
//
//  Created by FTY on 2017/2/28.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHomeCellTipLabel.h"

@interface DHomeMenuHeader : UIControl

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) DHomeCellTipLabel *addressLabel;

@end
