//
//  DBaseViewController.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseViewController.h"
#import "DNavigationTool.h"
#import "DOAuthViewController.h"

@interface DBaseViewController ()

@end

@implementation DBaseViewController
#pragma mark - 父类方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:KNOTIF_LOGOUT_KEY object:nil];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // 注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KNOTIF_LOGOUT_KEY object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

}


#pragma mark - 私有方法
#pragma mark - 通知方法
- (void)logout:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    NSInteger code = [[dic objectForKey:KLOGOUT_TYPE] integerValue];
    NSString *message = @"";
    switch (code) {
        case LogoutTypeForNoValid:
        case LogoutTypeForNoOAuth:
        {
            message = @"账号授权已过期，请重新授权！";
        }
            break;
            
        default:
            break;
    }
    
    if ([self isKindOfClass:[DOAuthViewController class]]) {
        return;
    }
    
    DAlertView *alertView = [[DAlertView alloc] initWithTitle:@"" andMessage:message];
    @weakify(self)
    [alertView addButtonWithTitle:@"确定" handler:^(DAlertView *alertView) {
        @strongify(self)
        [self.navigationController pushViewController:[[DOAuthViewController alloc] init] animated:YES];
    }];
    [alertView show];
}

#pragma mark - 状态栏

/**
 重写preferredStatusBarStyle，改变状态栏
 
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - setter & getter

- (NSMutableDictionary *)networkUserInfo{
    if(_networkUserInfo == nil){
        _networkUserInfo = [NSMutableDictionary new];
        NSString *viewName = NSStringFromClass([self class]);
        [_networkUserInfo setObject:viewName forKey:KVIEWNAME];
        [_networkUserInfo setObject:@(YES) forKey:KNOTNETWORKALERT];
    }
    return _networkUserInfo;
}


- (CGFloat)navBarHeight{
    CGRect rect = [[UIApplication sharedApplication] statusBarFrame];
    return self.navigationController.navigationBar.frame.size.height+rect.size.height;
}

@end
