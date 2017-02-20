//
//  DHomeViewController.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DHomeViewController.h"
#import "DHomeTableViewCell.h"
#import "DPhotosAPIManager.h"

#import "DPhotosParamModel.h"
#import "DPhotosModel.h"

#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>


@interface DHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, assign) NSInteger page;


@end

@implementation DHomeViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.navLeftItemType = DNavigationItemTypeRightAdd;
    
    // 初始化上下拉刷新
    [self setupTableViewUpAndDowmLoad];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
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
    .topSpaceToView(self.view, self.navBarHeight)
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0);
}

- (void)getPhotosData{
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.page = self.page;
    paramModel.per_page = 20;
    [manager fetchPhotosByParamModel:paramModel];
}


/**
 设置上下拉刷新
 */
- (void)setupTableViewUpAndDowmLoad{
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            self.page = 1;
            [self getPhotosData];
        });
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
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
    DHomeTableViewCell *cell = [DHomeTableViewCell cellWithTableView:tableView];
    [cell setClickIconBlock:^{
        DLog(@"点击头像");
    }];
    if (self.photos.count > indexPath.row) {
        cell.photosModel = self.photos[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.photos[indexPath.row];
    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"photosModel" cellClass:[DHomeTableViewCell class] contentViewWidth:self.view.width];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    DPhotosModel *model = self.photos[indexPath.row];
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
    paramModel.pid = model.pid;
    
    [manager fetchPhotoDetailsByParamModel:paramModel];
//    [manager fetchPhotoStatsByParamModel:paramModel];
//    [manager fetchPhotoDownloadLinkByParamModel:paramModel];
    
    
    
    
}

#pragma mark - 导航栏点击事件
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (isLeft) {
        //        NSLog(@"点击了左按钮");
        //        [self localShowSuccess:@"点击了左按钮"];
        
        // 随机获取单张照片
        //        DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
        //        DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
        //        [manager fetchRandomPhotoByParamModel:paramModel];
//        [SVProgressHUD showWithStatus:@"hahahhahah"];
        [self getPhotosData];
        
    } else {
        NSLog(@"点击了右按钮");
        [self localShowSuccess:@"点击了右按钮"];
    }
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
