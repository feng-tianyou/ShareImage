//
//  DHomeCellTipLabel.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHomeCellTipLabel : UIView

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *describe;

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *describeLabel;

@end
