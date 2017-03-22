//
//  DCommonPhotosCell.m
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCommonPhotosCell.h"

#import "DPhotosModel.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation DCommonPhotosCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightRandom];
        [self.contentView addSubview:self.iconView];
        
        self.iconView.sd_layout
        .topEqualToView(self.contentView)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .bottomEqualToView(self.contentView);
    }
    return self;
}

#pragma mark - setter & getter
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (void)setPhotoModel:(DPhotosModel *)photoModel{
    _photoModel = photoModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:photoModel.urls.thumb] placeholderImage:nil];
}

@end
