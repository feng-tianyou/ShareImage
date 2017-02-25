//
//  DUserProfileViewController.m
//  ShareImage
//
//  Created by FTY on 2017/2/24.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DUserProfileViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DUserAPIManager.h"
#import "DUserParamModel.h"
#import "DPhotosModel.h"

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
    self.navLeftItemType = DNavigationItemTypeBack;
    self.navRighItemType = DNavigationItemTypeRightSearch;
    self.title = @"Profile";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DUserParamModel *paramModel = [[DUserParamModel alloc] init];
    paramModel.username = self.userName;
    [manager fetchUserProfileByParamModel:paramModel];
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.bgImageView];
    [self.scrollView addSubview:self.iconView];
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.addressLabel];
    [self.scrollView addSubview:self.followlingBtn];
    
    [self.bgImageView addSubview:self.changeBgImageBtn];
    [self.iconView addSubview:self.changeIconBtn];
    
    self.scrollView.contentSize = CGSizeMake(self.view.width, self.view.height+self.navBarHeight);
    
    // 布局
    self.scrollView.sd_layout
    .topSpaceToView(self.view, -self.navBarHeight)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    self.bgImageView.sd_layout
    .topEqualToView(self.scrollView)
    .leftEqualToView(self.scrollView)
    .rightEqualToView(self.scrollView)
    .heightIs(300);
    
    self.iconView.sd_layout
    .topSpaceToView(self.bgImageView, -35)
    .centerXEqualToView(self.bgImageView)
    .widthIs(70)
    .heightIs(70);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.iconView, 10)
    .leftSpaceToView(self.scrollView, 10)
    .rightSpaceToView(self.scrollView,10)
    .heightIs(30);
    
    self.addressLabel.sd_layout
    .topSpaceToView(self.nameLabel, 0)
    .leftSpaceToView(self.scrollView, 10)
    .rightSpaceToView(self.scrollView,10)
    .heightIs(20);
    
    self.followlingBtn.sd_layout
    .leftSpaceToView(self.scrollView, 80)
    .rightSpaceToView(self.scrollView,80)
    .bottomSpaceToView(self.scrollView, 30)
    .heightIs(50);
    
    
}

#pragma mark - navEvent
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private
- (void)clickChangeBgImageBtn{
    
}
- (void)clickChangeIconImageBtn{
    
}

- (void)clickFollowlingBtn{
    
}

#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    DUserModel *userModel = dataModel;
    DPhotosModel *photoModel = [userModel.u_photos firstObject];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:photoModel.urls.regular] placeholderImage:nil];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image.medium] placeholderImage:nil];
    self.nameLabel.text = userModel.username;
    self.addressLabel.text = userModel.location;
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
        [_iconView.layer setCornerRadius:35.0];
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
        [_followlingBtn setTitle:@"Follwing" forState:UIControlStateNormal];
        _followlingBtn.titleLabel.textColor = [UIColor whiteColor];
        [_followlingBtn setBackgroundColor:[UIColor setHexColor:@"#2979ff"]];
        _followlingBtn.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:22.0];
        [_followlingBtn.layer setCornerRadius:25.0];
        [_followlingBtn.layer setMasksToBounds:YES];
        [_followlingBtn addTarget:self action:@selector(clickFollowlingBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followlingBtn;
}



@end
