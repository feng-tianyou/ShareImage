//
//  DHomeViewController.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DHomeViewController.h"
#import "ViewController.h"

#import "DUserManager.h"
#import "DShareManager.h"
#import "DFingerPrintManager.h"

#import "DLoginViewController.h"
#import "DScanQRCodeViewController.h"
#import "DTestPhotoViewController.h"
#import "DTestViewController.h"

#import "DOAuthViewController.h"

#import "DWebViewController.h"

#import "DEmotionManager.h"
#import "UIImage+DQRCode.h"

#import "DTestUserProxy.h"

#import <MJRefresh/MJRefresh.h>
#import "DLottieViewController.h"
#import "DUserNetwork.h"

static NSString * const cellID = @"cell";

@interface DHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView *_view;
    UITextField *_textField;
    DEmotionManager *_emotionManager;
    UIImageView *_qrImageView;
    
    
    BOOL _theme;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *testDatas;


@end

@implementation DHomeViewController
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        //        _tableView.tableHeaderView = [UIView new];
        _tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (NSMutableArray *)testDatas{
    if (_testDatas == nil) {
        _testDatas = [NSMutableArray arrayWithArray:@[@"OAuth",@"指纹验证", @"数据存储", @"表情面板", @"图片管理", @"分享", @"请求管理", @"主题", @"二维码", @"扫二维码", @"网页浏览器", @"导航栏按钮设置", @"第三方登录", @"提示数字", @"测试JSPatch", @"Widget", @"Lottie转场动画", @"Lottie动画"]];
    }
    return _testDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0);
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.tableView.mj_header endRefreshing];
            [self.testDatas addObject:@"下拉刷新，增加的数据"];
            [self.tableView reloadData];
        });
    }];
//    [self.tableView.mj_header beginRefreshing];
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.testDatas addObject:@"上拉刷新，增加的数据"];
            [self.tableView reloadData];
        });
    }];
    
}


