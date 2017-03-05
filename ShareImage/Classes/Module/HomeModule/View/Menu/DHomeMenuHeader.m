//
//  DHomeMenuHeader.m
//  ShareImage
//
//  Created by FTY on 2017/2/28.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DHomeMenuHeader.h"

@interface DHomeMenuHeader ()



@end

@implementation DHomeMenuHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.addressLabel];
    
    
    self.iconView.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(70)
    .heightIs(70);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.iconView, 10)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(20);
    
    self.addressLabel.sd_layout
    .topSpaceToView(self.nameLabel, 10)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(20);
    
    
}


#pragma mark - getter & setter
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor lightRandom];
        [_iconView.layer setCornerRadius:35.0];
        [_iconView.layer setMasksToBounds:YES];
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:14.0];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (DHomeCellTipLabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[DHomeCellTipLabel alloc] init];
        _addressLabel.iconName = @"common_btn_address_hight";
        _addressLabel.describeLabel.textColor = [UIColor whiteColor];
        _addressLabel.mode = HomeCellTipLabelCenter;
    }
    return _addressLabel;
}


@end
