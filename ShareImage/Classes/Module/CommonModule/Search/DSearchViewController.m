//
//  DSearchViewController.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/1.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchViewController.h"
#import "DSearchSelectItemView.h"
#import "DSearchBar.h"

#import "DSearchViewCell.h"

#import "DPhotosAPIManager.h"
#import "DPhotosParamModel.h"

#import "DSearchPhotosModel.h"
#import "DSearchUsersModel.h"
#import "DSearchCollectionsModel.h"

#import <MJRefresh/MJRefresh.h>


@interface DSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) DSearchSelectItemView *selectItemView;
@property (nonatomic, strong) DSearchBar *searchBar;

@property (nonatomic, strong) MJRefreshAutoNormalFooter *footerView;

@end

@implementation DSearchViewController

- (instancetype)initWithSearchType:(SearchType)searchType{
    self = [super init];
    if (self) {
        _searchType = searchType;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Search";
    self.page = 1;
    self.navLeftItemType = DNavigationItemTypeWriteBack;
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.selectItemView];
    
    [self setupTableViewDownRefresh];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.tableView.sd_layout
    .topSpaceToView(self.searchBar, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    self.selectItemView.sd_layout
    .topSpaceToView(self.searchBar, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
}

#pragma mark - navEvent
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private
/**
 下拉刷新
 */
- (void)setupTableViewDownRefresh{
    @weakify(self)
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self getMoreData];
        });
    }];
}

/**
 获取更多数据
 */
- (void)getMoreData{
    [self getCommonDataWithPage:self.page];
}

/**
 清除搜索数据
 */
- (void)clickClearText{
    self.searchBar.searchTextField.text = @"";
    [self.selectItemView hide];
    [self.searchBar.searchTextField resignFirstResponder];
}

/**
 请求图片数据
 */
- (void)getSearchPhotosDataWithPage:(NSInteger)page{
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.query = self.searchBar.searchTextField.text;
    paramModel.page = page;
    paramModel.per_page = 20;
    [manager fetchSearchPhotosByParamModel:paramModel];
}

/**
 请求用户数据
 */
- (void)getSearchUsersDataWithPage:(NSInteger)page{
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.query = self.searchBar.searchTextField.text;
    paramModel.page = page;
    paramModel.per_page = 20;
    [manager fetchSearchUsersByParamModel:paramModel];
}

/**
 请求分类数据
 */
- (void)getSearchCollectionsDataWithPage:(NSInteger)page{
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.query = self.searchBar.searchTextField.text;
    paramModel.page = page;
    paramModel.per_page = 20;
    [manager fetchSearchCollectionsPhotosByParamModel:paramModel];
}

/**
 获取数据

 @param page 页数
 */
