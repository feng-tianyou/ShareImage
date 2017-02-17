//
//  DHomeTableViewCell.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DHomeTableViewCell.h"
#import "DPhotosModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const cellID = @"homeCell";

@interface DHomeTableViewCell ()

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UIView *iconBgView;
@property (nonatomic, strong) UIButton *iconView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation DHomeTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    [self.contentView addSubview:self.photoView];
    [self.contentView addSubview:self.iconBgView];
    [self.iconBgView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabel];
    
    // layout
    self.photoView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(200);
    
    self.iconBgView.sd_layout
    .topSpaceToView(self.photoView, -35)
    .leftSpaceToView(self.contentView, 20)
    .widthIs(70)
    .heightIs(70);
    
    self.iconView.sd_layout
    .centerXEqualToView(self.iconBgView)
    .centerYEqualToView(self.iconBgView)
    .widthIs(62)
    .heightIs(62);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.photoView, 2)
    .leftSpaceToView(self.iconBgView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(20);
}

- (void)clickIcon{
    ExistActionDo(self.clickIconBlock, self.clickIconBlock());
}



#pragma mark - getter & setter
- (UIImageView *)photoView{
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
    }
    return _photoView;
}

- (UIView *)iconBgView{
    if (!_iconBgView) {
        _iconBgView = [[UIView alloc] init];
        _iconBgView.backgroundColor = [UIColor whiteColor];
        [_iconBgView.layer setCornerRadius:35.0];
        [_iconBgView.layer setMasksToBounds:YES];
    }
    return _iconBgView;
}

- (UIButton *)iconView{
    if (!_iconView) {
        _iconView = [[UIButton alloc] init];
        [_iconView addTarget:self action:@selector(clickIcon) forControlEvents:UIControlEventTouchUpInside];
        [_iconView.layer setCornerRadius:31.0];
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

- (void)setPhotosModel:(DPhotosModel *)photosModel{
    _photosModel = photosModel;
    
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:photosModel.urls.small] placeholderImage:[UIImage getImageWithName:@""]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:photosModel.user.profile_image.medium] forState:UIControlStateNormal placeholderImage:[UIImage getImageWithName:@""]];
    self.nameLabel.text = photosModel.user.name;
    
    // 设置最低端的距离
    [self setupAutoHeightWithBottomView:_iconBgView bottomMargin:10];
}

@end
