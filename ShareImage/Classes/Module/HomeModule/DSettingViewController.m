//
//  DSettingViewController.m
//  ShareImage
//
//  Created by FTY on 2017/3/14.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSettingViewController.h"
#import "DSettingTableViewCell.h"

@interface DSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation DSettingViewController

/**
 夜间（考虑）、缓存、语言、关于、退出
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Settings";
    self.navLeftItemType = DNavigationItemTypeBack;
    
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
    cell.leftTitleLabel.text = titleArr[indexPath.row];
    switch (indexPath.section) {
        case 0:
        case 2:
        {
            cell.arrowView.hidden = NO;
            cell.rightSwitch.hidden = YES;
        }
            break;
        case 1:
        {
            cell.arrowView.hidden = YES;
            cell.rightSwitch.hidden = NO;
        }
            break;
            
        default:
            break;
    }
    
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
    
}

#pragma mark - getter & setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = DSystemColorGrayF3F3F3;
        _tableView.rowHeight = 50;
    }
    return _tableView;
}
/**
 夜间（考虑）、缓存、语言、关于、退出
 */
- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@[@"Language"], @[@"Night"], @[@"Storage", @"About"]];
    }
    return _titles;
}




@end
