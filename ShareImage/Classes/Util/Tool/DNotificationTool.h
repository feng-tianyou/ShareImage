//
//  DNotificationTool.h
//  DFrame
//
//  Created by DaiSuke on 2017/2/3.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNotificationTool : NSObject

//发送通知（主线程中）
+ (void)sendNotificationByName:(NSString *)name
                      userInfo:(NSDictionary *)userInfo;

+ (void)sendNotificationByName:(NSString *)name
                        object:(id)object;

//发送tabbar更新通知
+ (void)sendTabBarUpdateNotificationWithUserInfo:(NSDictionary *)userInfo;


@end
