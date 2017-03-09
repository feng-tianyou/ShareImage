//
//  DMeHeaderFunctionView.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/7.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DMeHeaderFunctionView.h"


@interface DMeHeaderFunctionView ()


@property (nonatomic, strong) UILabel *leftLine;
@property (nonatomic, strong) UILabel *rightLine;
@property (nonatomic, strong) UILabel *bottomLine;

@end

@implementation DMeHeaderFunctionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.photoBtn];
        [self addSubview:self.followersBtn];
        [self addSubview:self.followingBtn];
        [self addSubview:self.leftLine];
        [self addSubview:self.rightLine];
        [self addSubview:self.bottomLine];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.width/3;
    self.photoBtn.sd_layout
    .topSpaceToView(self, 10)
    .leftEqualToView(self)
    .widthIs(width)
    .heightIs(60);
    
    self.leftLine.sd_layout
    .topSpaceToView(self, 12)
    .leftSpaceToView(self.photoBtn, 1)
    .widthIs(0.2)
    .heightIs(44);
    
    self.followersBtn.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(self.photoBtn, 0)
    .widthIs(width)
    .heightIs(60);
    
    self.rightLine.sd_layout
    .topSpaceToView(self, 12)
    .leftSpaceToView(self.followersBtn, 1)
    .widthIs(0.2)
    .heightIs(44);
    
    self.followingBtn.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(self.followersBtn, 0)
    .widthIs(width)
    .heightIs(60);
    
    self.bottomLine.sd_layout
    .bottomSpaceToView(self, -1)
    .leftSpaceToView(self, 0)
    .rightEqualToView(self)
    .heightIs(0.2);
}

#pragma mark - public
- (void)reloadData{
    self.photoBtn.numberLabel.text = [NSString stringWithFormat:@"%@", @(KGLOBALINFOMANAGER.accountInfo.u_photos.count)];
    self.followersBtn.numberLabel.text = [self changeThousandWithNumber:KGLOBALINFOMANAGER.accountInfo.followers_count];
    self.followingBtn.numberLabel.text = [self changeThousandWithNumber:KGLOBALINFOMANAGER.accountInfo.following_count];
}

#pragma mark - private
- (NSString *)changeThousandWithNumber:(NSUInteger)number{
    if (number > 1000) {
        float num = number/1000.0;
        NSString *str = [NSString decimalwithFormat:@"0.0" numberValue:@(num)];
        return [NSString stringWithFormat:@"%@K", str];
    } else if (number > 10000) {
        float num = number/10000.0;
        NSString *str = [NSString decimalwithFormat:@"0.0" numberValue:@(num)];
        return [NSString stringWithFormat:@"%@W", str];
    }
    return [NSString stringWithFormat:@"%@", @(number)];
}

#pragma mark - getter & setter
- (DNumberButton *)photoBtn{
    if (!_photoBtn) {
        _photoBtn = [[DNumberButton alloc] initWithDescrible:@"PHOTOS"];
    }
    return _photoBtn;
}

- (DNumberButton *)followersBtn{
    if (!_followersBtn) {
        _followersBtn = [[DNumberButton alloc] initWithDescrible:@"FOLLOWERS"];
    }
    return _followersBtn;
}

- (DNumberButton *)followingBtn{
    if (!_followingBtn) {
        _followingBtn = [[DNumberButton alloc] initWithDescrible:@"FOLLOWINGS"];
    }
    return _followingBtn;
}

- (UILabel *)leftLine{
    if (!_leftLine) {
        _leftLine = [[UILabel alloc] init];
        _leftLine.backgroundColor = [UIColor grayColor];
    }
    return _leftLine;
}

- (UILabel *)rightLine{
    if (!_rightLine) {
        _rightLine = [[UILabel alloc] init];
        _rightLine.backgroundColor = [UIColor grayColor];
    }
    return _rightLine;
}

- (UILabel *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = [UIColor grayColor];
    }
    return _bottomLine;
}

@end
