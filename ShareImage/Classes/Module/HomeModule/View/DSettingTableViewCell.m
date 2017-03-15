//
//  DSettingTableViewCell.m
//  ShareImage
//
//  Created by FTY on 2017/3/14.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSettingTableViewCell.h"


static NSString *const cellID = @"DSettingTableViewCell";

@implementation DSettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}


#pragma mark - 私有方法
- (void)setupSubViews{
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.rightSwitch];
    [self.contentView addSubview:self.arrowView];
    [self.contentView addSubview:self.contentLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // layout
    CGSize titleSize = [_leftTitleLabel.text sizeWithFont:_leftTitleLabel.font maxWidth:self.width/2];
    self.leftTitleLabel.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 15)
    .bottomEqualToView(self.contentView)
    .widthIs(titleSize.width);
    
    CGSize imgSize = self.arrowView.image.size;
    self.arrowView.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(imgSize.width)
    .heightIs(imgSize.height);
    
    self.rightSwitch.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(30)
    .heightIs(50);
    
    self.contentLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.leftTitleLabel, 20)
    .heightIs(20);
}


- (void)setLeftTitle:(NSString *)leftTitle content:(NSString *)content indexPath:(NSIndexPath *)indexPath{
    self.leftTitleLabel.text = leftTitle;
    
    switch (indexPath.section) {
        case 0:
        {
            self.arrowView.hidden = NO;
            self.contentLabel.hidden = YES;
            self.rightSwitch.hidden = YES;
        }
            break;
        case 1:
        {
            self.arrowView.hidden = YES;
            self.contentLabel.hidden = YES;
            self.rightSwitch.hidden = NO;
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                self.arrowView.hidden = YES;
                self.contentLabel.hidden = NO;
                self.rightSwitch.hidden = YES;
                self.contentLabel.text = content;
            } else {
                self.arrowView.hidden = NO;
                self.contentLabel.hidden = YES;
                self.rightSwitch.hidden = YES;
            }
        }
            break;
            
        default:
            break;
    }
}



#pragma mark - getter & setter
- (UILabel *)leftTitleLabel{
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.textColor = DSystemColorBlack333333;
        _leftTitleLabel.font = DSystemFontTitle;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _leftTitleLabel;
}

- (UISwitch *)rightSwitch{
    if (!_rightSwitch) {
        _rightSwitch = [[UISwitch alloc] init];
        _rightSwitch.hidden = YES;
    }
    return _rightSwitch;
}

- (UIImageView *)arrowView{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] init];
        _arrowView.image = [UIImage getImageWithName:@"common_btn_arrow_right_gray"];
        _arrowView.hidden = YES;
    }
    return _arrowView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = DSystemColorBlackBBBBBB;
        _contentLabel.font = DSystemFontTitle;
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.hidden = YES;
    }
    return _contentLabel;
}

@end
