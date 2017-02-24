//
//  DUserProfileViewController.m
//  ShareImage
//
//  Created by FTY on 2017/2/24.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DUserProfileViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DUserProfileViewController ()<UIScrollViewDelegate>

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *changeBgImageBtn;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIButton *changeIconBtn;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIButton *followlingBtn;

@end

@implementation DUserProfileViewController

- (instancetype)initWithUserName:(NSString *)userName{
    self = [super init];
    if (self) {
        self.userName = userName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
}

#pragma mark - private
- (void)clickChangeBgImageBtn{
    
}
- (void)clickChangeIconImageBtn{
    
}

- (void)clickFollowlingBtn{
    
}


#pragma mark - getter & setter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
    }
    return _bgImageView;
}

- (UIButton *)changeBgImageBtn{
    if (!_changeBgImageBtn) {
        _changeBgImageBtn = [[UIButton alloc] init];
        [_changeBgImageBtn setImage:[UIImage getImageWithName:@""] forState:UIControlStateNormal];
        [_changeBgImageBtn addTarget:self action:@selector(clickChangeBgImageBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBgImageBtn;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        [_iconView.layer setCornerRadius:30.0];
        [_iconView.layer setMasksToBounds:YES];
    }
    return _iconView;
}

- (UIButton *)changeIconBtn{
    if (!_changeIconBtn) {
        _changeIconBtn = [[UIButton alloc] init];
        [_changeIconBtn setImage:[UIImage getImageWithName:@""] forState:UIControlStateNormal];
        [_changeIconBtn addTarget:self action:@selector(clickChangeIconImageBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeIconBtn;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:25.0];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:14.0];
        _addressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addressLabel;
}


- (UIButton *)followlingBtn{
    if (!_followlingBtn) {
        _followlingBtn = [[UIButton alloc] init];
        [_followlingBtn setImage:[UIImage getImageWithName:@""] forState:UIControlStateNormal];
        [_followlingBtn addTarget:self action:@selector(clickFollowlingBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followlingBtn;
}



@end
