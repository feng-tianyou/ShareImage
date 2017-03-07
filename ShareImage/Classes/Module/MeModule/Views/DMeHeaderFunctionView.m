//
//  DMeHeaderFunctionView.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/7.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DMeHeaderFunctionView.h"
#import "DNumberButton.h"

@interface DMeHeaderFunctionView ()

@property (nonatomic, strong) DNumberButton *photoBtn;
@property (nonatomic, strong) DNumberButton *followersBtn;
@property (nonatomic, strong) DNumberButton *followingBtn;

@end

@implementation DMeHeaderFunctionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.photoBtn];
        [self addSubview:self.followersBtn];
        [self addSubview:self.followingBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.width/3;
    self.photoBtn.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .widthIs(width)
    .heightIs(50);
    
    self.followersBtn.sd_layout
    .topEqualToView(self)
    .leftSpaceToView(self.photoBtn, 0)
    .widthIs(width)
    .heightIs(50);
    
    self.photoBtn.sd_layout
    .topEqualToView(self)
    .leftSpaceToView(self.followersBtn, 0)
    .widthIs(width)
    .heightIs(50);
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

@end
