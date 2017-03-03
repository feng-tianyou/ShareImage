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
    self.navLeftItemType = DNavigationItemTypeWriteBack;
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.selectItemView];
    
    [self setupTableViewDownRefresh];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
    
    self.tableView.sd_layout
    .topSpaceToView(self.view, 55)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    self.selectItemView.sd_layout
    .topSpaceToView(self.view, 55)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
}


- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private
- (void)setupTableViewDownRefresh{
    @weakify(self)
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self getMoreData];
        });
    }];
}

- (void)getMoreData{
    switch (_searchType) {
        case PhotoSearchType:
        {
            [self getSearchPhotosDataWithPage:self.page];
        }
            break;
        case UserSearchType:
        {
            [self getSearchUsersDataWithPage:self.page];
        }
            break;
        case CollectionSearchType:
        {
            [self getSearchCollectionsDataWithPage:self.page];
        }
            break;
            
        default:
            break;
    }
}

- (void)clickClearText{
    self.searchBar.searchTextField.text = @"";
    [self.selectItemView hide];
    [self.searchBar.searchTextField resignFirstResponder];
}

- (void)clickSearchPhotos{
    [self.selectItemView hide];
    [self.searchBar.searchTextField resignFirstResponder];
    
    if (self.searchBar.searchTextField.text.length == 0) {
        return;
    }
    
    _searchType = PhotoSearchType;
    [self getSearchPhotosDataWithPage:1];
    
}

- (void)clickSearchUsers{
    [self.selectItemView hide];
    [self.searchBar.searchTextField resignFirstResponder];
    
    if (self.searchBar.searchTextField.text.length == 0) {
        return;
    }
    
    _searchType = UserSearchType;
    [self getSearchUsersDataWithPage:1];
    
}

- (void)clickSearchCollections{
    [self.selectItemView hide];
    [self.searchBar.searchTextField resignFirstResponder];
    
    if (self.searchBar.searchTextField.text.length == 0) {
        return;
    }
    
    _searchType = CollectionSearchType;
    [self getSearchCollectionsDataWithPage:1];
}

- (void)getSearchPhotosDataWithPage:(NSInteger)page{
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.query = self.searchBar.searchTextField.text;
    paramModel.page = page;
    paramModel.per_page = 20;
    [manager fetchSearchPhotosByParamModel:paramModel];
}

- (void)getSearchUsersDataWithPage:(NSInteger)page{
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.query = self.searchBar.searchTextField.text;
    paramModel.page = page;
    paramModel.per_page = 20;
    [manager fetchSearchUsersByParamModel:paramModel];
}

- (void)getSearchCollectionsDataWithPage:(NSInteger)page{
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.query = self.searchBar.searchTextField.text;
    paramModel.page = page;
    paramModel.per_page = 20;
    [manager fetchSearchCollectionsPhotosByParamModel:paramModel];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    switch (_searchType) {
        case PhotoSearchType:
        {
            DPhotosModel *photo = self.dataArray[indexPath.row];
            cell.textLabel.text = photo.pid;
        }
            break;
        case UserSearchType:
        {
            DUserModel *user = self.dataArray[indexPath.row];
            cell.textLabel.text = user.username;
        }
            break;
        case CollectionSearchType:
        {
            DCollectionsModel *collection = self.dataArray[indexPath.row];
            cell.textLabel.text = collection.title;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    id model = self.photos[indexPath.section];
//    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"photosModel" cellClass:[DHomeTableViewCell class] contentViewWidth:self.view.width];
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DLog(@"textFieldShouldReturn---%@", textField.text);
    [textField resignFirstResponder];
    [self clickSearchPhotos];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    DLog(@"shouldChangeCharactersInRange---%@--%@", textField.text, string);
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
    [self.tableView reloadData];
    self.page++;
}

- (void)hasNotMoreData{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)clearData{
    [self.dataArray removeAllObjects];
}


#pragma mark getter & setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.hidden = YES;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        [_selectItemView.photoBtn addTarget:self action:@selector(clickSearchPhotos) forControlEvents:UIControlEventTouchUpInside];
        [_selectItemView.userBtn addTarget:self action:@selector(clickSearchUsers) forControlEvents:UIControlEventTouchUpInside];
        [_selectItemView.collectionBtn addTarget:self action:@selector(clickSearchCollections) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectItemView;
}

- (DSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[DSearchBar alloc] init];
        [_searchBar setFrame:0 y:0 w:SCREEN_WIDTH h:55];
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


@end
