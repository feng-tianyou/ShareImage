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

#import <SDWebImage/UIImageView+WebCache.h>
#import "DUserAPIManager.h"
#import "DUserParamModel.h"
#import "DPhotosModel.h"

#import "DNumberButton.h"
#import "DHomeCellTipLabel.h"
#import "UIView+DLayer.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface DUserProfileViewController ()<UIScrollViewDelegate>

@property (nonatomic, copy) NSString *userName;

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
    self.navRighItemType = DNavigationItemTypeRightMenu;
    self.title = @"Profile";
    
    // 请求数据
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DUserParamModel *paramModel = [[DUserParamModel alloc] init];
    paramModel.username = self.userName;
    [manager fetchUserProfileByParamModel:paramModel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
   
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
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
    
    
    [self.scrollView setContentInset:UIEdgeInsetsMake(300, 0, 0, 0)];
    self.scrollView.contentSize = CGSizeMake(self.view.width, self.view.height+self.navBarHeight-300);
    
    // 布局
    self.scrollView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
//    self.bgImageView.sd_layout
//    .topSpaceToView(self.scrollView, -300)
//    .leftEqualToView(self.scrollView)
//    .rightEqualToView(self.scrollView)
//    .heightIs(300);
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
    .topSpaceToView(self.nameLabel, 0)
    .leftSpaceToView(self.scrollView, 10)
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
    
    
    self.bioLabel.sd_layout
    .topSpaceToView(self.followerNumBtn, 20)
    .leftSpaceToView(self.scrollView, 10)
    .rightSpaceToView(self.scrollView,10)
    .autoHeightRatio(0);
    
    self.followButton.sd_layout
    .topSpaceToView(self.bioLabel, 20)
    .leftSpaceToView(self.scrollView, 80)
    .rightSpaceToView(self.scrollView,80)
    .heightIs(50);
    
    [self.scrollView scrollToTop];
}

#pragma mark - navEvent
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
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
//        [self.networkUserInfo setObject:@"cancel" forKey:@"follow"];
        manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
        [manager cancelFollowUserByParamModel:paramModel];
    } else {
//        [self.networkUserInfo setObject:@"follow" forKey:@"follow"];
        manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
        [manager followUserByParamModel:paramModel];
    }
    
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
}



#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
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
    
    if (userModel.followed_by_user) {
        [self.followButton setBackgroundColor:[UIColor blackColor]];
    } else {
        [self.followButton setBackgroundColor:[UIColor setHexColor:@"#2979ff"]];
    }
    
}

//- (void)requestServiceSucceedBackBool:(BOOL)isTrue userInfo:(NSDictionary *)userInfo{
//    [SVProgressHUD setMaximumDismissTimeInterval:2.0];
//    if ([[userInfo objectForKey:@"follow"] isEqualToString:@"cancel"]) {
//        if (isTrue) {
//            [SVProgressHUD showSuccessWithStatus:@"UnFollow Success"];
//            [self.followButton setBackgroundColor:[UIColor setHexColor:@"#2979ff"]];
//        }
//    } else {
//        if (isTrue) {
//            [SVProgressHUD showSuccessWithStatus:@"Follow Success"];
//            [self.followButton setBackgroundColor:[UIColor blackColor]];
//        }
//    }
//}


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
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}


- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        [_iconView.layer setCornerRadius:35.0];
        [_iconView.layer setMasksToBounds:YES];
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
        [_followButton.layer setCornerRadius:25.0];
        [_followButton.layer setMasksToBounds:YES];
        [_followButton addTarget:self action:@selector(clickFollowButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}


@end
