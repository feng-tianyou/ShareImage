//
//  DCollectionViewCell.m
//  ShareImage
//
//  Created by FTY on 2017/2/23.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionViewCell.h"
#import "DCollectionsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DCollectionViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *describleLabel;

@end

@implementation DCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.describleLabel];
        
        self.iconView.sd_layout
        .topEqualToView(self.contentView)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .bottomEqualToView(self.contentView);
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, 50)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(30);
        
        self.describleLabel.sd_layout
        .topSpaceToView(self.titleLabel, 10)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(20);
        
    }
    return self;
}

#pragma mark - setter & getter
- (void)setCollection:(DCollectionsModel *)collection{
    _collection = collection;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:collection.cover_photo.urls.regular] placeholderImage:nil];
    self.titleLabel.text = [collection.title uppercaseString];
    self.describleLabel.text = [NSString stringWithFormat:@"%@ photos", @(collection.total_photos)];
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:21.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)describleLabel{
    if (!_describleLabel) {
        _describleLabel = [[UILabel alloc] init];
        _describleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:15.0];
        _describleLabel.textColor = [UIColor whiteColor];
        _describleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _describleLabel;
}

@end
