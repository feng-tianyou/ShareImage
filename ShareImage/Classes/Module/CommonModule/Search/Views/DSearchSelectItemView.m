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
        
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.photoBtn];
        [self addSubview:self.userBtn];
        [self addSubview:self.collectionBtn];
        [self addSubview:self.bottomLine];
        
        CGFloat width = SCREEN_WIDTH/3;
        self.photoBtn.sd_layout
        .topEqualToView(self)
        .leftSpaceToView(self, 0)
        .widthIs(width - 10)
        .bottomEqualToView(self);
        
        self.userBtn.sd_layout
        .topEqualToView(self)
        .leftSpaceToView(self.photoBtn, 0)
        .widthIs(width - 10)
        .bottomEqualToView(self);
        
        self.collectionBtn.sd_layout
        .topEqualToView(self)
        .leftSpaceToView(self.userBtn, 0)
        .widthIs(width + 20)
        .bottomEqualToView(self);
        
        self.bottomLine.sd_layout
        .bottomSpaceToView(self, -1)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(0.5);
    }
    return self;
}

- (void)didCilckButton:(UIButton *)button{
    switch (button.tag) {
        case 1:
        {
            self.photoBtn.selected = !button.isSelected;
            self.userBtn.selected = NO;
            self.collectionBtn.selected = NO;
        }
            break;
        case 2:
        {
            self.photoBtn.selected = NO;
            self.userBtn.selected = !button.isSelected;
            self.collectionBtn.selected = NO;
        }
            break;
        case 3:
        {
            self.photoBtn.selected = NO;
            self.userBtn.selected = NO;
            self.collectionBtn.selected = !button.isSelected;
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - getter & setter
- (UIButton *)photoBtn{
    if (!_photoBtn) {
        _photoBtn = [[UIButton alloc] init];
        _photoBtn.backgroundColor = [UIColor clearColor];
        [_photoBtn setTitle:@"PHOTOS" forState:UIControlStateNormal];
        [_photoBtn setTitleColor:DSystemColorBlackBBBBBB forState:UIControlStateNormal];
        [_photoBtn setTitleColor:[UIColor setHexColor:@"#2979ff"] forState:UIControlStateSelected];
        _photoBtn.tag = 1;
        _photoBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    }
    return _photoBtn;
}

- (UIButton *)userBtn{
    if (!_userBtn) {
        _userBtn = [[UIButton alloc] init];
        _userBtn.backgroundColor = [UIColor clearColor];
        [_userBtn setTitle:@"USERS" forState:UIControlStateNormal];
        [_userBtn setTitleColor:DSystemColorBlackBBBBBB forState:UIControlStateNormal];
        [_userBtn setTitleColor:[UIColor setHexColor:@"#2979ff"] forState:UIControlStateSelected];
        _userBtn.tag = 2;
    }
    return _userBtn;
}

- (UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn = [[UIButton alloc] init];
        _collectionBtn.backgroundColor = [UIColor clearColor];
        [_collectionBtn setTitle:@"COLLECTIONS" forState:UIControlStateNormal];
        [_collectionBtn setTitleColor:DSystemColorBlackBBBBBB forState:UIControlStateNormal];
        [_collectionBtn setTitleColor:[UIColor setHexColor:@"#2979ff"] forState:UIControlStateSelected];
        _collectionBtn.tag = 3;
    }
    return _collectionBtn;
}

- (UILabel *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = DSystemColorGrayE0E0E0;
    }
    return _bottomLine;
}



@end
