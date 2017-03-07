//
//  DMeViewController.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DMeViewController.h"

#import "DMeHeaderView.h"

#import "DUserAPIManager.h"
#import "DUserParamModel.h"

@interface DMeViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DMeHeaderView *headerView;




@end

@implementation DMeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = KGLOBALINFOMANAGER.accountInfo.username;
    self.navLeftItemType = DNavigationItemTypeBack;
    self.navRighItemType = DNavigationItemTypeRightMenu;
    
    [self.view addSubview:self.headerView];
    
    self.headerView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(400);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    [manager fetchAccountProfileWithNotCache];
    
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    DUserModel *userModel = dataModel;
    [self.headerView reloadData];
}


#pragma mark - getter & setter
- (DMeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[DMeHeaderView alloc] init];
    }
    return _headerView;
}

@end
