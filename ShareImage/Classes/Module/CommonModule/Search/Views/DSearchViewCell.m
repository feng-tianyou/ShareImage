//
//  DSearchViewCell.m
//  ShareImage
//
//  Created by FTY on 2017/3/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchViewCell.h"
#import "DPhotosModel.h"
#import "DCollectionsModel.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const cellID = @"UserListCell";

@interface DSearchViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *bioLabel;

@end

@implementation DSearchViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DSearchViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.photoView];
        
        self.iconView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 20)
        .widthIs(40)
        .heightIs(40);
        
        self.nameLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.iconView, 15)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(20);
        
        self.photoView.sd_layout
        .topEqualToView(self.contentView)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(170);
        
    }
    return self;
}


#pragma mark - setter & getter
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor lightRandom];
        [_iconView.layer setCornerRadius:20.0];
        [_iconView.layer setMasksToBounds:YES];
    }
    return _iconView;
}

- (UIImageView *)photoView{
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.backgroundColor = [UIColor lightRandom];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
    }
    return _photoView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = DSystemFontNavigationBar;
    }
    return _nameLabel;
}


- (void)setUserModel:(DUserModel *)userModel{
    _userModel = userModel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image.medium] placeholderImage:nil];
    self.nameLabel.text = userModel.username;
}

- (void)setPhotoModel:(DPhotosModel *)photoModel{
    _photoModel = photoModel;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:photoModel.urls.small] placeholderImage:nil];
}

- (void)setCollectionModel:(DCollectionsModel *)collectionModel{
    _collectionModel = collectionModel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:collectionModel.cover_photo.urls.small] placeholderImage:nil];
    self.nameLabel.text = collectionModel.title;
}

- (void)setSearchType:(SearchType)searchType{
    _searchType = searchType;
    if (searchType == PhotoSearchType) {
        self.iconView.hidden = YES;
        self.nameLabel.hidden = YES;
        self.photoView.hidden = NO;
    } else {
        self.iconView.hidden = NO;
        self.nameLabel.hidden = NO;
        self.photoView.hidden = YES;
    }
}

@end
