//
//  DSearchSelectItemView.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/1.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchSelectItemView.h"

@interface DSearchSelectItemView ()

@property (nonatomic, strong) UILabel *bottomLine;
@property (nonatomic, strong) UILabel *sliderLine;
@end

@implementation DSearchSelectItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.photoBtn];
        [self addSubview:self.userBtn];
        [self addSubview:self.collectionBtn];
        [self addSubview:self.bottomLine];
        [self addSubview:self.sliderLine];
        
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
        .bottomSpaceToView(self, 0.5)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(0.5);
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.sliderLine setFrame:self.photoBtn.center.x-27 y:self.bottomLine.y - 2 w:50 h:2];
}

- (void)didCilckButton:(UIButton *)button{
    switch (button.tag) {
        case 1:
        {
            self.photoBtn.selected = !button.isSelected;
            self.userBtn.selected = NO;
            self.collectionBtn.selected = NO;
            CGFloat x = self.photoBtn.center.x;
            [UIView animateWithDuration:0.25 animations:^{
                [self.sliderLine setFrame:x-27 y:self.bottomLine.y - 2 w:50 h:2];
            }];
        }
            break;
        case 2:
        {
            self.photoBtn.selected = NO;
            self.userBtn.selected = !button.isSelected;
            self.collectionBtn.selected = NO;
            CGFloat x = self.userBtn.center.x;
            [UIView animateWithDuration:0.25 animations:^{
                [self.sliderLine setFrame:x-25 y:self.bottomLine.y - 2 w:50 h:2];
            }];
        }
            break;
        case 3:
        {
            self.photoBtn.selected = NO;
            self.userBtn.selected = NO;
            self.collectionBtn.selected = !button.isSelected;
            CGFloat x = self.collectionBtn.center.x;
            [UIView animateWithDuration:0.25 animations:^{
                [self.sliderLine setFrame:x-25 y:self.bottomLine.y - 2 w:50 h:2];
            }];
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
        [_photoBtn setTitle:kLocalizedLanguage(@"sePHOTOS") forState:UIControlStateNormal];
        [_photoBtn setTitleColor:DSystemColorBlackBBBBBB forState:UIControlStateNormal];
        [_photoBtn setTitleColor:DSystemColorBlue33AACC forState:UIControlStateSelected];
        _photoBtn.tag = 1;
    }
    return _photoBtn;
}

- (UIButton *)userBtn{
    if (!_userBtn) {
        _userBtn = [[UIButton alloc] init];
        _userBtn.backgroundColor = [UIColor clearColor];
        [_userBtn setTitle:kLocalizedLanguage(@"seUSERS") forState:UIControlStateNormal];
        [_userBtn setTitleColor:DSystemColorBlackBBBBBB forState:UIControlStateNormal];
        [_userBtn setTitleColor:DSystemColorBlue33AACC forState:UIControlStateSelected];
        _userBtn.tag = 2;
    }
    return _userBtn;
}

- (UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn = [[UIButton alloc] init];
        _collectionBtn.backgroundColor = [UIColor clearColor];
        [_collectionBtn setTitle:kLocalizedLanguage(@"seCOLLECTIONS") forState:UIControlStateNormal];
        [_collectionBtn setTitleColor:DSystemColorBlackBBBBBB forState:UIControlStateNormal];
        [_collectionBtn setTitleColor:DSystemColorBlue33AACC forState:UIControlStateSelected];
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

- (UILabel *)sliderLine{
    if (!_sliderLine) {
        _sliderLine = [[UILabel alloc] init];
        _sliderLine.backgroundColor = DSystemColorBlue33AACC;
    }
    return _sliderLine;
}

@end
