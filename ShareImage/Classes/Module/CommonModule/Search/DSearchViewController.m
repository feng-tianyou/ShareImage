//
//  DSearchViewController.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/1.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchViewController.h"
#import "DUserProfileViewController.h"
#import "DPhotoDetailController.h"
#import "DCommonPhotoController.h"

#import "DCustomSearchBar.h"
#import "DUITableView.h"
#import "DSelectItemView.h"

#import "DSearchPhotoView.h"
#import "DSearchUserView.h"
#import "DSearchCollectionView.h"
#import "DScrollPageContentView.h"

#import "DPhotosAPIManager.h"
#import "DPhotosParamModel.h"
#import "DMWPhotosManager.h"

#import "DSearchPhotosModel.h"
#import "DSearchUsersModel.h"
#import "DSearchCollectionsModel.h"

#import <MJRefresh/MJRefresh.h>

/// 搜索图片
static NSString *kGetSearchPhotosDataMethor = @"kGetSearchPhotosDataMethor";
/// 搜索用户
static NSString *kGetSearchUsersDataMethor = @"kGetSearchUsersDataMethor";
/// 搜索分类
static NSString *kGetSearchCollectionsDataMethor = @"kGetSearchCollectionsDataMethor";

@interface DSearchViewController ()<TGCustomSearchBarDelegate, DScrollPageContentViewDelegate>


@property (nonatomic, strong) DCustomSearchBar *searchBar;
@property (nonatomic, strong) DSelectItemView *selectItemView;

@property (nonatomic, strong) NSMutableArray *childMainViews;
@property (nonatomic, strong) DScrollPageContentView *pageContentView;
@property (nonatomic, strong) DSearchPhotoView *photoView;
@property (nonatomic, strong) DSearchUserView *userView;
@property (nonatomic, strong) DSearchCollectionView *collectionView;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) DMWPhotosManager *manager;



@end

@implementation DSearchViewController

- (instancetype)initWithSearchType:(SearchType)searchType{
    self = [super init];
    if (self) {
        _searchType = searchType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navLeftItemType = DNavigationItemTypeNone;
    self.navigationItem.titleView = self.searchBar;
    
    _selectItemView = ({
        DSelectItemView *view = [[DSelectItemView alloc] initWithTitles:@[kLocalizedLanguage(@"sePhotos"), kLocalizedLanguage(@"seUsers"), kLocalizedLanguage(@"seCollections")]];
        view;
    });
    [self.view addSubview:_selectItemView];
    
    @weakify(self)
    [_selectItemView setClickItemBlock:^(NSInteger index){
        @strongify(self)
        self.currentIndex = index;
        [self.pageContentView setPageCententViewCurrentIndex:index];
        [self commonGetData];
    }];
    
    _childMainViews = [NSMutableArray arrayWithCapacity:3];
    _photoView = ({
        DSearchPhotoView *view = [[DSearchPhotoView alloc] init];
        view.mainController = self;
        view;
    });
    [_childMainViews addObject:_photoView];
    
    _userView = ({
        DSearchUserView *view = [[DSearchUserView alloc] init];
        view.mainController = self;
        view;
    });
    [_childMainViews addObject:_userView];
    
    _collectionView = ({
        DSearchCollectionView *view = [[DSearchCollectionView alloc] init];
        view.mainController = self;
        view;
    });
    [_childMainViews addObject:_collectionView];
    _pageContentView = [[DScrollPageContentView alloc] initWithFrame:CGRectMake(0, self.navBarHeight+50, self.view.width, self.view.height - self.navBarHeight - 50) childMainViews:_childMainViews];
    _pageContentView.delegate = self;
    [self.view addSubview:_pageContentView];

    // 默认选中第一个
    self.currentIndex = 0;
    [_pageContentView setPageCententViewCurrentIndex:0];
    [self setupScrollToTop];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.searchBar.sd_layout
    .leftEqualToView(self.navigationController.navigationBar)
    .rightEqualToView(self.navigationController.navigationBar)
    .bottomEqualToView(self.navigationController.navigationBar)
    .heightIs(44);
    
    self.selectItemView.sd_layout
    .topSpaceToView(self.view, self.navBarHeight)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(44);
    
    self.pageContentView.sd_layout
    .topSpaceToView(self.selectItemView, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);

}

#pragma mark - navEvent
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private
/// 设置滚动到顶部视图
- (void)setupScrollToTop{
    self.photoView.tableView.scrollsToTop = NO;
    self.photoView.tableView.scrollsToTop = NO;
    self.collectionView.tableView.scrollsToTop = NO;
    [_pageContentView scrollsToTop:NO];
    if (self.currentIndex == 0) {
        self.photoView.tableView.scrollsToTop = YES;
    } else if (self.currentIndex == 1){
        self.photoView.tableView.scrollsToTop = YES;
    } else if (self.currentIndex == 2){
        self.collectionView.tableView.scrollsToTop = YES;
    }
}

#pragma mark - request data

/// 根据下标获取对应的数据
- (void)commonGetData{
    if (KGLOBALINFOMANAGER.networkStatus == NotReachable) {
        [self removeNoNetworkAlertView];
    }
    if (self.searchBar.text.length == 0) {
        return;
    }
    switch (self.currentIndex) {
        case 0:
        {
            if (self.photoView.dataArray.count > 0) return;
            [self getSearchPhotosData];
        }
            break;
        case 1:
        {
            if (self.userView.dataArray.count > 0) return;
            [self getSearchUsersData];
        }
            break;
        case 2:
        {
            if (self.collectionView.dataArray.count > 0) return;
            [self getSearchCollectionsData];
        }
            break;
            
        default:
            break;
    }
}

/**
 请求图片数据
 */
- (void)getSearchPhotosData{
    NSMutableDictionary *dic = [self.networkUserInfo mutableCopy];
    [dic setObject:kGetSearchPhotosDataMethor forKey:kParamMethod];
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:dic];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.query = self.searchBar.text;
    paramModel.page = self.photoView.page;
    paramModel.per_page = 20;
    [manager fetchSearchPhotosByParamModel:paramModel];
}