- (void)getCommonDataWithPage:(NSInteger)page{
    switch (_searchType) {
        case PhotoSearchType:
        {
            [self getSearchPhotosDataWithPage:page];
        }
            break;
        case UserSearchType:
        {
            [self getSearchUsersDataWithPage:page];
        }
            break;
        case CollectionSearchType:
        {
            [self getSearchCollectionsDataWithPage:page];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 点击事件
/**
 点击刷新
 */
- (void)clcikRefreshButton{
    [self getCommonDataWithPage:1];
}


/**
 点击搜索图片
 */
- (void)clickSearchPhotos:(UIButton *)button{
    [self.selectItemView didCilckButton:button];
    _searchType = PhotoSearchType;
    self.title = @"PHOTOS";
}

/**
 点击搜索用户
 */
- (void)clickSearchUsers:(UIButton *)button{
    [self.selectItemView didCilckButton:button];
    _searchType = UserSearchType;
    self.title = @"USERS";
}

/**
 点击搜索分类
 */
- (void)clickSearchCollections:(UIButton *)button{
    [self.selectItemView didCilckButton:button];
    _searchType = CollectionSearchType;
    self.title = @"COLLECTIONS";
}



#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DSearchViewCell *cell = [DSearchViewCell cellWithTableView:tableView];
    
    switch (_searchType) {
        case PhotoSearchType:
        {
            cell.searchType = PhotoSearchType;
            if (self.dataArray.count > indexPath.row) {
                cell.photoModel = self.dataArray[indexPath.row];
            }
        }
            break;
        case UserSearchType:
        {
            cell.searchType = UserSearchType;
            if (self.dataArray.count > indexPath.row) {
                cell.userModel = self.dataArray[indexPath.row];
            }
        }
            break;
        case CollectionSearchType:
        {
            cell.searchType = CollectionSearchType;
            if (self.dataArray.count > indexPath.row) {
                cell.collectionModel = self.dataArray[indexPath.row];
            }
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_searchType == PhotoSearchType) {
        return 150;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DLog(@"textFieldShouldReturn---%@", textField.text);
    [textField resignFirstResponder];
    [self.selectItemView hide];
    if (textField.text.length == 0) {
        return YES;
    }
    [self getCommonDataWithPage:1];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.selectItemView show];
    return YES;
}


#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    
    switch (_searchType) {
        case PhotoSearchType:
        {
            DSearchPhotosModel *photosModel = dataModel;
            [self.dataArray addObjectsFromArray:photosModel.photos];
        }
            break;
        case UserSearchType:
        {
            DSearchUsersModel *usersModel = dataModel;
            [self.dataArray addObjectsFromArray:usersModel.users];
        }
            break;
        case CollectionSearchType:
        {
            DSearchCollectionsModel *collectionsModel = dataModel;
            [self.dataArray addObjectsFromArray:collectionsModel.collections];
        }
            break;
            
        default:
            break;
    }
    
    [self.tableView.mj_footer endRefreshing];
    self.tableView.hidden = NO;
    _footerView.stateLabel.hidden = NO;
    [self.tableView reloadData];
    [self.tableView setTableFooterView:[UIView new]];
    self.page++;
}

- (void)hasNotMoreData{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)clearData{
    [self.dataArray removeAllObjects];
}

- (void)alertNoData{
    self.tableView.hidden = NO;
    _footerView.stateLabel.hidden = YES;
    [self clearData];
    DNoDataView *noDataView = [[DNoDataView alloc] init];
    noDataView.titleLabel.text = @"Very Sorry\n No Information You Want";
    [noDataView.refreshButton addTarget:self action:@selector(clcikRefreshButton) forControlEvents:UIControlEventTouchUpInside];
    [noDataView setFrame:0 y:55 w:self.view.width h:self.view.height - 55];
    [self.tableView setTableFooterView:noDataView];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    [self.tableView reloadData];
}


#pragma mark getter & setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.hidden = YES;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (DSearchSelectItemView *)selectItemView{
    if (!_selectItemView) {
        _selectItemView = [[DSearchSelectItemView alloc] init];
        _selectItemView.hidden = YES;
        [_selectItemView.photoBtn addTarget:self action:@selector(clickSearchPhotos:) forControlEvents:UIControlEventTouchUpInside];
        [_selectItemView.userBtn addTarget:self action:@selector(clickSearchUsers:) forControlEvents:UIControlEventTouchUpInside];
        [_selectItemView.collectionBtn addTarget:self action:@selector(clickSearchCollections:) forControlEvents:UIControlEventTouchUpInside];
        switch (_searchType) {
            case PhotoSearchType:
                _selectItemView.photoBtn.selected = YES;
                break;
            case UserSearchType:
                _selectItemView.userBtn.selected = YES;
                break;
            case CollectionSearchType:
                _selectItemView.collectionBtn.selected = YES;
                break;
            case OtherSearchType:
                _selectItemView.photoBtn.selected = YES;
                break;
                
            default:
                break;
        }
        
    }
    return _selectItemView;
}

- (DSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[DSearchBar alloc] init];
        [_searchBar setFrame:0 y:self.navBarHeight w:SCREEN_WIDTH h:55];
        _searchBar.backgroundColor = [UIColor setHexColor:@"#141515"];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"Search..." attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _searchBar.searchTextField.attributedPlaceholder = attr;
        _searchBar.searchTextField.textColor = [UIColor whiteColor];
        [_searchBar.clearButton addTarget:self action:@selector(clickClearText) forControlEvents:UIControlEventTouchUpInside];
        _searchBar.searchTextField.returnKeyType = UIReturnKeySearch;
        _searchBar.searchTextField.delegate = self;
    }
    return _searchBar;
}

- (MJRefreshAutoNormalFooter *)footerView{
    if (!_footerView) {
        @weakify(self);
        _footerView = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @strongify(self);
                [self getMoreData];
            });
        }];
        _footerView.stateLabel.hidden = YES;
    }
    return _footerView;
}

@end
