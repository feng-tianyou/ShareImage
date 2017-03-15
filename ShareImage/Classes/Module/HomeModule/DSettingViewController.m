//
//  DSettingViewController.m
//  ShareImage
//
//  Created by FTY on 2017/3/14.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSettingViewController.h"
#import "DSettingTableViewCell.h"

#import <SDWebImage/SDImageCache.h>


@interface DSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, assign) NSString *cacheSizeStr;

@end

@implementation DSettingViewController

/**
 夜间（考虑）、缓存、语言、关于、退出
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupData];
    [self setupView];
    
}

- (void)setupData{
    self.title = @"Settings";
    self.navLeftItemType = DNavigationItemTypeBack;
    NSInteger size = [[SDImageCache sharedImageCache] getSize];
    NSInteger sizeF = size / 1024 / 1024;
    self.cacheSizeStr = [NSString stringWithFormat:@"%@M", @(sizeF)];
}

- (void)setupView{
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
}


- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSettingTableViewCell *cell = [DSettingTableViewCell cellWithTableView:tableView];
    
    NSArray *titleArr = self.titles[indexPath.section];
    [cell setLeftTitle:titleArr[indexPath.row] content:self.cacheSizeStr indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = DSystemColorGrayF3F3F3;
//    label.font = DSystemFontText;
//    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    //第一行头缩进
//    [style setFirstLineHeadIndent:15.0];
//    [label setLineBreakMode:NSLineBreakByTruncatingTail];
//    [label sizeToFit];
//    NSString *title = nil;
//    switch (section) {
//        case 0:
//            title = @"INFROMATION";
//            break;
//        case 1:
//            title = @"CONTACT";
//            break;
//        case 2:
//            title = @"INCIDENTALS";
//            break;
//            
//        default:
//            break;
//    }
//    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:title attributes:@{NSParagraphStyleAttributeName : style}];
//    label.attributedText = attrText;
//    return label;
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - getter & setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = DSystemColorGrayF3F3F3;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}
/**
 夜间（考虑）、缓存、语言、关于、退出
 */
- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@[@"Language"], @[@"Night"], @[@"Clear Storage", @"About"]];
    }
    return _titles;
}

//- (NSArray *)contents{
//    if (!_contents) {
//        _contents = @[@[@""], @[@""], @[@"", @""]];
//    }
//    return _contents;
//}




@end
