//
//  DSearchBar.m
//  ShareImage
//
//  Created by FTY on 2017/3/2.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchBar.h"

@implementation DSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.searchIcon];
        [self.bgView addSubview:self.searchTextField];
        [self.bgView addSubview:self.clearButton];
        
        self.bgView.sd_layout
        .centerYEqualToView(self)
        .leftSpaceToView(self, 10)
        .rightSpaceToView(self, 10)
        .heightIs(40);
        
        self.searchIcon.sd_layout
        .centerYEqualToView(self.bgView)
        .leftSpaceToView(self.bgView, 20)
        .widthIs(18)
        .heightIs(18);
        
        
        self.searchTextField.sd_layout
        .centerYEqualToView(self.bgView)
        .leftSpaceToView(self.searchIcon, 10)
        .rightSpaceToView(self.bgView, 40)
        .heightIs(40);
        
        
        self.clearButton.sd_layout
        .centerYEqualToView(self.bgView)
        .leftSpaceToView(self.searchTextField, 10)
        .widthIs(15)
        .heightIs(15);
        
        
    }
    return self;
}

#pragma mark - getter & setter
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor setHexColor:@"#232627"];
        [_bgView.layer setCornerRadius:20.0];
        [_bgView.layer setMasksToBounds:YES];
    }
    return _bgView;
}

- (UIImageView *)searchIcon{
    if (!_searchIcon) {
        _searchIcon = [[UIImageView alloc] init];
        _searchIcon.image = [UIImage getImageWithName:@"navigationbar_btn_write_search"];
    }
    return _searchIcon;
}

- (UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
    }
    return _searchTextField;
}

- (UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [[UIButton alloc] init];
        [_clearButton setImage:[UIImage getImageWithName:@"navigationbar_btn_write_close"] forState:UIControlStateNormal];
        [_clearButton setImage:[UIImage getImageWithName:@"navigationbar_btn_write_close"] forState:UIControlStateHighlighted];
    }
    return _clearButton;
}

@end
