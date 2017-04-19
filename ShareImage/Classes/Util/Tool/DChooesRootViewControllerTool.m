//
//  DChooesRootViewControllerTool.m
//  ShareImage
//
//  Created by FTY on 2017/3/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DChooesRootViewControllerTool.h"
#import "DOAuthAccountTool.h"
#import "DOAuthViewController.h"
#import "DTabBarViewController.h"
#import "DNewFeatureController.h"
#import "DNavigationViewController.h"


@implementation DChooesRootViewControllerTool

+ (void)setupRootViewController{
    DOAuthAccountModel *account = [DOAuthAccountTool account];
    if (account) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[DTabBarViewController alloc] init];
    } else {
        // 授权
        [UIApplication sharedApplication].keyWindow.rootViewController = [[DOAuthViewController alloc] init];
    }
}

+ (void)checkVersion{
    
    NSString *key = @"CFBundleVersion";
    
    // 取出上一个版本
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获取当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
    
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        
        [self setupRootViewController];
    } else {
        // 新特性
        [UIApplication sharedApplication].keyWindow.rootViewController = [[DNewFeatureController alloc] init];
        
        // 存储当前版本号
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}


@end
