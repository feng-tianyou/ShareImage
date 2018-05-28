//
//  DUserListViewCell.m
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DUserListViewCell.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+DImage.h"

static NSString *const cellID = @"UserListCell";

@interface DUserListViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *bioLabel;

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
        [self.contentView addSubview:self.bioLabel];
        
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconView.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightIs(40);
    
    CGSize bioSize = [self.bioLabel.text sizeWithFont:self.bioLabel.font maxWidth:self.width*0.5];
    self.bioLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(bioSize.width)
    .heightIs(20);
    
    self.nameLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.iconView, 15)
    .rightSpaceToView(self.bioLabel, 10)
    .heightIs(20);
    
    
}


#pragma mark - setter & getter
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
//        [_iconView.layer setCornerRadius:20.0];
//        [_iconView.layer setMasksToBounds:YES];
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = DSystemFontNavigationBar;
    }
    return _nameLabel;
}

- (UILabel *)bioLabel{
    if (!_bioLabel) {
        _bioLabel = [[UILabel alloc] init];
        _bioLabel.textColor = DSystemColorGray;
        _bioLabel.font = DSystemFontText;
    }
    return _bioLabel;
}


- (void)setUserModel:(DUserModel *)userModel{
    _userModel = userModel;
    [self.iconView setImageWithURL:userModel.profile_image.medium cornerRadius:20 callBack:nil];
    self.nameLabel.text = userModel.username;
    self.bioLabel.text = userModel.bio;
}

@end
