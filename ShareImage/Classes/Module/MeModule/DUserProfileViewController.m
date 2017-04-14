//
//  DUserProfileViewController.m
//  ShareImage
//
//  Created by FTY on 2017/2/24.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DUserProfileViewController.h"
#import "DCommonPhotoController.h"
#import "DUserListViewController.h"
#import "DMapViewController.h"

#import "DUserAPIManager.h"
#import "DUserParamModel.h"
#import "DPhotosModel.h"
#import "DMWPhotosManager.h"

#import "DNumberButton.h"
#import "DHomeCellTipLabel.h"
#import "UIView+DLayer.h"
#import "DCustomNavigationView.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>


@interface DUserProfileViewController ()<UIScrollViewDelegate>

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, strong) DCustomNavigationView *navigationView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) DHomeCellTipLabel *addressLabel;
@property (nonatomic, strong) UILabel *bioLabel;
@property (nonatomic, strong) DNumberButton *photoNumBtn;
@property (nonatomic, strong) DNumberButton *followerNumBtn;
@property (nonatomic, strong) DNumberButton *followingNumBtn;
@property (nonatomic, strong) UIButton *followButton;

// 数据
@property (nonatomic, strong) DUserModel *userModel;
@property (nonatomic, strong) DMWPhotosManager *manager;

@end

@implementation DUserProfileViewController

