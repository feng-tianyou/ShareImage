//
//  DSearchPhotoView.m
//  ShareImage
//
//  Created by FTY on 2018/5/3.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import "DSearchPhotoView.h"
#import "DUITableView.h"
#import "DSearchViewCell.h"
#import "DMWPhotosManager.h"
#import "DSearchPhotosModel.h"

#import "DPhotosAPIManager.h"
#import "DPhotosParamModel.h"
#import "DSearchViewController.h"

#import <MJRefresh/MJRefresh.h>

@interface DSearchPhotoView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) MJRefreshAutoNormalFooter *footerView;
@property (nonatomic, strong) DMWPhotosManager *manager;
@end

@implementation DSearchPhotoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _page = 1;
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [self endEditing:YES];
    DSearchViewCell *cell = [DSearchViewCell cellWithTableView:tableView];
    if (self.dataArray.count > indexPath.row) {
        cell.photoModel = self.dataArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.dataArray.count > indexPath.row) {
        [self.manager photoPreviewWithPhotoModels:self.dataArray currentIndex:indexPath.row currentViewController:(UIViewController *)self.mainController];
    }
}

#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    
    DSearchPhotosModel *photosModel = dataModel;
    [self.dataArray addObjectsFromArray:photosModel.photos];
    
    [self.tableView.mj_footer endRefreshing];
    _footerView.stateLabel.hidden = NO;
    [self.tableView reloadData];
    [self.tableView setTableFooterView:[UIView new]];
    _page++;
}

- (void)hasNotMoreData{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)clearData{
    _page = 1;
    [self.dataArray removeAllObjects];
}

- (void)alertNoData{
    [self clearData];
    _footerView.stateLabel.hidden = YES;
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    [self.tableView reloadData];
    [self.mainController addNoDataViewAddInView:self.tableView];
}



#pragma mark - getter & setter
- (DUITableView *)tableView{
    if (!_tableView) {
        _tableView = [[DUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 180;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = DSystemColorGrayF3F3F3;
        _tableView.mj_footer = self.footerView;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (MJRefreshAutoNormalFooter *)footerView{
    if (!_footerView) {
        @weakify(self);
        _footerView = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @strongify(self);
                [self.mainController getSearchPhotosData];
            });
        }];
        _footerView.stateLabel.hidden = YES;
    }
    return _footerView;
}

- (DMWPhotosManager *)manager{
    if (!_manager) {
        _manager = [[DMWPhotosManager alloc] init];
        _manager.longPressType = DMWPhotosManagerTypeForSaveDownLoadLike;
    }
    return _manager;
}
@end