#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.testDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = self.testDatas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            // OAuth
            [self.navigationController pushViewController:[[DOAuthViewController alloc] init] animated:YES];
            
            
            
        }
            break;
        case 1:
        {
            // 指纹验证
            BOOL canPolicy = [DFingerPrintManager canEvaluatePolicy];
            if (!canPolicy) {
                DAlertView *alert = [[DAlertView alloc] initWithTitle:@"" andMessage:@"设备不支持指纹验证"];
                [alert addButtonWithTitle:@"确定" handler:nil];
                [alert show];
                return;
            }
            
            [DFingerPrintManager loadAuthenticationWithPolicyBlock:^(BOOL success, NSError *error) {
                if (success) {
                    DLog(@"验证成功");
                }
            }];
            
        }
            break;
        case 2:
        {
            // 数据存储
            DTestUserProxy *proxy = [[DTestUserProxy alloc] init];
            
            DUserModel *model = [[DUserModel alloc] init];
            model.uid = 6666;
            model.name = @"daisuke";
            model.mobile = @"13570385104";
            model.job = @"ios";
            model.company = @"tgnet";
            
            DUserModel *model1 = [[DUserModel alloc] init];
            model1.uid = 6667;
            model1.name = @"daisuke";
            model1.mobile = @"13570385104";
            model1.job = @"ios";
            model1.company = @"tgnet";
            
            [proxy saveUser:model];
            [proxy saveUser:model1];
            
            NSArray *arr = [proxy getAllUser];
            DLog(@"%@", arr);
            //    DUserModel *model = [proxy getUserWithUid:6666];
            //    DLog(@"%@", model);
            
            //    BOOL success = [proxy deleteUid:6666];
            //    DLog(@"%@", @(success));
        }
            break;
        case 3:
        {
            // 表情面板
            UIView *bgView = [[UIView alloc] init];
            bgView.backgroundColor = [UIColor whiteColor];
            
            _textField = [[UITextField alloc] init];
            _textField.placeholder = @"请输入";
            [_textField setFrame:0 y:0 w:self.view.width - 20 h:30];
            _textField.layer.borderColor = [UIColor blackColor].CGColor;
            _textField.layer.borderWidth = 1.5;
            [bgView addSubview:_textField];
            
            _emotionManager = [[DEmotionManager alloc] init];
            _emotionManager.boundTextField = _textField;
            _emotionManager.emotionView.numberOfRowsPerPage = 3;
            _emotionManager.emotionView.emotionSize = CGSizeMake(25, 25);
            _emotionManager.emotionView.frame = CGRectMake(0, 32, self.view.width - 20, 200);
            [_emotionManager.emotionView.sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:_emotionManager.emotionView];
            
            [bgView setFrame:0 y:0 w:self.view.width - 20 h:210];
            
            DAlertView *alert = [[DAlertView alloc] initWithCustomView:bgView];
            [alert addButtonWithTitle:@"确定" handler:nil];
            [alert show];
        }
            break;
        case 4:
        {
            // 图片管理
            [self.navigationController pushViewController:[[DTestPhotoViewController alloc] init] animated:YES];
        }
            break;
        case 5:
        {
            // 分享
            [DShareManager  shareUrlForAllPlatformByTitle:@"DaiSuke" content:@"DaiSuke的网站" shareUrl:@"http://daisuke.cn" parentController:self];
        }
            break;
        case 6:
        {
            // 请求管理(底层绑定了测试Token)
            DUserManager *manager = [DUserManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
            [manager getAccount];
        }
            break;
        case 7:
        {
            // 主题
            if (!_theme) {
                self.dk_manager.themeVersion = DKThemeVersionNight;
                _theme = YES;
            } else {
                self.dk_manager.themeVersion = DKThemeVersionNormal;
                _theme = NO;
            }
        }
            break;
        case 8:
        {
            // 二维码
            _qrImageView = ({
                UIImageView *image = [[UIImageView alloc] init];
                image;
            });
            [_qrImageView setFrame:(self.view.width - 170)/2 y:10 w:150 h:150];
            
            UIImage *image = [UIImage imageForQRWithURL:@"http://daisuke.cn" qrImageSize:200 qrRed:0 qrGreen:0 qrBlue:0 insertImage:[UIImage getImageWithName:@"avatar"] insertImageRoundRadius:15.0];
            _qrImageView.image = image;
            
            DAlertView *alert = [[DAlertView alloc] initWithCustomView:_qrImageView];
            [alert addButtonWithTitle:@"确定" handler:nil];
            [alert show];
            
            
        }
            break;
        case 9:
        {
            // 扫二维码
            [self.navigationController pushViewController:[[DScanQRCodeViewController alloc] init] animated:YES];
        }
            break;
        case 10:
        {
            // 网页浏览器
             [self.navigationController pushViewController:[[DWebViewController alloc] initWithUrl:@"http://daisuke.cn"] animated:YES];
        }
            break;
        case 11:
        {
            // 导航栏按钮设置
            
            self.navLeftItemType = DNavigationItemTypeRightAdd;
            self.navRighItemType = DNavigationItemTypeRightShare;

        }
            break;
        case 12:
        {
            // 第三方登录
            [self presentViewController:[[DLoginViewController alloc] init] animated:YES completion:nil];
            
        }
            break;
        case 13:
        {
            // 提示数字
            self.tabBarItem.badgeValue = @"10";
            [UIApplication sharedApplication].applicationIconBadgeNumber = 10;
        }
            break;
        case 14:
        {
            // 提示数字
            [self.navigationController pushViewController:[[DTestViewController alloc] init] animated:YES];
        }
            break;
        case 15:
        {
            // Widget
            [self localError:@"移步看手机的今天安排" isAlertFor2Second:NO];
        }
            break;
        case 16:
        {
            // @"Lottie转场动画"
            [self lottiePresentViewController:[[DLoginViewController alloc] init] animated:YES completion:nil];
        }
            break;
        case 17:
        {
            // @"Lottie动画"
            [self lottiePresentViewController:[[DLottieViewController alloc] init] animated:YES completion:nil];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)send {
    DLog(@"发送--%@",_textField.text);
}

#pragma mark - 导航栏点击事件
//- (void)baseViewControllerDidClickNavigationLeftBtn:(UIButton *)leftBtn{
//    NSLog(@"baseViewControllerDidClickNavigationLeftBtn");
//}

//- (void)baseViewControllerDidClickNavigationRightBtn:(UIButton *)rightBtn{
//    NSLog(@"baseViewControllerDidClickNavigationRightBtn");
//}

//- (void)baseViewControllerDidClickNavigationTitleBtn:(UIButton *)titleBtn{
//    NSLog(@"baseViewControllerDidClickNavigationTitleBtn");
//}

- (void)baseViewControllerDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (isLeft) {
        NSLog(@"点击了左按钮");
        [self localShowSuccess:@"点击了左按钮"];
    } else {
        NSLog(@"点击了右按钮");
        [self localShowSuccess:@"点击了右按钮"];
    }
}






#pragma mark - 请求回调
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    DUserModel *model = dataModel;
    DLog(@"获取用户信息--%@",dataModel);
    DLog(@"name = %@", model.name);
    [self localShowSuccess:@"请求数据成功，看打印数据"];
}

@end
