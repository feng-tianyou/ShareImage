//
//  DMeTableViewCell.m
//  ShareImage
//
//  Created by FTY on 2017/3/10.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DMeTableViewCell.h"
#import "DPhotosModel.h"
#import "DCollectionsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


static NSString *const cellID = @"homeCell";

@interface DMeTableViewCell ()
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descriLabel;
@end

@implementation DMeTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DMeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.descriLabel];
    
    // layout
    self.photoView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(200);
    
    self.nameLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(30);
    
    self.descriLabel.sd_layout
    .topSpaceToView(self.nameLabel, 20)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(20);
    
    
}




#pragma mark - getter & setter
- (UIImageView *)photoView{
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.backgroundColor = [UIColor lightRandom];
    }
    return _photoView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:30.0];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)descriLabel{
    if (!_descriLabel) {
        _descriLabel = [[UILabel alloc] init];
        _descriLabel.textColor = [UIColor whiteColor];
        _descriLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:20.0];;
        _descriLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descriLabel;
}


- (void)setPhotosModel:(DPhotosModel *)photosModel{
    _photosModel = photosModel;
    
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:photosModel.urls.small] placeholderImage:[UIImage getImageWithName:@""]];
    
    DCollectionsModel *collectionModel = [photosModel.current_user_collections firstObject];
    self.nameLabel.text = collectionModel.title;
    
    self.descriLabel.text = collectionModel.c_description;
    
    // 设置最低端的距离
    [self setupAutoHeightWithBottomView:self.photoView bottomMargin:0];
    
}


@end
