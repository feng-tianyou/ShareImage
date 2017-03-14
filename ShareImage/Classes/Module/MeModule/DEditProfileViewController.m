//
//  DEditProfileViewController.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/11.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DEditProfileViewController.h"
#import "DEditProfileCell.h"
#import "DEditProfileMsgController.h"

@interface DEditProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) DUserModel *userModel;


@end

@implementation DEditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Edit Profile";
    self.navLeftItemType = DNavigationItemTypeBack;
    
    [self setupSubViews];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshUserData];
}


#pragma mark - private
- (void)refreshUserData{
    self.userModel = KGLOBALINFOMANAGER.accountInfo;
    self.contents = @[
  @[[self changeContentWith:self.userModel.username],
    [self changeContentWith:self.userModel.first_name],
    [self changeContentWith:self.userModel.last_name]],
  @[[self changeContentWith:self.userModel.email],
    [self changeContentWith:self.userModel.instagram_username]],
  @[[self changeContentWith:self.userModel.portfolio_url],
    [self changeContentWith:self.userModel.location],
    [self changeContentWith:self.userModel.bio]]];
    
    [self.tableView reloadData];
}

- (NSString *)changeContentWith:(NSString *)content{
    NSString *str = [content copy];
    str = str.length > 0 ? str : @"Not Set";
    return str;
}

- (void)setupSubViews{
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
            return 3;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 3;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DEditProfileCell *cell = [DEditProfileCell cellWithTableView:tableView];
    
    NSArray *titleArr = self.titles[indexPath.section];
    NSArray *contentArr = self.contents[indexPath.section];
    cell.leftTitleLabel.text = titleArr[indexPath.row];
    cell.contentLabel.text = contentArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = DSystemColorGrayF3F3F3;
    label.font = DSystemFontText;
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    //第一行头缩进
    [style setFirstLineHeadIndent:15.0];
    [label setLineBreakMode:NSLineBreakByTruncatingTail];
    [label sizeToFit];
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"INFROMATION";
            break;
        case 1:
            title = @"CONTACT";
            break;
        case 2:
            title = @"INCIDENTALS";
            break;
            
        default:
            break;
    }
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:title attributes:@{NSParagraphStyleAttributeName : style}];
    label.attributedText = attrText;
    return label;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *titleArr = self.titles[indexPath.section];
    NSArray *contentArr = self.contents[indexPath.section];
    DEditProfileMsgController *editView = [[DEditProfileMsgController alloc] initWithTitle:titleArr[indexPath.row] content:contentArr[indexPath.row] indexPatch:indexPath];
    [self.navigationController pushViewController:editView animated:YES];
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

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@[@"User Name", @"First Name", @"Last Name"], @[@"Email", @"Instagram"], @[@"Personal Website", @"Location", @"Bio"]];
    }
    return _titles;
}

- (NSArray *)contents{
    if (!_contents) {
        _contents = [[NSArray alloc] init];
    }
    return _contents;
}


@end
