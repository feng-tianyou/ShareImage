//
//  DShareManager.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/5.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CustomPlatformBlock)(NSInteger index, NSDictionary *userInfo);

@interface DShareManager : NSObject

/**
 单例

 @return 实例对象
 */
//+ (instancetype)shareManager;


/**
 分享（所有平台）

 @param title 标题
 @param content 内容
 @param shareUrl 连接
 @param parentController 当前控制器
 */
+ (void)shareUrlForAllPlatformByTitle:(NSString *)title
                              content:(NSString *)content
                             shareUrl:(NSString *)shareUrl
                           parentController:(UIViewController *)parentController;

/**
 分享（所有平台）(添加自定义平台)
 
 @param title 标题
 @param content 内容
 @param shareUrl 连接
 @param customPlatforms 自定义平台（
 描述： customPlatforms数组存放字典，
 字典格式：@{@"platformIcon":@"平台图片", @"platformName":@"平台名称"}）
 字典两个关键字key：platformIcon、platformName
 @param parentController 当前控制器
 */
+ (void)shareUrlForAllPlatformByTitle:(NSString *)title
                              content:(NSString *)content
                             shareUrl:(NSString *)shareUrl
                        customPlatforms:(NSArray *)customPlatforms
                     parentController:(UIViewController *)parentController
                          eventBlock:(CustomPlatformBlock)eventBlock;


/**
 分享（朋友圈平台）
 
 @param title 标题
 @param content 内容
 @param shareUrl 连接
 @param parentController 当前控制器
 */
- (void)shareUrlForWechatTimeLineByTitle:(NSString *)title
                                 content:(NSString *)content
                                shareUrl:(NSString *)shareUrl
                              parentController:(UIViewController *)parentController;


/**
 分享短信信息

 @param message 内容信息
 @param recipients 联系人集合
 @param parentController 当前控制器
 @param resultBlock 发送回调
 */
- (void)shareSMSWithMessage:(NSString *)message
                 recipients:(NSArray *)recipients
           parentController:(UIViewController *)parentController
                  resultBlock:(BoolBlock)resultBlock;


@end
