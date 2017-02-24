//
//  DCollectionDetailsController.m
//  ShareImage
//
//  Created by FTY on 2017/2/24.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionDetailsController.h"
#import "DCollectionDetailsCell.h"

#import "DCollectionsAPIManager.h"

#import "DCollectionsParamModel.h"

#import <MJRefresh/MJRefresh.h>

@interface DCollectionDetailsController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) long long collectionId;
@end

@implementation DCollectionDetailsController

- (instancetype)initWithCollectionId:(long long)collectionId{
    self = [super init];
    if (self) {
        self.collectionId = collectionId;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.navLeftItemType = DNavigationItemTypeBack;
    self.title = @"photos";
    
    // 初始化上下拉刷新
    [self setupTableViewUpAndDowmLoad];
    // 获取数据
    [self getPhotosData];
    
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
    .topEqualToView(self.view)
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0);
}

- (void)getPhotosData{
    DCollectionsAPIManager *manager = [DCollectionsAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DCollectionsParamModel *paramModel = [[DCollectionsParamModel alloc] init];
    paramModel.collection_id = self.collectionId;
    paramModel.page = self.page;
    paramModel.per_page = 20;
    [manager fetchCollectionPhotosByParamModel:paramModel];
}


/**
 设置上下拉刷新
 */
- (void)setupTableViewUpAndDowmLoad{
    @weakify(self);
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self getPhotosData];
        });
    }];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCollectionDetailsCell *cell = [DCollectionDetailsCell cellWithTableView:tableView];
    
    if (self.photos.count > indexPath.row) {
        cell.photosModel = self.photos[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.photos[indexPath.row];
    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"photosModel" cellClass:[DCollectionDetailsCell class] contentViewWidth:self.view.width];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    
    
    
}

#pragma mark - 请求回调
- (void)requestServiceSucceedBackArray:(NSArray *)arrData userInfo:(NSDictionary *)userInfo{
    
    self.page++;
    [self.photos addObjectsFromArray:arrData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)unlockUI{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)clearData{
    [self.photos removeAllObjects];
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    }
    return _tableView;
}

- (NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

@end