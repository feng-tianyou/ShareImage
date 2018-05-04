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
@property (nonatomic, assign) SearchType searchType;
@property (nonatomic, strong) UILabel *maskLabel;

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
        [self.contentView addSubview:self.bioLabel];
        [self.contentView addSubview:self.maskLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat bioH = [@"哈哈" sizeWithFont:self.bioLabel.font].height;
    CGFloat nameH = [@"哈哈" sizeWithFont:self.nameLabel.font].height;
    switch (_searchType) {
        case PhotoSearchType:
        {
            self.bioLabel.sd_layout
            .leftSpaceToView(self.contentView, 15)
            .rightSpaceToView(self.contentView, 10)
            .bottomSpaceToView(self.contentView, 10)
            .heightIs(bioH);
            
            self.photoView.sd_layout
            .topEqualToView(self.contentView)
            .leftEqualToView(self.contentView)
            .rightEqualToView(self.contentView)
            .bottomSpaceToView(self.contentView, 1);
        }
            break;
        case UserSearchType:
        {
            self.iconView.sd_layout
            .centerYEqualToView(self.contentView)
            .leftSpaceToView(self.contentView, 15)
            .widthIs(34)
            .heightIs(34);
            
            self.nameLabel.sd_layout
            .topSpaceToView(self.contentView, 6)
            .leftSpaceToView(self.iconView, 15)
            .rightSpaceToView(self.contentView, 10)
            .heightIs(nameH);
            
            self.bioLabel.sd_layout
            .topSpaceToView(self.nameLabel, 2)
            .leftSpaceToView(self.iconView, 15)
            .rightSpaceToView(self.contentView, 10)
            .heightIs(bioH);
        }
            break;
        case CollectionSearchType:
        {
            self.iconView.sd_layout
            .centerYEqualToView(self.contentView)
            .leftSpaceToView(self.contentView, 15)
            .widthIs(34)
            .heightIs(34);
            
            self.nameLabel.sd_layout
            .centerYEqualToView(self.contentView)
            .leftSpaceToView(self.iconView, 15)
            .rightSpaceToView(self.contentView, 10)
            .heightIs(nameH);
            
            self.maskLabel.sd_layout
            .centerYEqualToView(self.contentView)
            .leftSpaceToView(self.contentView, 15)
            .widthIs(34)
            .heightIs(34);
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - setter & getter
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor lightRandom];
        [_iconView.layer setCornerRadius:17.0];
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
        _nameLabel.font = DSystemFontTitle;
    }
    return _nameLabel;
}

- (UILabel *)bioLabel{
    if (!_bioLabel) {
        _bioLabel = [[UILabel alloc] init];
        _bioLabel.textColor = DSystemColorGray999999;
        _bioLabel.font = DSystemFontDate;
    }
    return _bioLabel;
}

- (UILabel *)maskLabel{
    if (!_maskLabel) {
        _maskLabel = [[UILabel alloc] init];
        _maskLabel.textColor = DSystemColorWhite;
        _maskLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _maskLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
        [_maskLabel.layer setCornerRadius:17.0];
        _maskLabel.clipsToBounds = YES;
        _maskLabel.text = @"#";
        _maskLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _maskLabel;
}

- (void)setPhotoModel:(DPhotosModel *)photoModel{
    _photoModel = photoModel;
    _searchType = PhotoSearchType;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:photoModel.urls.small] placeholderImage:nil];
    self.bioLabel.textColor = DSystemColorWhite;
    self.bioLabel.font = DSystemFontTitle;
    self.bioLabel.text = photoModel.user.name;
}


- (void)setUserModel:(DUserModel *)userModel{
    _userModel = userModel;
    _searchType = UserSearchType;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image.medium] placeholderImage:nil];
    self.nameLabel.font = DSystemFontTitle;
    self.nameLabel.text = userModel.username;
    self.bioLabel.textColor = DSystemColorGray999999;
    self.bioLabel.font = DSystemFontDate;
    self.bioLabel.text = userModel.bio;
}

- (void)setCollectionModel:(DCollectionsModel *)collectionModel{
    _collectionModel = collectionModel;
    _searchType = CollectionSearchType;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:collectionModel.cover_photo.urls.small] placeholderImage:nil];
    self.nameLabel.font = DSystemFontNavigationBar;
    self.nameLabel.text = [NSString stringWithFormat:@"# %@", collectionModel.title];
}



@end
