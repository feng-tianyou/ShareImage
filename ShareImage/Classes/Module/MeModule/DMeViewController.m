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
#import "DEditProfileViewController.h"

#import "DMeHeaderView.h"
#import "DCustomNavigationView.h"
#import "DMeTableViewCell.h"

#import "DUserAPIManager.h"
#import "DUserParamModel.h"
#import "DMWPhotosManager.h"
#import "DPhotosModel.h"

@interface DMeViewController ()<UITableViewDelegate, UITableViewDataSource, MeHeaderViewDelegate>

@property (nonatomic, strong) DCustomNavigationView *navigationView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DMeHeaderView *headerView;

@property (nonatomic, strong) DMWPhotosManager *manager;
@property (nonatomic, strong) NSArray *usersPhotos;


@end

@implementation DMeViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = KGLOBALINFOMANAGER.accountInfo.username;
    self.navLeftItemType = DNavigationItemTypeWriteBack;
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    [manager fetchAccountProfileWithNotCache];
    
    
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.navigationView];
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
    
    [self.tableView setFrame:0 y:0 w:self.view.width h:self.view.height];
    [self.headerView setFrame:0 y:0 w:self.view.width h:320];
    
    [self.tableView setTableHeaderView:self.headerView];
}


#pragma mark - navEvent
- (void)navigationBarDidClickNavigationRightBtn:(UIButton *)rightBtn{
    DEditProfileViewController *view = [[DEditProfileViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)navigationBarDidClickNavigationLeftBtn:(UIButton *)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MeHeaderViewDelegate
- (void)meHeaderView:(DMeHeaderView *)meHeaderView didSelectIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            DCommonPhotoController *photoController = [[DCommonPhotoController alloc] initWithTitle:kLocalizedLanguage(@"mePHOTOS") type:UserAPIManagerType];
            photoController.username = KGLOBALINFOMANAGER.accountInfo.username;
            [self.navigationController pushViewController:photoController animated:YES];
        }
            break;
        case 1:
        {
            DUserListViewController *userController = [[DUserListViewController alloc] initWithTitle:kLocalizedLanguage(@"meFOLLOWERS") userName:KGLOBALINFOMANAGER.accountInfo.username type:FollowersType];
            [self.navigationController pushViewController:userController animated:YES];
        }
            break;
        case 2:
        {
            DUserListViewController *userController = [[DUserListViewController alloc] initWithTitle:kLocalizedLanguage(@"meFOLLOWING") userName:KGLOBALINFOMANAGER.accountInfo.username type:FollowingType];
            [self.navigationController pushViewController:userController animated:YES];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - <UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.usersPhotos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DMeTableViewCell *cell = [DMeTableViewCell cellWithTableView:tableView];
    if (self.usersPhotos.count > indexPath.section) {
        cell.photosModel = self.usersPhotos[indexPath.section];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.usersPhotos.count > indexPath.section) {
        DPhotosModel *photoModel = self.usersPhotos[indexPath.section];
        [self.manager photoPreviewWithPhotoModels:@[photoModel] currentIndex:0 currentViewController:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.usersPhotos[indexPath.section];
    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"photosModel" cellClass:[DMeTableViewCell class] contentViewWidth:self.view.width];
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = DSystemColorGrayF3F3F3;
        label.font = DSystemFontText;
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        //第一行头缩进
        [style setFirstLineHeadIndent:15.0];
        [label setLineBreakMode:NSLineBreakByTruncatingTail];
        [label sizeToFit];
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:kLocalizedLanguage(@"meRecent Photos") attributes:@{NSParagraphStyleAttributeName : style}];
        label.attributedText = attrText;
        return label;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y > 61){
        CGFloat alpha = scrollView.contentOffset.y - 61;
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
    DUserModel *userModel = dataModel;
    self.tableView.hidden = NO;
    self.usersPhotos = userModel.u_photos;
    [self.headerView reloadData];
    [self.tableView reloadData];
}


#pragma mark - getter & setter
- (DCustomNavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[DCustomNavigationView alloc] init];
        _navigationView.navLeftItemType = DNavigationItemTypeWriteBack;
        _navigationView.navRighItemType = DNavigationItemTypeRightEdit;
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
    }
    return _headerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.hidden = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)usersPhotos{
    if (!_usersPhotos) {
        _usersPhotos = [[NSArray alloc] init];
    }
    return _usersPhotos;
}

- (DMWPhotosManager *)manager{
    if (!_manager) {
        _manager = [[DMWPhotosManager alloc] init];
        _manager.longPressType = DMWPhotosManagerTypeForSaveDownLoadLike;
    }
    return _manager;
}

@end
