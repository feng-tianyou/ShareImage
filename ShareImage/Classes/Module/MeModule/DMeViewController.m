//
//  DMeViewController.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DMeViewController.h"
#import "DCommonPhotoController.h"
#import "DUserListViewController.h"

#import "DMeHeaderView.h"
#import "DCustomNavigationView.h"

#import "DUserAPIManager.h"
#import "DUserParamModel.h"

@interface DMeViewController ()<UITableViewDelegate, UITableViewDataSource, MeHeaderViewDelegate>

@property (nonatomic, strong) DCustomNavigationView *navigationView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DMeHeaderView *headerView;




@end

@implementation DMeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = KGLOBALINFOMANAGER.accountInfo.username;
    self.navLeftItemType = DNavigationItemTypeWriteBack;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.headerView];
    [self.view addSubview:self.navigationView];
    [self.view bringSubviewToFront:self.navigationView];
    
    
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    [manager fetchAccountProfileWithNotCache];
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
    
    self.navigationView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(self.navBarHeight);
    
    [self.headerView setFrame:0 y:0 w:self.view.width h:320];
    [self.tableView setFrame:0 y:0 w:self.view.width h:self.view.height];
}


#pragma mark - navEvent
- (void)navigationBarDidClickNavigationRightBtn:(UIButton *)rightBtn{
    
}

- (void)navigationBarDidClickNavigationLeftBtn:(UIButton *)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MeHeaderViewDelegate
- (void)meHeaderView:(DMeHeaderView *)meHeaderView didSelectIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            DCommonPhotoController *photoController = [[DCommonPhotoController alloc] initWithTitle:@"PHOTOS" type:UserAPIManagerType];
            photoController.username = KGLOBALINFOMANAGER.accountInfo.username;
            [self.navigationController pushViewController:photoController animated:YES];
        }
            break;
        case 1:
        {
            DUserListViewController *userController = [[DUserListViewController alloc] initWithTitle:@"FOLLOWERS" userName:KGLOBALINFOMANAGER.accountInfo.username type:FollowersType];
            [self.navigationController pushViewController:userController animated:YES];
        }
            break;
        case 2:
        {
            DUserListViewController *userController = [[DUserListViewController alloc] initWithTitle:@"FOLLOWING" userName:KGLOBALINFOMANAGER.accountInfo.username type:FollowingType];
            [self.navigationController pushViewController:userController animated:YES];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - <UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = KGLOBALINFOMANAGER.accountInfo.u_photos.count;
    if (count > 3) {
        return 3;
    }
    return KGLOBALINFOMANAGER.accountInfo.u_photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdetifier = @"";
    UITableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:CellIdetifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdetifier];
        cell.textLabel.text = @"asdasdas";
    }
    
    return cell;
}



#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
//    DUserModel *userModel = dataModel;
    self.tableView.hidden = NO;
    [self.headerView reloadData];
}


#pragma mark - getter & setter
- (DCustomNavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[DCustomNavigationView alloc] init];
        _navigationView.navLeftItemType = DNavigationItemTypeWriteBack;
        _navigationView.navRighItemType = DNavigationItemTypeRightSetting;
        _navigationView.title = KGLOBALINFOMANAGER.accountInfo.username;
        [_navigationView.navLeftItem addTarget:self action:@selector(navigationBarDidClickNavigationLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView.navRightItem addTarget:self action:@selector(navigationBarDidClickNavigationRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationView;
}

- (DMeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[DMeHeaderView alloc] init];
        _headerView.delegate = self;
//        _headerView.bgImbageView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        _headerView.bgImbageView.clipsToBounds=YES;
//        _headerView.bgImbageView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _headerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.hidden = YES;
//        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _tableView;
}

@end
