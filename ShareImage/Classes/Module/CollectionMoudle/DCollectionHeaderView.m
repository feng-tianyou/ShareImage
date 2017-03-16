//
//  DCollectionHeaderView.m
//  ShareImage
//
//  Created by FTY on 2017/3/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionHeaderView.h"

@implementation DCollectionHeaderView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        [self addSubview:self.featuredBtn];
        [self addSubview:self.curatedBtn];
        
        CGFloat width = SCREEN_WIDTH/2;
        self.featuredBtn.sd_layout
        .topEqualToView(self)
        .leftEqualToView(self)
        .bottomEqualToView(self)
        .widthIs(width);
        
        self.curatedBtn.sd_layout
        .topEqualToView(self)
        .leftSpaceToView(self.featuredBtn, 0)
        .bottomEqualToView(self)
        .widthIs(width);
    }
    return self;
}


#pragma mark - getter & setter
- (UIButton *)featuredBtn{
    if (!_featuredBtn) {
        _featuredBtn = [[UIButton alloc] init];
        _featuredBtn.backgroundColor = [UIColor clearColor];
        [_featuredBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_featuredBtn setTitle:@"Featured" forState:UIControlStateNormal];
        _featuredBtn.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:15.0];
        [_featuredBtn setTitleColor:DSystemColorBlue33AACC forState:UIControlStateSelected];
    }
    return _featuredBtn;
}


- (UIButton *)curatedBtn{
    if (!_curatedBtn) {
        _curatedBtn = [[UIButton alloc] init];
        _curatedBtn.backgroundColor = [UIColor clearColor];
        [_curatedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_curatedBtn setTitle:@"Curated" forState:UIControlStateNormal];
        _curatedBtn.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:15.0];
        [_curatedBtn setTitleColor:DSystemColorBlue33AACC forState:UIControlStateSelected];
    }
    return _curatedBtn;
}

@end
