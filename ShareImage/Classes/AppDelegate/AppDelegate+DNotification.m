//
//  AppDelegate+DNotification.m
//  DFrame
//
//  Created by DaiSuke on 2017/2/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "AppDelegate+DNotification.h"
#import <UserNotifications/UserNotifications.h>
#import "XGPush.h"
#import "DNotificationTool.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate (DNotification)

/**
 初始化苹果推送的相关配置
 
 @param application application
 @param launchOptions launchOptions
 */
- (void)setupAPNS:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions{
    // 注册苹果的推送
    if (IOS10) {
        UNUserNotificationCenter *userNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        userNotificationCenter.delegate = self;
        [userNotificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // granted
                DLog(@"用户允许开启通知");
                [application registerForRemoteNotifications];
            } else {
                // not granted
                DLog(@"用户拒绝通知");
            }
        }];
    } else {
        // ios8
        UIUserNotificationSettings *userNotificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:userNotificationSettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

/**
 初始化信鸽
 */
+ (void)setupXGPush{
    [XGPush startApp:2200249937 appKey:@"I5NJ285D9ZRW"];
}

/**
 注册远程推送，并且设置第三方设备ID
 
 @param deviceToken
 */
+ (void)registerDeviceToken:(NSData *)deviceToken{
    NSString *deviceTokenStr = [XGPush registerDevice:deviceToken account:@"dd123456" successCallback:^{
        DLog(@"XGPush register push success");
    } errorCallback:^{
        DLog(@"XGPush register push error");
    }];
    DLog(@"XGPush device token is %@", deviceTokenStr);
}


/**
 处理接收到的推送通知
 
 @param userInfo 信息
 */
+ (void)handleReceiveNotification:(NSDictionary *)userInfo{
    DLog(@"receive slient Notification");
    DLog(@"userinfo %@", userInfo);
    [XGPush handleReceiveNotification:userInfo
                      successCallback:^{
                          DLog(@"Handle receive success");
                      } errorCallback:^{
                          DLog(@"Handle receive error");
                      }];
    
    // 设置tabbar提醒数据
    [DNotificationTool sendTabBarUpdateNotificationWithUserInfo:userInfo];
}


#pragma mark - UNUserNotificationCenterDelegate
/**
 *  处理iOS 10通知(iOS 10+)
 */
- (void)handleiOS10Notification:(UNNotification *)notification {
    UNNotificationRequest *request = notification.request;
    UNNotificationContent *content = request.content;
    NSDictionary *userInfo = content.userInfo;
    //    // 通知时间
    //    NSDate *noticeDate = notification.date;
    //    // 标题
    //    NSString *title = content.title;
    //    // 副标题
    //    NSString *subtitle = content.subtitle;
    //    // 内容
    //    NSString *body = content.body;
    //    // 角标
    //    int badge = [content.badge intValue];
    //    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    //    NSString *extras = [userInfo valueForKey:@"Extras"];
    
    //    NSLog(@"Notification, date: %@, title: %@, subtitle: %@, body: %@, badge: %d, extras: %@.", noticeDate, title, subtitle, body, badge, extras);
}

/**
 *  App处于前台时收到通知(iOS 10+)
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    //    NSLog(@"Receive a notification in foregound.");
    // 处理iOS 10通知相关字段信息
    [self handleiOS10Notification:notification];
    // 通知不弹出
//    completionHandler(UNNotificationPresentationOptionNone);
    // 通知弹出，且带有声音、内容和角标（App处于前台时不建议弹出通知）
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    [XGPush handleReceiveNotification:response.notification.request.content.userInfo
                      successCallback:^{
                          NSLog(@"[XGDemo] Handle receive success");
                      } errorCallback:^{
                          NSLog(@"[XGDemo] Handle receive error");
                      }];
    
    //点击推送
    //    NSString *userAction = response.actionIdentifier;
    //    NSDictionary *userInfo = response.notification.request.content.userInfo;
    //
    //    if ([userAction isEqualToString:UNNotificationDefaultActionIdentifier])
    //    {
    //
    //        if (![response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    //        {//本地推送
    //
    //        }
    //        else
    //        {//远程推送
    //
    //        }
    //    }
    
    completionHandler();
}



@end
