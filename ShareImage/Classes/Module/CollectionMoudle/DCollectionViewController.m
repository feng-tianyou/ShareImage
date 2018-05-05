//
//  DCollectionViewController.m
//  ShareImage
//
//  Created by FTY on 2017/2/23.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionViewController.h"
#import "DCommonPhotoController.h"
#import "DSearchViewController.h"

#import "DCollectionViewCell.h"
#import "DSelectItemView.h"

#import "DCollectionsAPIManager.h"
#import "DCollectionsParamModel.h"
#import "DCollectionsModel.h"
#import <MJRefresh/MJRefresh.h>

static NSString * const cellID = @"collection";
static NSString * const kGetFeaturedCollectionsData = @"getFeaturedCollectionsData";
static NSString * const kGetCuratedCollectionsData = @"getCuratedCollectionsData";

typedef NS_ENUM(NSInteger, CollectionType) {
    FeaturedCollectionType,
    CuratedCollectionType
};

@interface DCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collections;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *footerView;
@property (nonatomic, strong) DSelectItemView *selectItemView;
@property (nonatomic, assign) CollectionType type;
@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation DCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    self.navRighItemType = DNavigationItemTypeRightSearch;

    [self setupSubViews];
    [self getFeaturedCollectionsData];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}


#pragma mark - 私有方法
- (void)setupSubViews{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.selectItemView];
    
    self.collectionView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    self.selectItemView.sd_layout
    .topSpaceToView(self.view, self.navBarHeight)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(46);
    
    self.collectionView.mj_footer = self.footerView;
}

- (void)getFeaturedCollectionsData{
    NSMutableDictionary *dic = [self.networkUserInfo mutableCopy];
    [dic setObject:kGetFeaturedCollectionsData forKey:kParamMethod];
    DCollectionsAPIManager *manager = [DCollectionsAPIManager getHTTPManagerByDelegate:self info:dic];
    DCollectionsParamModel *paramModel = [[DCollectionsParamModel alloc] init];
    paramModel.page = self.page;
    paramModel.per_page = 10;
    [manager fetchFeaturedCollectionsByParamModel:paramModel];
    
}

- (void)getCuratedCollectionsData{
    NSMutableDictionary *dic = [self.networkUserInfo mutableCopy];
    [dic setObject:kGetCuratedCollectionsData forKey:kParamMethod];
    DCollectionsAPIManager *manager = [DCollectionsAPIManager getHTTPManagerByDelegate:self info:dic];
    DCollectionsParamModel *paramModel = [[DCollectionsParamModel alloc] init];
    paramModel.page = self.page;
    paramModel.per_page = 10;
    [manager fetchCuratedCollectionsByParamModel:paramModel];
    
}

- (void)pressNoDataBtnToRefresh{
    self.page = 1;
    if (self.type == FeaturedCollectionType) {
        [self getFeaturedCollectionsData];
    } else {
        [self getCuratedCollectionsData];
    }
}


- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (!isLeft) {
        DSearchViewController *searchView = [[DSearchViewController alloc] initWithSearchType:CollectionSearchType];
        [self.navigationController pushViewController:searchView animated:YES];
    }
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
        DCommonPhotoController *detaildController = nil;
        if (self.type == FeaturedCollectionType) {
            detaildController = [[DCommonPhotoController alloc] initWithTitle:model.title type:CollectionAPIManagerType];
            
        } else {
            detaildController = [[DCommonPhotoController alloc] initWithTitle:model.title type:CollectionAPIManagerCuratedType];
        }
        detaildController.collectionId = model.c_id;
        [self.navigationController pushViewController:detaildController animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y > 0) {
        if (offset.y > self.offsetY) {
            self.selectItemView.alpha = 0.0;
        } else {
            self.selectItemView.alpha = 1.0;
        }
        self.offsetY = offset.y;
    } else {
        self.selectItemView.alpha = 1.0;
    }
}

#pragma mark - requet
- (void)requestServiceSucceedBackArray:(NSArray *)arrData userInfo:(NSDictionary *)userInfo{
    NSString *method = [userInfo objectForKey:kParamMethod];
    if ([kGetFeaturedCollectionsData isEqualToString:method] && self.type != FeaturedCollectionType) {
        return;
    }
    if ([kGetCuratedCollectionsData isEqualToString:method] && self.type != CuratedCollectionType) {
        return;
    }
    self.page++;
    [self.collections addObjectsFromArray:arrData];
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView reloadData];
    self.footerView.stateLabel.hidden = NO;
    [self removeNoDataView];
}

- (void)hasNotMoreData{
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    self.footerView.stateLabel.hidden = YES;
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

- (void)clearData{
    self.page = 1;
    [self.collections removeAllObjects];
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

- (MJRefreshAutoNormalFooter *)footerView{
    if (!_footerView) {
        @weakify(self);
        _footerView = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @strongify(self);
                if (self.type == FeaturedCollectionType) {
                    [self getFeaturedCollectionsData];
                } else {
                    [self getCuratedCollectionsData];
                }
            });
        }];
        _footerView.stateLabel.hidden = YES;
    }
    return _footerView;
}


- (DSelectItemView *)selectItemView{
    if (!_selectItemView) {
        _selectItemView = [[DSelectItemView alloc] initWithTitles:@[kLocalizedLanguage(@"colFeatured"), kLocalizedLanguage(@"colCurated")]];
        _selectItemView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        _selectItemView.itemNormalColor = DSystemColorWhite;
        _selectItemView.itemHighLightColor = DSystemColorBlue33AACC;
        _selectItemView.moveLineColor = DSystemColorBlue33AACC;
        _selectItemView.itemFont = [UIFont fontWithName:@"Verdana-Bold" size:15.0];
        _selectItemView.hideBottomLine = YES;
        @weakify(self)
        [_selectItemView setClickItemBlock:^(NSInteger integer) {
            @strongify(self)
            self.page = 1;
            if (integer == 0) {
                self.type = FeaturedCollectionType;
                [self getFeaturedCollectionsData];
            } else {
                self.type = CuratedCollectionType;
                [self getCuratedCollectionsData];
            }
            [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }];
    }
    return _selectItemView;
}

@end
