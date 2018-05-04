//
//  DSearchUserView.m
//  ShareImage
//
//  Created by FTY on 2018/5/3.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import "DSearchUserView.h"
#import "DUITableView.h"
#import "DSearchViewCell.h"
#import "DSearchUsersModel.h"

#import "DPhotosAPIManager.h"
#import "DPhotosParamModel.h"
#import "DSearchViewController.h"
#import "DUserProfileViewController.h"

#import <MJRefresh/MJRefresh.h>

@interface DSearchUserView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *footerView;
@end

@implementation DSearchUserView

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
        cell.userModel = self.dataArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.dataArray.count > indexPath.row) {
        DUserModel *userModel = self.dataArray[indexPath.row];
        DUserProfileViewController *userController = [[DUserProfileViewController alloc] initWithUserName:userModel.username type:DUserProfileTypeForOther];
        [self.mainController.navigationController pushViewController:userController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 64, 0, 0)];
}

#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    
    DSearchUsersModel *usersModel = dataModel;
    [self.dataArray addObjectsFromArray:usersModel.users];
    
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
        _tableView.rowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
                [self.mainController getSearchUsersData];
            });
        }];
        _footerView.stateLabel.hidden = YES;
    }
    return _footerView;
}



@end