/**
 请求用户数据
 */
- (void)getSearchUsersData{
    NSMutableDictionary *dic = [self.networkUserInfo mutableCopy];
    [dic setObject:kGetSearchUsersDataMethor forKey:kParamMethod];
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:dic];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.query = self.searchBar.text;
    paramModel.page = self.userView.page;
    paramModel.per_page = 20;
    [manager fetchSearchUsersByParamModel:paramModel];
}

/**
 请求分类数据
 */
- (void)getSearchCollectionsData{
    NSMutableDictionary *dic = [self.networkUserInfo mutableCopy];
    [dic setObject:kGetSearchCollectionsDataMethor forKey:kParamMethod];
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:dic];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.query = self.searchBar.text;
    paramModel.page = self.collectionView.page;
    paramModel.per_page = 20;
    [manager fetchSearchCollectionsPhotosByParamModel:paramModel];
}


#pragma mark - event
- (void)pressNoDataBtnToRefresh{
    [self commonGetData];
}

#pragma mark - DScrollPageContentViewDelegate
- (void)pageContentView:(DScrollPageContentView *)pageContentView targetIndex:(NSInteger)targetIndex{
    [self.view endEditing:YES];
    [self.selectItemView setSelectIndex:targetIndex];
    self.currentIndex = targetIndex;
    // 获取数据
    [self commonGetData];

    [self setupScrollToTop];
}

#pragma mark - UITextFieldDelegate
/// 输入框文本文字改变时调用
- (void)customSearchBar:(DCustomSearchBar *)customSearchBar textFieldDidChange:(UITextField *)textField{
    
}

/// 点击键盘搜索时
- (BOOL)customSearchBarDidClickSearchBtn:(DCustomSearchBar *)customSearchBar text:(NSString *)text{
    if (text.length == 0) {
        return NO;
    }
    [self clearData];
    [self commonGetData];
    return YES;
}


/// 点击取消按钮时
- (void)customSearchBarDidClickCancelBtn:(DCustomSearchBar *)customSearchBar{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{

    [self removeNoDataView];
    NSString *method = [userInfo objectForKey:kParamMethod];
    if ([kGetSearchPhotosDataMethor isEqualToString:method]) {
        if (self.currentIndex != 0) {
            return;
        }
        [self.photoView requestServiceSucceedWithModel:dataModel userInfo:userInfo];
    } else if ([kGetSearchUsersDataMethor isEqualToString:method]) {
        if (self.currentIndex != 1) {
            return;
        }
        [self.userView requestServiceSucceedWithModel:dataModel userInfo:userInfo];
    } else if ([kGetSearchCollectionsDataMethor isEqualToString:method]) {
        if (self.currentIndex != 2) {
            return;
        }
        [self.collectionView requestServiceSucceedWithModel:dataModel userInfo:userInfo];
    }
}

- (void)hasNotMoreData{
    switch (self.currentIndex) {
        case 0:
            [self.photoView hasNotMoreData];
            break;
        case 1:
            [self.userView hasNotMoreData];
            break;
        case 2:
            [self.collectionView hasNotMoreData];
            break;
            
        default:
            break;
    }
}

- (void)clearData{
    switch (self.currentIndex) {
        case 0:
            [self.photoView clearData];
            break;
        case 1:
            [self.userView clearData];
            break;
        case 2:
            [self.collectionView clearData];
            break;
            
        default:
            break;
    }
}

- (void)alertNoData{
    [self setNoNetworkDelegate:self];
    switch (self.currentIndex) {
        case 0:
            [self.photoView alertNoData];
            break;
        case 1:
            [self.userView alertNoData];
            break;
        case 2:
            [self.collectionView alertNoData];
            break;
            
        default:
            break;
    }
}


#pragma mark getter & setter

- (DCustomSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[DCustomSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.searchBarBackgroundColor = DSystemColorWhite;
        _searchBar.searchBarHeight = 34.0;
        _searchBar.promptImage = [UIImage getImageWithName:@"search_bar_search_icon"];
        _searchBar.tintColor = [UIColor blackColor];
        _searchBar.promptImageEdage = 10.0;
        _searchBar.cancelLeftEdage = 12.0;
        _searchBar.searchBarLRMargin = 8.0;
        _searchBar.showCancelButton = YES;
        _searchBar.cancelName = kLocalizedLanguage(@"seCancelName");
        _searchBar.cancelColor = DSystemColorWhite;
        _searchBar.cancelFont = DSystemFontTitle;
        _searchBar.placeholder = kLocalizedLanguage(@"sePlaceholder");
        _searchBar.delegate = self;
    }
    return _searchBar;
}


- (DMWPhotosManager *)manager{
    if (!_manager) {
        _manager = [[DMWPhotosManager alloc] init];
        _manager.longPressType = DMWPhotosManagerTypeForSaveDownLoadLike;
    }
    return _manager;
}

@end
