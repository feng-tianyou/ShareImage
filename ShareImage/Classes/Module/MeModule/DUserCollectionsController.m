//
//  DUserCollectionsController.m
//  ShareImage
//
//  Created by FTY on 2017/3/6.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DUserCollectionsController.h"
#import "DCommonPhotoController.h"
#import "DCollectionViewCell.h"
#import "DUserAPIManager.h"
#import "DUserParamModel.h"
#import "DCollectionsModel.h"
#import <MJRefresh/MJRefresh.h>

static NSString * const cellID = @"userCollection";

@interface DUserCollectionsController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collections;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) DNoDataView *noDataView;
@end

@implementation DUserCollectionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = KGLOBALINFOMANAGER.accountInfo.username;
    self.navLeftItemType = DNavigationItemTypeBack;
    self.page = 1;
    [self getCollectionsData];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self setupSubViews];
}

#pragma mark - navEvent
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 私有方法
- (void)setupSubViews{
    [self.view addSubview:self.collectionView];
    
    self.collectionView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    @weakify(self)
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self getCollectionsData];
        });
    }];
}

- (void)getCollectionsData{
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DUserParamModel *paramModel = [[DUserParamModel alloc] init];
    paramModel.username = KGLOBALINFOMANAGER.accountInfo.username;
    paramModel.page = self.page;
    paramModel.per_page = 20;
    [manager fetchUserCollectionsByParamModel:paramModel];
}

- (void)clcikRefreshButton{
    self.page = 1;
    [self getCollectionsData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collections.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (self.collections.count > indexPath.row) {
        DCollectionsModel *model = self.collections[indexPath.row];
        cell.collection = model;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.collections.count > indexPath.row) {
        DCollectionsModel *model = self.collections[indexPath.row];
        DCommonPhotoController *detaildController = [[DCommonPhotoController alloc] initWithTitle:model.title type:CollectionAPIManagerType];
        detaildController.collectionId = model.c_id;
        [self.navigationController pushViewController:detaildController animated:YES];
    }
}

#pragma mark - requet
- (void)requestServiceSucceedBackArray:(NSArray *)arrData userInfo:(NSDictionary *)userInfo{
    self.collectionView.hidden = NO;
    self.page++;
    [self.collections addObjectsFromArray:arrData];
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView reloadData];
    [self.noDataView removeFromSuperview];
}

- (void)hasNotMoreData{
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}

- (void)alertNoData{
    [self.noDataView setFrame:0 y:0 w:self.view.width h:self.view.height];
    self.collectionView.hidden = YES;
    [self.view addSubview:self.noDataView];
}



#pragma mark - setter & getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 0.0;
        layout.minimumLineSpacing = 0.0;
        //设置每个item的大小为100*100
        CGFloat wh = SCREEN_WIDTH/2;
        layout.itemSize = CGSizeMake(wh, wh);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册item类型 这里使用系统的类型
        [_collectionView registerClass:[DCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSMutableArray *)collections{
    if (!_collections) {
        _collections = [NSMutableArray array];
    }
    return _collections;
}

- (DNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[DNoDataView alloc] init];
        _noDataView.titleLabel.text = @"Very Sorry\n No Collections You Have";
        [_noDataView.refreshButton addTarget:self action:@selector(clcikRefreshButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noDataView;
}


@end
