//
//  DHomeTableViewCell.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DHomeTableViewCell.h"
#import "DPhotosModel.h"
#import "DHomeCellTipLabel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const cellID = @"homeCell";

@interface DHomeTableViewCell ()

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UIView *iconBgView;
@property (nonatomic, strong) UIButton *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) DHomeCellTipLabel *addressLabel;
@property (nonatomic, strong) DHomeCellTipLabel *timeLabel;
@property (nonatomic, strong) DHomeCellTipLabel *likeLabel;
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
    [self.photoView addSubview:self.likeLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.timeLabel];
    
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
    
    self.likeLabel.sd_layout
    .topSpaceToView(self.photoView, 10)
    .rightSpaceToView(self.photoView, 1)
    .widthIs(40)
    .heightIs(20);
    
    self.addressLabel.sd_layout
    .topSpaceToView(self.nameLabel, 0)
    .leftEqualToView(self.nameLabel)
    .rightSpaceToView(self.contentView,10)
    .heightIs(20);
    
//    self.timeLabel.sd_layout
//    .topSpaceToView(self.addressLabel, 0)
//    .leftEqualToView(self.nameLabel)
//    .rightSpaceToView(self.contentView,10)
//    .heightIs(20);
}

- (void)clickIcon{
    ExistActionDo(self.clickIconBlock, self.clickIconBlock());
}



#pragma mark - getter & setter
- (UIImageView *)photoView{
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.backgroundColor = [UIColor lightRandom];
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
        _iconView.backgroundColor = [UIColor lightRandom];
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = DSystemFontTitle;
    }
    return _nameLabel;
}

- (DHomeCellTipLabel *)likeLabel{
    if (!_likeLabel) {
        _likeLabel = [[DHomeCellTipLabel alloc] init];
        _likeLabel.iconName = @"common_btn_like_hight";
        _likeLabel.describeLabel.textColor = [UIColor whiteColor];
        
    }
    return _likeLabel;
}

- (DHomeCellTipLabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[DHomeCellTipLabel alloc] init];
        _addressLabel.iconName = @"common_btn_address_normal";
    }
    return _addressLabel;
}

//- (DHomeCellTipLabel *)timeLabel{
//    if (!_timeLabel) {
//        _timeLabel = [[DHomeCellTipLabel alloc] init];
//        _timeLabel.iconName = @"common_btn_time";
//    }
//    return _timeLabel;
//}

- (void)setPhotosModel:(DPhotosModel *)photosModel{
    _photosModel = photosModel;
    
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:photosModel.urls.small] placeholderImage:[UIImage getImageWithName:@""]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:photosModel.user.profile_image.medium] forState:UIControlStateNormal placeholderImage:[UIImage getImageWithName:@""]];
    self.nameLabel.text = photosModel.user.name;
    
    if (photosModel.likes > 0) {
        self.likeLabel.hidden = NO;
        self.likeLabel.describe = [NSString stringWithFormat:@"%@", @(photosModel.likes)];
    } else {
        self.likeLabel.hidden = YES;
    }
    
    if (photosModel.user.location.length > 0) {
        self.addressLabel.hidden = NO;
        self.addressLabel.describe = photosModel.user.location;
        // 设置最低端的距离
        [self setupAutoHeightWithBottomView:self.addressLabel bottomMargin:10];
    } else {
        self.addressLabel.hidden = YES;
        // 设置最低端的距离
        [self setupAutoHeightWithBottomView:self.iconBgView bottomMargin:10];
    }
    
}

@end
