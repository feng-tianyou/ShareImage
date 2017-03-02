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
        
        
        CGFloat margin = (SCREEN_WIDTH - 80 * 3) / 4;
        self.photoBtn.sd_layout
        .topSpaceToView(self, 20)
        .leftSpaceToView(self,margin)
        .widthIs(80)
        .heightIs(80);
        
        self.userBtn.sd_layout
        .topSpaceToView(self, 20)
        .leftSpaceToView(self.photoBtn, margin)
        .widthIs(80)
        .heightIs(80);
        
        self.collectionBtn.sd_layout
        .topSpaceToView(self, 20)
        .leftSpaceToView(self.userBtn, margin)
        .widthIs(80)
        .heightIs(80);
    }
    return self;
}


#pragma mark - getter & setter
- (UIButton *)photoBtn{
    if (!_photoBtn) {
        _photoBtn = [[UIButton alloc] init];
        _photoBtn.backgroundColor = [UIColor lightRandom];
        [_photoBtn.layer setCornerRadius:40.0];
        [_photoBtn.layer setMasksToBounds:YES];
        [_photoBtn setTitle:@"PHOTOS" forState:UIControlStateNormal];
    }
    return _photoBtn;
}

- (UIButton *)userBtn{
    if (!_userBtn) {
        _userBtn = [[UIButton alloc] init];
        _userBtn.backgroundColor = [UIColor lightRandom];
        [_userBtn.layer setCornerRadius:40.0];
        [_userBtn.layer setMasksToBounds:YES];
        [_userBtn setTitle:@"USERS" forState:UIControlStateNormal];
    }
    return _userBtn;
}

- (UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn = [[UIButton alloc] init];
        _collectionBtn.backgroundColor = [UIColor lightRandom];
        [_collectionBtn.layer setCornerRadius:40.0];
        [_collectionBtn.layer setMasksToBounds:YES];
        [_collectionBtn setTitle:@"COLLECTIONS" forState:UIControlStateNormal];
    }
    return _collectionBtn;
}

@end
