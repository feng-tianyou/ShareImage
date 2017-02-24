//
//  DCollectionDetailsCell.m
//  ShareImage
//
//  Created by FTY on 2017/2/24.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionDetailsCell.h"
#import "DPhotosModel.h"
#import "DHomeCellTipLabel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>


static NSString *const cellID = @"homeCell";

@interface DCollectionDetailsCell ()
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UIButton *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *viewersLabel;
@property (nonatomic, strong) DHomeCellTipLabel *addressLabel;
@end

@implementation DCollectionDetailsCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DCollectionDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DCollectionDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    [self.photoView addSubview:self.iconView];
    [self.photoView addSubview:self.nameLabel];
    [self.photoView addSubview:self.viewersLabel];
    [self.photoView addSubview:self.addressLabel];
    
    // layout
    self.photoView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(180);
    
    self.iconView.sd_layout
    .bottomSpaceToView(self.photoView, 20)
    .leftSpaceToView(self.photoView, 20)
    .widthIs(50)
    .heightIs(50);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.iconView,-40)
    .leftSpaceToView(self.iconView, 10)
    .rightSpaceToView(self.photoView, 10)
    .heightIs(20);
    
    self.addressLabel.sd_layout
    .topSpaceToView(self.nameLabel, 2)
    .leftSpaceToView(self.iconView, 10)
    .rightSpaceToView(self.photoView, 10)
    .heightIs(20);
    
    self.viewersLabel.sd_layout
    .topSpaceToView(self.photoView, 20)
    .leftSpaceToView(self.photoView,10)
    .rightSpaceToView(self.photoView,10)
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

- (UIButton *)iconView{
    if (!_iconView) {
        _iconView = [[UIButton alloc] init];
        [_iconView addTarget:self action:@selector(clickIcon) forControlEvents:UIControlEventTouchUpInside];
        [_iconView.layer setCornerRadius:25.0];
        [_iconView.layer setMasksToBounds:YES];
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = DSystemFontTitle;
    }
    return _nameLabel;
}

- (UILabel *)viewersLabel{
    if (!_viewersLabel) {
        _viewersLabel = [[UILabel alloc] init];
        _viewersLabel.textColor = [UIColor whiteColor];
        _viewersLabel.font = DSystemFontContent;
        _viewersLabel.textAlignment = NSTextAlignmentRight;
    }
    return _viewersLabel;
}

- (DHomeCellTipLabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[DHomeCellTipLabel alloc] init];
        _addressLabel.iconName = @"common_btn_address_hight";
        _addressLabel.describeLabel.textColor = [UIColor whiteColor];
    }
    return _addressLabel;
}

- (void)setPhotosModel:(DPhotosModel *)photosModel{
    _photosModel = photosModel;
    
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:photosModel.urls.small] placeholderImage:[UIImage getImageWithName:@""]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:photosModel.user.profile_image.medium] forState:UIControlStateNormal placeholderImage:[UIImage getImageWithName:@""]];
    
    self.nameLabel.text = photosModel.user.name;
    if (photosModel.views > 0) {
        self.viewersLabel.hidden = NO;
        self.viewersLabel.text = [NSString stringWithFormat:@"%@ views", @(photosModel.views)];
    } else {
        self.viewersLabel.hidden = YES;
    }

    if (photosModel.user.location.length > 0) {
        self.addressLabel.hidden = NO;
        self.addressLabel.describe = photosModel.user.location;
    } else {
        self.addressLabel.hidden = YES;
    }

    
    // 设置最低端的距离
    [self setupAutoHeightWithBottomView:self.photoView bottomMargin:0];
    
}


@end