- (instancetype)initWithUserName:(NSString *)userName{
    self = [super init];
    if (self) {
        self.userName = userName;
        [self.view addSubview:self.navigationView];
        
        [self.view addSubview:self.scrollView];
        [self.scrollView addSubview:self.bgImageView];
        [self.scrollView addSubview:self.iconView];
        [self.scrollView addSubview:self.nameLabel];
        [self.scrollView addSubview:self.addressLabel];
        
        
        [self.scrollView addSubview:self.photoNumBtn];
        [self.scrollView addSubview:self.followerNumBtn];
        [self.scrollView addSubview:self.followingNumBtn];
        
        [self.scrollView addSubview:self.bioLabel];
        [self.scrollView addSubview:self.followButton];
        
        
        [self.view bringSubviewToFront:self.navigationView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navLeftItemType = DNavigationItemTypeWriteBack;

    
    // 请求数据
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DUserParamModel *paramModel = [[DUserParamModel alloc] init];
    paramModel.username = self.userName;
    [manager fetchUserProfileByParamModel:paramModel];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
    // 布局
    self.navigationView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(self.navBarHeight);
    
    self.scrollView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    [self.bgImageView setFrame:0 y:-300 w:self.view.width h:300];
    
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
    .topSpaceToView(self.nameLabel, 10)
    .leftSpaceToView(self.scrollView, 20)
    .rightSpaceToView(self.scrollView,10)
    .heightIs(20);
    
    CGFloat numBtnWidth = SCREEN_WIDTH/3;
    self.photoNumBtn.sd_layout
    .topSpaceToView(self.addressLabel, 20)
    .leftSpaceToView(self.scrollView, 0)
    .widthIs(numBtnWidth)
    .heightIs(40);
    
    self.followerNumBtn.sd_layout
    .topSpaceToView(self.addressLabel, 20)
    .leftSpaceToView(self.photoNumBtn, 0)
    .widthIs(numBtnWidth)
    .heightIs(40);
    
    self.followingNumBtn.sd_layout
    .topSpaceToView(self.addressLabel, 20)
    .leftSpaceToView(self.followerNumBtn, 0)
    .widthIs(numBtnWidth)
    .heightIs(40);
    
    
    self.bioLabel.isAttributedContent = YES;
    self.bioLabel.sd_layout
    .topSpaceToView(self.followerNumBtn, 25)
    .leftSpaceToView(self.scrollView, 15)
    .rightSpaceToView(self.scrollView,15)
    .autoHeightRatio(0);
    
    self.followButton.sd_layout
    .topSpaceToView(self.bioLabel, 30)
    .leftSpaceToView(self.scrollView, 80)
    .rightSpaceToView(self.scrollView,80)
    .heightIs(45);
    
    
    CGSize bioSize = [UILabel getContentSizeForHasLineSpaceByContent:self.bioLabel.text font:self.bioLabel.font maxWidth:self.view.width - 30];
    if (bioSize.height > 20) {
        self.scrollView.contentSize = CGSizeMake(self.view.width,self.followButton.y + 50 + bioSize.height);
    } else {
        self.scrollView.contentSize = CGSizeMake(self.view.width,self.followButton.y + 80 + bioSize.height);
    }
    DLogSize(self.scrollView.contentSize);
    DLog(@"%@", @(self.bioLabel.autoHeight));
    
    [self.scrollView setContentInset:UIEdgeInsetsMake(300, 0, 0, 0)];
    
    [self.scrollView scrollToTop];
}

#pragma mark - navEvent
- (void)navigationBarDidClickNavigationRightBtn:(UIButton *)rightBtn{
    
}

- (void)navigationBarDidClickNavigationLeftBtn:(UIButton *)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)clickIconView{
    [self.manager photoPreviewWithPhotoUrls:@[self.userModel.profile_image.large] currentIndex:0 currentViewController:self];
}

- (void)clickPhotoNumBtn{
    DCommonPhotoController *photoController = [[DCommonPhotoController alloc] initWithTitle:@"PHOTOS" type:UserAPIManagerType];
    photoController.username = self.userName;
    [self.navigationController pushViewController:photoController animated:YES];
}

- (void)clickFollowerNumBtn{
    DUserListViewController *userController = [[DUserListViewController alloc] initWithTitle:@"FOLLOWERS" userName:self.userName type:FollowersType];
    [self.navigationController pushViewController:userController animated:YES];
}

- (void)clickFollowingNumBtn{
    DUserListViewController *userController = [[DUserListViewController alloc] initWithTitle:@"FOLLOWING" userName:self.userName type:FollowingType];
    [self.navigationController pushViewController:userController animated:YES];
}

- (void)clickFollowButton{
    DUserAPIManager *manager = nil;
    DUserParamModel *paramModel = [[DUserParamModel alloc] init];
    paramModel.username = self.userName;
    if (self.userModel.followed_by_user) {
        manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
        [manager cancelFollowUserByParamModel:paramModel];
    } else {
        manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
        [manager followUserByParamModel:paramModel];
    }
}

- (void)clickAddress{
    DMapViewController *mapController = [[DMapViewController alloc] initWithAddress:self.userModel.location];
    [self.navigationController pushViewController:mapController animated:YES];
}


#pragma mark - delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //通过滑动的便宜距离重新给图片设置大小
    CGFloat yOffset = scrollView.contentOffset.y;
    if(yOffset<-300)
    {
        CGRect f= self.bgImageView.frame;
        f.origin.y= yOffset;
        f.size.height = -yOffset;
        self.bgImageView.frame = f;
    }
    
    if(scrollView.contentOffset.y > -250){
        CGFloat alpha = scrollView.contentOffset.y - -250;
        alpha = alpha/10;
        if(alpha > 1.0){
            alpha = 1.0;
        }
        self.navigationView.bgView.backgroundColor = DSystem2AlphaWhiteColor8;
        self.navigationView.bgView.alpha = alpha;
    } else{
        self.navigationView.bgView.backgroundColor = [UIColor clearColor];
    }
}


#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    self.scrollView.hidden = NO;
    self.userModel = dataModel;
    
    DUserModel *userModel = dataModel;
    DPhotosModel *photoModel = [userModel.u_photos firstObject];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:photoModel.urls.regular] placeholderImage:nil];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image.medium] placeholderImage:nil];
    self.nameLabel.text = userModel.username;
    
    if (userModel.location.length > 0) {
        self.addressLabel.hidden = NO;
        self.addressLabel.describe = userModel.location;
    } else {
        self.addressLabel.hidden = YES;
    }
    
    self.photoNumBtn.numberLabel.text = [self changeThousandWithNumber:userModel.total_photos];
    self.followerNumBtn.numberLabel.text = [self changeThousandWithNumber:userModel.followers_count];
    self.followingNumBtn.numberLabel.text = [self changeThousandWithNumber:userModel.following_count];
    
    self.bioLabel.text = userModel.bio;
    if (userModel.bio.length > 0) {
        [self.bioLabel addLineSpace];
    }
    
    if (userModel.followed_by_user) {
        [self.followButton setBackgroundColor:[UIColor blackColor]];
    } else {
        [self.followButton setBackgroundColor:[UIColor setHexColor:@"#2979ff"]];
    }
