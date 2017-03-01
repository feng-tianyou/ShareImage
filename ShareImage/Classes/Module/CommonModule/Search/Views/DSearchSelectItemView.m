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
        
        
        CGFloat btnW = SCREEN_WIDTH/3;
        self.photoBtn.sd_layout
        .topSpaceToView(self, 20)
        .leftEqualToView(self)
        .widthIs(btnW)
        .heightIs(80);
        
        self.userBtn.sd_layout
        .topSpaceToView(self, 20)
        .leftSpaceToView(self.photoBtn, 0)
        .widthIs(btnW)
        .heightIs(80);
        
        self.collectionBtn.sd_layout
        .topSpaceToView(self, 20)
        .leftSpaceToView(self.userBtn, 0)
        .widthIs(btnW)
        .heightIs(80);
    }
    return self;
}


#pragma mark - getter & setter
- (UIButton *)photoBtn{
    if (!_photoBtn) {
        _photoBtn = [[UIButton alloc] init];
        _photoBtn.backgroundColor = [UIColor redColor];
    }
    return _photoBtn;
}

- (UIButton *)userBtn{
    if (!_userBtn) {
        _userBtn = [[UIButton alloc] init];
        _userBtn.backgroundColor = [UIColor greenColor];
    }
    return _userBtn;
}

- (UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn = [[UIButton alloc] init];
        _collectionBtn.backgroundColor = [UIColor redColor];
    }
    return _collectionBtn;
}

@end
