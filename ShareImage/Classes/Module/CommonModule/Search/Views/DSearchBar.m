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
        [self.bgView addSubview:self.searchTextField];
        [self.bgView addSubview:self.searchIcon];
        [self.bgView addSubview:self.clearButton];
        
        self.bgView.sd_layout
        .centerYEqualToView(self)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(30);
        
        self.searchIcon.sd_layout
        .centerYEqualToView(self.bgView)
        .leftSpaceToView(self.bgView, 20)
        .widthIs(18)
        .heightIs(18);
        
        
        self.searchTextField.sd_layout
        .centerYEqualToView(self.bgView)
        .leftSpaceToView(self.searchIcon, 10)
        .rightSpaceToView(self.bgView, 40)
        .heightIs(30);
        
        
        self.clearButton.sd_layout
        .centerYEqualToView(self.bgView)
        .leftSpaceToView(self.searchTextField, 10)
        .widthIs(13)
        .heightIs(13);

    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
}

#pragma mark - getter & setter
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:15.0];
        [_bgView.layer setMasksToBounds:YES];
    }
    return _bgView;
}

- (UIImageView *)searchIcon{
    if (!_searchIcon) {
        _searchIcon = [[UIImageView alloc] init];
        _searchIcon.image = [UIImage getImageWithName:@"tabar_discover"];
    }
    return _searchIcon;
}

- (UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [[DTextField alloc] init];
        _searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    return _searchTextField;
}

- (UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [[UIButton alloc] init];
        [_clearButton setImage:[UIImage getImageWithName:@"navigationbar_btn_close_gray"] forState:UIControlStateNormal];
        [_clearButton setImage:[UIImage getImageWithName:@"navigationbar_btn_close_gray"] forState:UIControlStateHighlighted];
    }
    return _clearButton;
}

@end