//    [self.view setNeedsLayout];
    
}


#pragma mark - getter & setter
- (DCustomNavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[DCustomNavigationView alloc] init];
        _navigationView.navLeftItemType = DNavigationItemTypeWriteBack;
        _navigationView.navRighItemType = DNavigationItemTypeRightWriteMenu;
        _navigationView.title = @"Profile";
        [_navigationView.navLeftItem addTarget:self action:@selector(navigationBarDidClickNavigationLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView.navRightItem addTarget:self action:@selector(navigationBarDidClickNavigationRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _navigationView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.hidden = YES;
    }
    return _scrollView;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = [UIColor lightRandom];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}


- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor lightRandom];
        [_iconView.layer setCornerRadius:35.0];
        [_iconView.layer setMasksToBounds:YES];
        _iconView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickIconView)];
        [_iconView addGestureRecognizer:tap];
    }
    return _iconView;
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

- (UILabel *)bioLabel{
    if (!_bioLabel) {
        _bioLabel = [[UILabel alloc] init];
        _bioLabel.textColor = [UIColor blackColor];
        _bioLabel.textAlignment = NSTextAlignmentLeft;
        _bioLabel.numberOfLines = 0;
        _bioLabel.font = DSystemFontText;
    }
    return _bioLabel;
}

- (DHomeCellTipLabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[DHomeCellTipLabel alloc] init];
        _addressLabel.iconName = @"common_btn_address_hight";
        _addressLabel.describeLabel.textColor = [UIColor blackColor];
        _addressLabel.describeLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:14.0];
        _addressLabel.mode = HomeCellTipLabelCenter;
        [_addressLabel addTarget:self action:@selector(clickAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressLabel;
}


- (DNumberButton *)photoNumBtn{
    if (!_photoNumBtn) {
        _photoNumBtn = [[DNumberButton alloc] initWithDescrible:@"PHOTOS"];
        [_photoNumBtn addTarget:self action:@selector(clickPhotoNumBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoNumBtn;
}

- (DNumberButton *)followerNumBtn{
    if (!_followerNumBtn) {
        _followerNumBtn = [[DNumberButton alloc] initWithDescrible:@"FOLLOWERS"];
        [_followerNumBtn addTarget:self action:@selector(clickFollowerNumBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followerNumBtn;
}

- (DNumberButton *)followingNumBtn{
    if (!_followingNumBtn) {
        _followingNumBtn = [[DNumberButton alloc] initWithDescrible:@"FOLLOWING"];
        [_followingNumBtn addTarget:self action:@selector(clickFollowingNumBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followingNumBtn;
}


- (UIButton *)followButton{
    if (!_followButton) {
        _followButton = [[UIButton alloc] init];
        [_followButton setTitle:@"Follwing" forState:UIControlStateNormal];
        _followButton.titleLabel.textColor = [UIColor whiteColor];
        [_followButton setBackgroundColor:[UIColor setHexColor:@"#2979ff"]];
        _followButton.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:22.0];
        [_followButton.layer setCornerRadius:22.5];
        [_followButton.layer setMasksToBounds:YES];
        [_followButton addTarget:self action:@selector(clickFollowButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}

- (DMWPhotosManager *)manager{
    if (!_manager) {
        _manager = [[DMWPhotosManager alloc] init];
        _manager.longPressType = DMWPhotosManagerTypeForSave;
    }
    return _manager;
}


@end
