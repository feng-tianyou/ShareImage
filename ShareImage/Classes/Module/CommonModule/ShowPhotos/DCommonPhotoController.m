//
//  DCommonPhotoController.m
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCommonPhotoController.h"
#import "DPhotoDetailController.h"
#import "DCommonPhotosCell.h"
#import "DSwipeViewController.h"

#import "DUserAPIManager.h"
#import "DCollectionsAPIManager.h"
#import "DUserParamModel.h"
#import "DCollectionsParamModel.h"
#import "DPhotosModel.h"

#import "DPhotoManager.h"

#import <MJRefresh/MJRefresh.h>

static NSString * const cellID = @"collectionPhotos";

@interface DCommonPhotoController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *photoUrls;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) APIManagerType type;
@property (nonatomic, strong) DPhotoManager *manager;

@property (nonatomic, copy) NSString *navTitle;


@property (nonatomic, strong) MJRefreshAutoNormalFooter *footerView;

@end

@implementation DCommonPhotoController

- (instancetype)initWithTitle:(NSString *)title type:(APIManagerType)type{
    self = [super init];
    if (self) {
        self.type = type;
        self.title = title;
        self.navTitle = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    self.navLeftItemType = DNavigationItemTypeBack;
    [self getPhotosData];
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
    .topSpaceToView(self.view, self.navBarHeight)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    self.collectionView.mj_footer = self.footerView;
}

- (void)getPhotosData{
    switch (self.type) {
        case UserAPIManagerType:
        {
            DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
            DUserParamModel *paramModel = [[DUserParamModel alloc] init];
            paramModel.username = self.username;
            paramModel.page = self.page;
            paramModel.per_page = 20;
            [manager fetchUserPhotosByParamModel:paramModel];
        }
            break;
        case CollectionAPIManagerType:
        {
            DCollectionsAPIManager *manager = [DCollectionsAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
            DCollectionsParamModel *paramModel = [[DCollectionsParamModel alloc] init];
            paramModel.collection_id = self.collectionId;
            paramModel.page = self.page;
            paramModel.per_page = 20;
            [manager fetchCollectionPhotosByParamModel:paramModel];
        }
            break;
            
        default:
            break;
    }
}

- (void)pressNoDataBtnToRefresh{
    self.page = 1;
    [self getPhotosData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DCommonPhotosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (self.photos.count > indexPath.row) {
        cell.photoModel = self.photos[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.photos.count > indexPath.row) {
//        DPhotoDetailController *detailController = [[DPhotoDetailController alloc] initWithPhotoModel:self.photos[indexPath.row]];
//        [self.navigationController pushViewController:detailController animated:YES];
//        self.manager  = [DPhotoManager manager];
//        [self.manager photoPreviewWithPhotoUrls:self.photoUrls currentIndex:indexPath.row currentViewController:self];
        
        DSwipeViewController *swip = [[DSwipeViewController alloc] initWithTitle:self.navTitle photoModels:self.photos index:indexPath.row];
        [self.navigationController pushViewController:swip animated:YES];
    }
}

#pragma mark - requet
- (void)requestServiceSucceedBackArray:(NSArray *)arrData userInfo:(NSDictionary *)userInfo{
    self.page++;
    [self.photos addObjectsFromArray:arrData];
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView reloadData];
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arrData.count];
    [arrData enumerateObjectsUsingBlock:^(DPhotosModel *photoModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (photoModel.urls.small.length > 0) {
            [tmpArr addObject:photoModel.urls.small];
        }
    }];
    [self.photoUrls addObjectsFromArray:tmpArr];
    
    
    self.footerView.stateLabel.hidden = NO;
    [self removeNoDataView];
}

- (void)hasNotMoreData{
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}

- (void)clearData{
    [self.photos removeAllObjects];
    [self.photoUrls removeAllObjects];
}

- (void)alertNoData{
    [self clearData];
    self.footerView.stateLabel.hidden = YES;
    self.noDataView.titleLabel.text = @"Very Sorry\n No Users You Have";
    
    [self addNoDataViewAddInView:self.collectionView];
    self.noNetworkDelegate = self;
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    [self.collectionView reloadData];
}


#pragma mark - setter & getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 10.0;
        layout.minimumLineSpacing = 10.0;
        //设置每个item的大小
        CGFloat wh = (SCREEN_WIDTH - 30)/4;
        layout.itemSize = CGSizeMake(wh, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册item类型 这里使用系统的类型
        [_collectionView registerClass:[DCommonPhotosCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (NSMutableArray *)photoUrls{
    if (!_photoUrls) {
        _photoUrls = [NSMutableArray array];
    }
    return _photoUrls;
}

- (MJRefreshAutoNormalFooter *)footerView{
    if (!_footerView) {
        @weakify(self);
        _footerView = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @strongify(self);
                [self getPhotosData];
            });
        }];
        _footerView.stateLabel.hidden = YES;
    }
    return _footerView;
}


@end
