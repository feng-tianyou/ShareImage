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

@interface DMeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DMeHeaderView *headerView;




@end

@implementation DMeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = KGLOBALINFOMANAGER.accountInfo.username;
    self.navLeftItemType = DNavigationItemTypeBack;
    self.navRighItemType = DNavigationItemTypeRightMenu;
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.headerView];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    [manager fetchAccountProfileWithNotCache];
    
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
    
    [self.headerView setFrame:0 y:-300 w:self.view.width h:300];
    [self.tableView setFrame:0 y:0 w:self.view.width h:self.view.height];
//    [self.tableView setTableHeaderView:self.headerView];
}


- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - sc
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat y = scrollView.contentOffset.y; //如果有导航控制器，这里应该加上导航控制器的高度64
//    if (y< -300) {
//        CGRect frame = self.headerView.frame;
//        frame.origin.y = y;
//        frame.size.height = -y;
//        self.headerView.bgImbageView.frame = frame;
//    }
    
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if ( Offset_y < 0) {
        // 拉伸后图片的高度
        CGFloat totalOffset = 300 - Offset_y;
        // 图片放大比例
        CGFloat scale = totalOffset / 300;
        CGFloat width = SCREEN_WIDTH;
        // 拉伸后图片位置
        self.headerView.bgImbageView.frame = CGRectMake(-(width * scale - width) / 2, Offset_y, width * scale, totalOffset);
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
    }
    
    return cell;
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
        _headerView.bgImbageView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _headerView.bgImbageView.clipsToBounds=YES;
        _headerView.bgImbageView.contentMode=UIViewContentModeScaleAspectFill;
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
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0);
    }
    return _tableView;
}

@end
