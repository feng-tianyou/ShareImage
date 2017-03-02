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
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.photoBtn];
        [self addSubview:self.userBtn];
        [self addSubview:self.collectionBtn];
        
        self.photoBtn.sd_layout
        .topEqualToView(self)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(40);
        
        self.userBtn.sd_layout
        .topSpaceToView(self.photoBtn, 0)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(40);
        
        self.collectionBtn.sd_layout
        .topSpaceToView(self.userBtn, 0)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(40);
    }
    return self;
}


#pragma mark - getter & setter
- (UIButton *)photoBtn{
    if (!_photoBtn) {
        _photoBtn = [[UIButton alloc] init];
        _photoBtn.backgroundColor = [UIColor whiteColor];
//        [_photoBtn.layer setCornerRadius:40.0];
//        [_photoBtn.layer setMasksToBounds:YES];
        [_photoBtn setTitle:@"PHOTOS" forState:UIControlStateNormal];
    }
    return _photoBtn;
}

- (UIButton *)userBtn{
    if (!_userBtn) {
        _userBtn = [[UIButton alloc] init];
        _userBtn.backgroundColor = [UIColor whiteColor];
//        [_userBtn.layer setCornerRadius:40.0];
//        [_userBtn.layer setMasksToBounds:YES];
        [_userBtn setTitle:@"USERS" forState:UIControlStateNormal];
    }
    return _userBtn;
}

- (UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn = [[UIButton alloc] init];
        _collectionBtn.backgroundColor = [UIColor whiteColor];
//        [_collectionBtn.layer setCornerRadius:40.0];
//        [_collectionBtn.layer setMasksToBounds:YES];
        [_collectionBtn setTitle:@"COLLECTIONS" forState:UIControlStateNormal];
    }
    return _collectionBtn;
}

@end
