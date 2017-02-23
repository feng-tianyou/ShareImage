//
//  DGlobalInfoManager.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//  全局个人信息

#import <Foundation/Foundation.h>

@class DUserModel;

@interface DGlobalInfoManager : NSObject

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *thirdUid; // 第三方登录的UID

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isLockForRefreshUI;
@property (nonatomic, strong) NSNumber *notify_quake;
@property (nonatomic, strong) NSNumber *notify_sound;
@property (nonatomic, copy) NSString * deviceToken;//设备推送令牌
@property (nonatomic, assign) BOOL isNeedRefreshVersion;
@property (nonatomic, copy) NSString * version;//本地关系版本（最后一次调用此接口成功的时间戳）
@property (nonatomic, copy) NSString * msgMaxVersion;//本地关系版本（最后一次调用此接口成功的时间戳）
@property (nonatomic, assign) BOOL isGetRefreshToken;
@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, strong) DUserModel *accountInfo;


@property (nonatomic, strong) NSMutableDictionary *dicNetworkTask;



// 单例
+ (instancetype)share;


//更换设备之后清除本地缓存
- (void)clearLocalUserInfo;

//登录成功之后更新用户信息
- (void)startUpdateUserInfo;

// 重新请求用户信息
- (void)reloadUserInfo;

// 程序进入后台
- (void)applicationDidEnterBackground;

// 应用返回前台时调用
- (void)applicationWillEnterForeground;

// 清除Token
- (void)clearAccessToken;

// 清除刷新的Token
- (void)clearRefreshToken;

// 清除用户id
- (void)clearUid;

// 清除本地缓存数据（退出登录时调用）
- (void)clearAllInfo;

/**
 *  清除内存用户信息缓存
 */
- (void)clearAccountInfo;

//刷新用户数据
- (void)reloadAccountInfoForNotCache;

// 弹出其它地方登录控制
- (void)setIsAlertLogout:(BOOL)isLogout;

// 弹出其它地方登录控制
- (BOOL)getIsAlertLogout;


#pragma mark <----网络请求管理---->
- (void)addTask:(NSURLSessionDataTask *)task userInfo:(NSDictionary *)userInfo;

- (void)removeTask:(NSURLSessionDataTask *)task userInfo:(NSDictionary *)userInfo;




@end
