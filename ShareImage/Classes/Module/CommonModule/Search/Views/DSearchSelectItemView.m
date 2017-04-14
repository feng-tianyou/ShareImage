//
//  DSearchSelectItemView.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/1.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchSelectItemView.h"

#define kPHOTO_BUTTON_TAG               1001
#define kUSER_BUTTON_TAG                1002
#define kCOLLECTION_BUTTON_TAG          1003

@interface DSearchSelectItemView ()

@property (nonatomic, strong) UILabel *bottomLine;
@property (nonatomic, strong) UILabel *sliderLine;
@property (nonatomic, assign) BOOL isFirst;
@end

@implementation DSearchSelectItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.isFirst = YES;

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


- (void)didCilckButton:(UIButton *)button{
    if (button.bounds.size.height <= 0) return;
    CGFloat lineWidth = [button.titleLabel.text sizeWithFont:button.titleLabel.font].width;
    CGRect lineRect = self.sliderLine.frame;
    lineRect.size.width = lineWidth;
    lineRect.size.height = 2;
    self.sliderLine.frame = lineRect;
    [UIView animateWithDuration:0.25 animations:^{
        CGPoint point = button.center;
        point.y = self.bottomLine.y - 1;
        [self.sliderLine setCenter:point];
    }];
    switch (button.tag) {
        case kPHOTO_BUTTON_TAG:
        {
            self.photoBtn.selected = !button.isSelected;
            self.userBtn.selected = NO;
            self.collectionBtn.selected = NO;
        }
            break;
        case kUSER_BUTTON_TAG:
        {
            self.photoBtn.selected = NO;
            self.userBtn.selected = !button.isSelected;
            self.collectionBtn.selected = NO;
        }
            break;
        case kCOLLECTION_BUTTON_TAG:
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
        [_photoBtn setTitle:kLocalizedLanguage(@"sePHOTOS") forState:UIControlStateNormal];
        [_photoBtn setTitleColor:DSystemColorBlackBBBBBB forState:UIControlStateNormal];
        [_photoBtn setTitleColor:DSystemColorBlue33AACC forState:UIControlStateSelected];
        _photoBtn.tag = kPHOTO_BUTTON_TAG;
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
        _userBtn.tag = kUSER_BUTTON_TAG;
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
        _collectionBtn.tag = kCOLLECTION_BUTTON_TAG;
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
