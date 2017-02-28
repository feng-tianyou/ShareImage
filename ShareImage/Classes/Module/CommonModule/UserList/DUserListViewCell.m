//
//  DUserListViewCell.m
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DUserListViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const cellID = @"UserListCell";

@interface DUserListViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation DUserListViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DUserListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DUserListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        
        self.iconView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 10)
        .widthIs(40)
        .heightIs(40);
        
        self.nameLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.iconView, 15)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(20);
        
    }
    return self;
}


#pragma mark - setter & getter
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        [_iconView.layer setCornerRadius:20.0];
        [_iconView.layer setMasksToBounds:YES];
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = DSystemFontText;
    }
    return _nameLabel;
}

- (void)setUserModel:(DUserModel *)userModel{
    _userModel = userModel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image.medium] placeholderImage:nil];
    self.nameLabel.text = userModel.username;
}

@end