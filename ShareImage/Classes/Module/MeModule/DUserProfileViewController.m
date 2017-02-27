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

#import "DNumberButton.h"

@interface DUserProfileViewController ()<UIScrollViewDelegate>

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIButton *followlingBtn;

@property (nonatomic, strong) DNumberButton *photoNumBtn;
@property (nonatomic, strong) DNumberButton *followerNumBtn;
@property (nonatomic, strong) DNumberButton *followingNumBtn;

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
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DUserParamModel *paramModel = [[DUserParamModel alloc] init];
    paramModel.username = self.userName;
    [manager fetchUserProfileByParamModel:paramModel];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
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
    
    [self.scrollView addSubview:self.followlingBtn];
    
    
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
    
    
    self.followlingBtn.sd_layout
    .topSpaceToView(self.followerNumBtn, 50)
    .leftSpaceToView(self.scrollView, 80)
    .rightSpaceToView(self.scrollView,80)
    .heightIs(50);
    
}

#pragma mark - navEvent
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private
- (void)setupNav{
    self.navLeftItemType = DNavigationItemTypeWriteBack;
    self.navRighItemType = DNavigationItemTypeRightWriteMenu;
    self.title = @"Profile";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

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


- (void)clickFollowlingBtn{
    
}
// -----------------------------------
- (void)clickPhotoNumBtn{
    
}

- (void)clickFollowerNumBtn{
    
}

- (void)clickFollowingNumBtn{
    
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
    DUserModel *userModel = dataModel;
    DPhotosModel *photoModel = [userModel.u_photos firstObject];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:photoModel.urls.regular] placeholderImage:nil];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image.medium] placeholderImage:nil];
    self.nameLabel.text = userModel.username;
    self.addressLabel.text = userModel.location;
    
    
    self.photoNumBtn.numberLabel.text = [self changeThousandWithNumber:userModel.total_photos];
    self.followerNumBtn.numberLabel.text = [self changeThousandWithNumber:userModel.followers_count];
    self.followingNumBtn.numberLabel.text = [self changeThousandWithNumber:userModel.following_count];
    
    
    
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



@end
