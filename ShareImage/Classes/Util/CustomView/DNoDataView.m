//
//  DNoDataView.m
//  ShareImage
//
//  Created by FTY on 2017/3/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DNoDataView.h"

@implementation DNoDataView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.cricleView2];
    [self.cricleView2 addSubview:self.cricleView1];
    [self.cricleView1 addSubview:self.iconView];
    [self addSubview:self.refreshButton];
    
    self.titleLabel.sd_layout
    .topSpaceToView(self, 30)
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .autoHeightRatio(0);
    
    self.cricleView2.sd_layout
    .topSpaceToView(self.titleLabel, 30)
    .centerXEqualToView(self)
    .widthIs(230)
    .heightIs(230);
    
    self.cricleView1.sd_layout
    .centerYEqualToView(self.cricleView2)
    .centerXEqualToView(self.cricleView2)
    .widthIs(190)
    .heightIs(190);
    
    self.iconView.sd_layout
    .centerYEqualToView(self.cricleView1)
    .centerXEqualToView(self.cricleView1)
    .widthIs(150)
    .heightIs(150);
    
    
    self.refreshButton.sd_layout
    .topSpaceToView(self.cricleView2, 30)
    .leftSpaceToView(self, 80)
    .rightSpaceToView(self, 80)
    .heightIs(50);
    
}

#pragma mark - getter & setter
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:22.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage getImageWithName:@"common_no_data_image"];
    }
    return _iconView;
}

- (UIView *)cricleView1{
    if (!_cricleView1) {
        _cricleView1 = [[UIView alloc] init];
        _cricleView1.backgroundColor = [UIColor setHexColor:@"#abe6e9"];
        [_cricleView1.layer setCornerRadius:95.0];
        [_cricleView1.layer setMasksToBounds:YES];
    }
    return _cricleView1;
}

- (UIView *)cricleView2{
    if (!_cricleView2) {
        _cricleView2 = [[UIView alloc] init];
        _cricleView2.backgroundColor = [UIColor setHexColor:@"#d1f1f3"];
        [_cricleView2.layer setCornerRadius:115.0];
        [_cricleView2.layer setMasksToBounds:YES];
    }
    return _cricleView2;
}

- (UIButton *)refreshButton{
    if (!_refreshButton) {
        _refreshButton = [[UIButton alloc] init];
        _refreshButton.backgroundColor = [UIColor setHexColor:@"#2979ff"];
        [_refreshButton setTitle:@"Refresh" forState:UIControlStateNormal];
        [_refreshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_refreshButton.layer setCornerRadius:25.0];
        [_refreshButton.layer setMasksToBounds:YES];
    }
    return _refreshButton;
}

@end
