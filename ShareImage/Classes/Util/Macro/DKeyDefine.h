//
//  DKeyDefine.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#ifndef DKeyDefine_h
#define DKeyDefine_h

// ==============================初始化声明相关============================ //
// 常用相关关键字
#define kNull [NSNull null]
// 应用appDelegate
#define kAPPDELEGATE        ((AppDelegate *)[UIApplication sharedApplication].delegate)
// 全局个人信息
#define KGLOBALINFOMANAGER  [DGlobalInfoManager share]

// ==============================通知相关============================ //
#define kTabBar_Badge_value     @"tabbar_badge_value"


// ==============================视图控制相关============================ //
// 主视图信息
#define KVIEWNAME               @"viewName"
#define KNOTNETWORKALERT        @"needNotNetworkAlert"
#define KNEEDRELOAD             @"needReload"
#define KNOTIF_NONETWORK_KEY    @"nonetwork_key"

// 用户退出通知的关键字
#define KLOGOUT_TYPE            @"logout_type"
#define KNOTIF_LOGOUT_KEY       @"logout_key"

// 控制显示器相关
// 是否需要显示加载
#define kParamNoAddLoading      @"no_add_loading"

// ==============================网络请求相关============================ //
// 错误码配置--请求错误
#define ERRCODE0001 @"0x00000001"

// 请求回调数据常用的关键字
#define kStateCode          @"state_code"
#define kMessage            @"message"
#define kBody               @"body"
#define kParamData          @"data"


// 请求参数基本关键字
#define kParamUserName      @"username"
#define kParamPassword      @"password"
#define kParamUUID          @"uuid"
#define kParamThirdUid      @"thirdUid"
#define kParamRefreshToken  @"refresh_token"
#define kParamDeviceId      @"device_id"
#define kParamDeviceToken   @"ios_token"
#define kParamGrantToken    @"grant_token"

#define kParamAccessToken   @"access_token"
#define kParamExpiresIn     @"expires_in"
#define kParamUid           @"uid"
#define kParamDeviceChanged @"device_changed"//设备是否更换
#define kParamAccount       @"account"

#define kParamVersions      @"versions"
#define kParamMobile        @"mobile"
#define kParamType          @"type"
#define kParamCode          @"code"
#define kParamName          @"name"
#define kParamCompany       @"company"


//缓存key
#define kParamCacheData                 @"cache_data"

#define kCacheShortVersion              @"shortVersion"
#define kCacheNewVersionByVersion       @"newVersion-%@"
#define kCacheLocalCacheByVersion       @"localCache-%@"
#define kCacheFirstLogin                @"firstLogin"
#define kCacheIsConnectingByUid         @"connecting-%@"
#define kCacheIsLoginByUid              @"login-%@"
#define kCacheAccountInfoByUid          @"accountInfo-%@"
#define kCacheUserInfoByUidAndMyUid     @"userInfo-%@-%@"
#define kCacheUserImgByUid              @"userImg-%@"
#define kCacheUserImgByUidAndCpid       @"userImg-%@-%@"
#define kCacheUserBigImgByUid           @"userBigImg-%@"
#define kCacheDiscussImgByDid           @"discussImg-%@"
#define kCacheGroupImgByGid             @"groupImg-%@"
#define kCacheGroupListByUid            @"groupList-%@"
#define kCacheGroupSearchListByUid      @"groupSearchList-%@"
#define kCacheGroupRecommendListByUidAndAreaNo   @"groupRecommendList-%@-%@"
#define kCacheIsSeeIntroduceByUid       @"isSeeIntroduce-%@"
#define kCacheArrFriendInfoByUid        @"arrFriendInfo-%@"
#define kCacheRefreshCacheDataByUid     @"refreshCacheData-%@"
#define kCacheGlobalAdImage             @"globalAdImage"
#define kCacheGlobalAdInfoData          @"globalAdInfoData"
#define kCacheGlobalAdImageIsShow       @"globalAdImageIsShow"


// 缓存时间
#define kCacheTimeForTenMinute                          10 * 60
#define kCacheTimeForOneHour                            60 * 60
#define kCacheTimeForHalfDay                            12 * 60 * 60
#define kCacheTimeForOneDay                             86400
#define kCacheTimeForOneWeek                            7 * 86400
#define kCacheTimeForOneMonth                           30 * 86400
#define kCacheTimeForOneYear                            12 * 30 * 86400
#define kCacheTimeForTenYear                            10 * 12 * 30 * 86400


#endif /* DKeyDefine_h */
