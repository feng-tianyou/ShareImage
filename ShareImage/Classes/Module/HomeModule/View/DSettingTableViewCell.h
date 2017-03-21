//
//  DSettingTableViewCell.h
//  ShareImage
//
//  Created by FTY on 2017/3/14.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSettingTableViewCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UISwitch *rightSwitch;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UILabel *contentLabel;

- (void)setLeftTitle:(NSString *)leftTitle indexPath:(NSIndexPath *)indexPath;

@end
