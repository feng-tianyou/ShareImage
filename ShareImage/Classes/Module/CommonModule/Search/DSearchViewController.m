//
//  DSearchViewController.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/1.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchViewController.h"

@interface DSearchViewController ()<UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;



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
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    [self.filteredCities removeAllObjects];
//    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchController.searchBar.text];
//    self.filteredCities = [[self.allCities filteredArrayUsingPredicate:searchPredicate] mutableCopy];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//    });
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    id model = self.photos[indexPath.section];
//    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"photosModel" cellClass:[DHomeTableViewCell class] contentViewWidth:self.view.width];
//    return height;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}


#pragma mark getter & setter

- (UISearchController *)searchBarController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = false;
        [_searchController.searchBar sizeToFit];
        _searchController.searchBar.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    }
    return _searchController;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.backgroundColor = DSystemColorGray;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}



@end
