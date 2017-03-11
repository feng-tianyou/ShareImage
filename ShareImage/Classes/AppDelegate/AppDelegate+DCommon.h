//
//  AppDelegate+DCommon.h
//  DFrame
//
//  Created by DaiSuke on 2017/2/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (DCommon)

/**
 初始化跟控制器
 */
- (void)setupRootViewController;

#pragma mark - 回调地址处理
/**
 处理应用回调的地址
 
 @param url 地址
 @return 是否处理
 */
- (BOOL)handleApplicationOpenURL:(NSURL *)url;



#pragma mark - 3DTouch
/**
 初始化3D触控

 @param application application
 @param launchOptions launchOptions
 */
+ (void)setupShortcutIcon:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions;

#pragma mark - Widget
- (void)handleApplicationOpenURLForWidget:(NSURL *)url;


@end
