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
  @[ExistStringGet(self.userModel.username),
    ExistStringGet(self.userModel.first_name),
    ExistStringGet(self.userModel.last_name)],
  @[ExistStringGet(self.userModel.email),
    ExistStringGet(self.userModel.instagram_username)],
  @[ExistStringGet(self.userModel.portfolio_url),
    ExistStringGet(self.userModel.location)]];
    [self.tableView reloadData];
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
        {
            return 3;
        }
            break;
        case 1:
        case 2:
        {
            return 2;
        }
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
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = DSystemColorGrayF3F3F3;
    label.font = DSystemFontText;
    [label setFrame:0 y:0 w:self.view.width h:40];
    switch (section) {
        case 0:
            label.text = @"    INFROMATION";
            break;
        case 1:
            label.text = @"    CONTACT";
            break;
        case 2:
            label.text = @"    INCIDENTALS";
            break;
            
        default:
            break;
    }
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
        _titles = @[@[@"User Name", @"First Name", @"Last Name"], @[@"Email", @"Instagram"], @[@"Url", @"Location"]];
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
