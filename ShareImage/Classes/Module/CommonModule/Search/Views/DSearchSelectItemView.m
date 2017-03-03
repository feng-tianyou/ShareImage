//
//  DSearchSelectItemView.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/1.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchSelectItemView.h"

@implementation DSearchSelectItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];

        [self addSubview:self.contentView];
        [self.contentView addSubview:self.photoBtn];
        [self.contentView addSubview:self.userBtn];
        [self.contentView addSubview:self.collectionBtn];
        
        self.photoBtn.sd_layout
        .topEqualToView(self.contentView)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(40);
        
        self.userBtn.sd_layout
        .topSpaceToView(self.photoBtn, 0)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(40);
        
        self.collectionBtn.sd_layout
        .topSpaceToView(self.userBtn, 0)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(40);
        
        self.contentView.sd_layout
        .topSpaceToView(self, 0)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(120);
    }
    return self;
}


#pragma mark - getter & setter
- (UIButton *)photoBtn{
    if (!_photoBtn) {
        _photoBtn = [[UIButton alloc] init];
        _photoBtn.backgroundColor = [UIColor whiteColor];
        [_photoBtn setTitle:@"PHOTOS" forState:UIControlStateNormal];
        [_photoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _photoBtn;
}

- (UIButton *)userBtn{
    if (!_userBtn) {
        _userBtn = [[UIButton alloc] init];
        _userBtn.backgroundColor = [UIColor whiteColor];
        [_userBtn setTitle:@"USERS" forState:UIControlStateNormal];
        [_userBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _userBtn;
}

- (UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn = [[UIButton alloc] init];
        _collectionBtn.backgroundColor = [UIColor whiteColor];
        [_collectionBtn setTitle:@"COLLECTIONS" forState:UIControlStateNormal];
        [_collectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _collectionBtn;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIControl alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}


- (void)show{
    [self setHidden:NO];
    @weakify(self)
    [UIView animateWithDuration:0.4 animations:^{
        @strongify(self)
        [self setAlpha:1.0];
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide{
    @weakify(self)
    [UIView animateWithDuration:0.4 animations:^{
        @strongify(self)
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
    }];
}

@end
