//
//  AppDelegate+DNotification.h
//  DFrame
//
//  Created by DaiSuke on 2017/2/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (DNotification)

/**
 初始化苹果推送的相关配置
 
 @param application application
 @param launchOptions launchOptions
 */
- (void)setupAPNS:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions;

/**
 初始化信鸽
 */
+ (void)setupXGPush;


/**
 注册远程推送，并且设置第三方设备ID

 @param deviceToken
 */
+ (void)registerDeviceToken:(NSData *)deviceToken;

/**
 处理接收到的推送通知

 @param userInfo 信息
 */
+ (void)handleReceiveNotification:(NSDictionary *)userInfo;

@end
