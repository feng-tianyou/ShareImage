//
//  DCollectionHeaderView.m
//  ShareImage
//
//  Created by FTY on 2017/3/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionHeaderView.h"

@interface DCollectionHeaderView()
@property (nonatomic, strong) UIButton *featuredBtn;
@property (nonatomic, strong) UIButton *curatedBtn;
@property (nonatomic, strong) UILabel *lineView;
@end

@implementation DCollectionHeaderView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        [self addSubview:self.featuredBtn];
        [self addSubview:self.curatedBtn];
        [self addSubview:self.lineView];
        
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
        
        self.lineView.sd_layout
        .topEqualToView(self.featuredBtn)
        .centerXEqualToView(self.featuredBtn)
        .bottomSpaceToView(self, 10)
        .widthIs(40)
        .heightIs(1);
    }
    return self;
}

#pragma mark - event
- (void)clickFeatureBtn:(UIButton *)btn{
    _featuredBtn.selected = YES;
    _curatedBtn.selected = NO;
    self.lineView.sd_resetLayout
    .topEqualToView(self.featuredBtn)
    .centerXEqualToView(self.featuredBtn)
    .bottomSpaceToView(self, 10)
    .widthIs(40)
    .heightIs(1);
    ExistActionDo(self.clickItemBlock, self.clickItemBlock(0));
}

- (void)clickCuratedBtn:(UIButton *)btn{
    _featuredBtn.selected = NO;
    _curatedBtn.selected = YES;
    self.lineView.sd_resetLayout
    .topEqualToView(self.curatedBtn)
    .centerXEqualToView(self.curatedBtn)
    .bottomSpaceToView(self, 10)
    .widthIs(40)
    .heightIs(1);
    ExistActionDo(self.clickItemBlock, self.clickItemBlock(1));
}

#pragma mark - getter & setter
- (UIButton *)featuredBtn{
    if (!_featuredBtn) {
        _featuredBtn = [[UIButton alloc] init];
        _featuredBtn.backgroundColor = [UIColor clearColor];
        [_featuredBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_featuredBtn setTitle:kLocalizedLanguage(@"colFeatured") forState:UIControlStateNormal];
        _featuredBtn.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:15.0];
        [_featuredBtn setTitleColor:DSystemColorBlue33AACC forState:UIControlStateSelected];
        [_featuredBtn addTarget:self action:@selector(clickFeatureBtn:) forControlEvents:UIControlEventTouchUpInside];
        _featuredBtn.selected = YES;
    }
    return _featuredBtn;
}


- (UIButton *)curatedBtn{
    if (!_curatedBtn) {
        _curatedBtn = [[UIButton alloc] init];
        _curatedBtn.backgroundColor = [UIColor clearColor];
        [_curatedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_curatedBtn setTitle:kLocalizedLanguage(@"colCurated") forState:UIControlStateNormal];
        _curatedBtn.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:15.0];
        [_curatedBtn setTitleColor:DSystemColorBlue33AACC forState:UIControlStateSelected];
        [_curatedBtn addTarget:self action:@selector(clickCuratedBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _curatedBtn;
}

- (UILabel *)lineView{
    if (!_lineView) {
        _lineView = [[UILabel alloc] init];
        _lineView.backgroundColor = DSystemColorBlue33AACC;
    }
    return _lineView;
}

@end
