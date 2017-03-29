//
//  DHomeMenuView.m
//  ShareImage
//
//  Created by FTY on 2017/2/28.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DHomeMenuView.h"
#import "DHomeMenuCell.h"
#import "DHomeMenuHeader.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DHomeMenuView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *icons;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) DHomeMenuHeader *headerView;

@end

@implementation DHomeMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViewsAutoLayout];
    }
    return self;
}

- (void)reloadData{
    [self.headerView.iconView sd_setImageWithURL:[NSURL URLWithString:KGLOBALINFOMANAGER.accountInfo.profile_image.large]];
    if (KGLOBALINFOMANAGER.accountInfo.location.length == 0) {
        self.headerView.addressLabel.hidden = YES;
    }
    self.headerView.nameLabel.text = KGLOBALINFOMANAGER.accountInfo.username;
}

#pragma mark - 私有方法
- (void)setupSubViewsAutoLayout{
    [self addSubview:self.tableView];
    self.tableView.sd_layout
    .topSpaceToView(self, 0)
    .bottomSpaceToView(self,0)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0);
    
    self.headerView.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .heightIs(200);
    [self.tableView setTableHeaderView:self.headerView];
}

- (void)clickHeaderView:(DHomeMenuHeader *)headerView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeMenuView:didClickHeaderView:)]) {
        [self.delegate homeMenuView:self didClickHeaderView:headerView];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.icons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHomeMenuCell *cell = [DHomeMenuCell cellWithTableView:tableView];
    cell.imageView.image = [UIImage getImageWithName:self.icons[indexPath.row]];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeMenuView:didSelectIndex:)]) {
        [self.delegate homeMenuView:self didSelectIndex:indexPath.row];
    }
}




#pragma mark - setter & getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)icons{
    if (!_icons) {
        _icons = @[@"common_btn_image",@"common_btn_Albums",@"common_btn_like", @"common_menu_download", @"common_btn_settings"];
    }
    return _icons;
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[kLocalizedLanguage(@"homePhotos"), kLocalizedLanguage(@"homeCollections"), kLocalizedLanguage(@"homeLikes"),
                    kLocalizedLanguage(@"homeDownloads"),
                    kLocalizedLanguage(@"homeSetting")];
    }
    return _titles;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[DHomeMenuHeader alloc] init];
        [_headerView addTarget:self action:@selector(clickHeaderView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}



@end
