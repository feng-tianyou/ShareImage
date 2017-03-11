//
//  AppDelegate.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "AppDelegate.h"

#import "DGlobalManager.h"

#import "AppDelegate+DCommon.h"
#import "AppDelegate+DShare.h"
#import "AppDelegate+DNotification.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark - setter & getter
- (id<DGlobalManagerProtocol>)globalManager{
    if (!_globalManager) {
        _globalManager = [[DGlobalManager alloc] init];
    }
    return _globalManager;
}

- (NSString *)deviceId{
    if(_deviceId.length == 0){
        _deviceId = @"";
    }
    return _deviceId;
}


#pragma mark - 应用方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 初始化跟控制器
    [self setupRootViewController];
    
    // 初始化苹果推送相关配置
    [self setupAPNS:application launchOptions:launchOptions];
    
    
    // 初始化信鸽推送
    [AppDelegate setupXGPush];
    
    // 初始化分享功能
    [AppDelegate setupShareManager];
    
    
    // 初始化3DTouch
    [AppDelegate setupShortcutIcon:application launchOptions:launchOptions];
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 推送相关

/**
 注册远程推送

 @param application 应用
 @param deviceToken 设备ID
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    // 注册第三方推送
    [AppDelegate registerDeviceToken:deviceToken];
}

/**
 注册远程推送失败

 @param application application description
 @param error error description
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    DLog(@"register APNS fail.\n reason : %@", error);
}

/**
 收到通知的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    // 处理接收到的推送通知
    [AppDelegate handleReceiveNotification:userInfo];
}

/**
 收到静默推送的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    // 处理接收到的推送通知
    [AppDelegate handleReceiveNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

/**
 接收本地推送

 @param application application description
 @param notification notification description
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
     NSDictionary *dicUserInfo = notification.userInfo;
    DLog(@"%@", dicUserInfo);
}


#pragma mark - 处理URL回调
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    // 处理回调URL
    BOOL result = [self handleApplicationOpenURL:url];
    
    // 处理Widget
    [self handleApplicationOpenURLForWidget:url];
    
    return result;
}

#endif

//当这笔交易被买家支付成功后支付宝收银台上显示该笔交易成功,回到应用所回调方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // 处理回调URL
    BOOL result = [self handleApplicationOpenURL:url];
    
    // 处理Widget
    [self handleApplicationOpenURLForWidget:url];
    
    return result;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    // 处理回调URL
    BOOL result = [self handleApplicationOpenURL:url];
    return result;
}




@end
