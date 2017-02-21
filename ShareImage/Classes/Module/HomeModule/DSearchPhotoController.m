//
//  DSearchPhotoController.m
//  ShareImage
//
//  Created by FTY on 2017/2/21.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchPhotoController.h"

@interface DSearchPhotoController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation DSearchPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.searchBar];
    
    self.searchBar.sd_layout
    .topSpaceToView(self.view, self.navBarHeight)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(44);
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}


#pragma mark - getter & setter
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
    }
    return _searchBar;
}


@end
