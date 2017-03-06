//
//  DUserListViewController.m
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DUserListViewController.h"
#import "DSearchViewController.h"
#import "DUserProfileViewController.h"

#import "DUserAPIManager.h"
#import "DUserParamModel.h"

#import "DUserListViewCell.h"

#import <MJRefresh/MJRefresh.h>

@interface DUserListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) FollowType type;
@property (nonatomic, copy) NSString *username;
@end

@implementation DUserListViewController

- (instancetype)initWithTitle:(NSString *)title userName:(NSString *)userName type:(FollowType)type{
    self = [super init];
    if (self) {
        self.title = title;
        self.username = userName;
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navLeftItemType = DNavigationItemTypeBack;
    self.navRighItemType = DNavigationItemTypeRightSearch;
    
    // 请求数据
    [self getUsersData];
    // 初始化上下拉刷新
    [self setupTableViewUpAndDowmLoad];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    // 布局子视图
    [self setupSubViewsAutoLayout];
}

#pragma mark - 私有方法
- (void)setupSubViewsAutoLayout{
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0);
}

- (void)getUsersData{
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DUserParamModel *paramModel = [[DUserParamModel alloc] init];
    paramModel.page = self.page;
    paramModel.per_page = 20;
    paramModel.username = self.username;
    if (self.type == FollowersType) {
        [manager fetchUserFollowersByParamModel:paramModel];
    } else {
        [manager fetchUserFollowingByParamModel:paramModel];
    }
}


/**
 设置上下拉刷新
 */
- (void)setupTableViewUpAndDowmLoad{
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self getUsersData];
        });
    }];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DUserListViewCell *cell = [DUserListViewCell cellWithTableView:tableView];
    
    if (self.users.count > indexPath.row) {
        cell.userModel = self.users[indexPath.row];
       
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.users.count > indexPath.row) {
        DUserModel *model = self.users[indexPath.row];
        DUserProfileViewController *view = [[DUserProfileViewController alloc] initWithUserName:model.username];
        [self.navigationController pushViewController:view animated:YES];
    }
    
}

#pragma mark - 导航栏点击事件
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (isLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        DSearchViewController *searchController = [[DSearchViewController alloc] initWithSearchType:UserSearchType];
        [self.navigationController pushViewController:searchController animated:YES];
    }
}





#pragma mark - 请求回调
- (void)requestServiceSucceedBackArray:(NSArray *)arrData userInfo:(NSDictionary *)userInfo{
    
    self.page++;
    [self.users addObjectsFromArray:arrData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)unlockUI{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)clearData{
    [self.users removeAllObjects];
}

- (void)hasNotMoreData{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark - getter & setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 50.0;
        _tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    }
    return _tableView;
}

- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}


@end
