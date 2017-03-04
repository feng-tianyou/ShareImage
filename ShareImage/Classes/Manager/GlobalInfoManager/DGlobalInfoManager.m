//
//  DGlobalInfoManager.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DGlobalInfoManager.h"

#import "Reachability.h"
#import "YYKit.h"

#import "DCacheManager.h"
#import "DPlistManager.h"

#import "DUserNetwork.h"

#define GLOBAL_KEY_SYSTEM_SOUND_BYUID               @"system_sound-%@"
#define GLOBAL_KEY_SYSTEM_QUAKE_BYUID               @"system_quake-%@"
#define TR_DEVICETOKEN_KEY                          @"_deviceToken"

#define GLOBAL_INFO_DEVICE_TOKEN_SAVE_TIME  10 * 12 * 30 * 86400

@interface DGlobalInfoManager ()
{
    pthread_mutex_t _lock; // recursive lock
    BOOL _isFinishForGetFriend;
    BOOL _isFinishForGetDiscuss;
    BOOL _isFinishForGetGroup;
    NSNumber *_isGetRefreshToken;
    
    NSNumber *_isAlertLogout;
}

@property (nonatomic, strong) Reachability *reachability;

@end

@implementation DGlobalInfoManager
@synthesize accessToken = _accessToken;
@synthesize refreshToken = _refreshToken;
@synthesize uid = _uid;
@synthesize deviceToken = _deviceToken;
@synthesize notify_sound = _notify_sound;
@synthesize notify_quake = _notify_quake;
@synthesize version = _version;

#pragma mark 初始化
SYNTHESIZE_SINGLETON_FOR_CLASS(DGlobalInfoManager)

- (id)init{
    self = [super init];
    if (self) {
        pthread_mutex_init_recursive(&_lock, true);
    }
    return self;
}

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
}


#pragma mark -  进入后台 & 进入前台操作

// 程序进入后台
- (void)applicationDidEnterBackground
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

// 应用返回前台时调用
- (void)applicationWillEnterForeground
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    // 监听网络
    [self registerForNetworkReachabilityNotifications];
    NetworkStatus networkStatus = [_reachability currentReachabilityStatus];
    if (networkStatus != NotReachable) {
      
    }
}

#pragma mark 清除本地缓存数据（退出登录时调用）

- (void)clearAllInfo{
    [self clearUid];
    [self clearAccessToken];
    [self clearRefreshToken];
    [self clearAccountInfo];
    
    _version = @"";
    _isLogin = NO;
    
}

//更换设备之后清除本地缓存
- (void)clearLocalUserInfo
{
    
}



#pragma mark 令牌
- (void)setAccessToken:(NSString *)accessToken
{
    if (accessToken.length > 0) {
        _accessToken = [NSString stringWithFormat:@"%@",[accessToken copy]];
        DPlistManager *plistManager = [DPlistManager shareManager];
        NSString *plistName = @"UserInfo_accessToken";
        NSMutableDictionary *dicInfo = nil;
        NSDictionary *dicPlist = [plistManager getDataByFileName:plistName];
        if(dicPlist){
            dicInfo = [NSMutableDictionary dictionaryWithDictionary:dicPlist];
        }
        if(dicInfo== nil){
            dicInfo = [NSMutableDictionary new];
        }
        [dicInfo setObject:_accessToken forKey:kParamAccessToken];
        [plistManager writeDicToPlistByFileName:plistName dicData:dicInfo];
    }
}

- (NSString *)accessToken
{
    if (!_accessToken || _accessToken.length == 0) {
        DPlistManager *plistManager = [DPlistManager shareManager];
        NSString *plistName = @"UserInfo_accessToken";
        NSDictionary *dicInfo = [plistManager getDataByFileName:plistName];
        if(dicInfo && [dicInfo objectForKey:kParamAccessToken] && [dicInfo objectForKey:kParamAccessToken] != kNull){
            _accessToken = [dicInfo objectForKey:kParamAccessToken];
        }
        
    }
    if (!_accessToken) {
        DOAuthAccountModel *model = [DOAuthAccountTool account];
        _accessToken = model.access_token;
    }
    return _accessToken;
}

- (void)clearAccessToken{
    _accessToken = nil;
    [self setAccessToken:@"11"];
}

#pragma mark 刷新令牌

- (void)setRefreshToken:(NSString *)refreshToken
{
    if (refreshToken.length > 0) {
        _refreshToken = [NSString stringWithFormat:@"%@",[refreshToken copy]];
        DPlistManager *plistManager = [DPlistManager shareManager];
        NSString *plistName = @"UserInfo_refreshToken";
        NSMutableDictionary *dicInfo = nil;
        NSDictionary *dicPlist = [plistManager getDataByFileName:plistName];
        if(dicPlist){
            dicInfo = [NSMutableDictionary dictionaryWithDictionary:dicPlist];
        }
        if(dicInfo== nil){
            dicInfo = [NSMutableDictionary new];
        }
        [dicInfo setObject:_refreshToken forKey:kParamRefreshToken];
        [plistManager writeDicToPlistByFileName:plistName dicData:dicInfo];
    }
}

- (NSString *)refreshToken
{
    if (!_refreshToken) {
        DPlistManager *plistManager = [DPlistManager shareManager];
        NSString *plistName = @"UserInfo_refreshToken";
        NSDictionary *dicInfo = [plistManager getDataByFileName:plistName];
        if(dicInfo && [dicInfo objectForKey:kParamRefreshToken] && [dicInfo objectForKey:kParamRefreshToken] != kNull){
            _refreshToken = [dicInfo objectForKey:kParamRefreshToken];
        }
        
    }
    if (!_refreshToken) {
        DOAuthAccountModel *model = [DOAuthAccountTool account];
        _refreshToken = model.refresh_token;
    }
    return _refreshToken;
}

- (void)clearRefreshToken{
    _refreshToken = nil;
    [self setRefreshToken:@"11"];
}

#pragma mark 用户id
- (void)setUid:(NSString *)uid{
    if (uid.length > 0) {
        _uid = [uid copy];
        [DCacheManager setCacheObjectByData:_uid forKey:kParamUid withTimeoutInterval:kCacheTimeForOneYear];
        [[NSUserDefaults standardUserDefaults] setObject:_uid forKey:kParamUid];
    }
}

- (NSString *)uid{
    if (_uid.length == 0) {
        _uid = (NSString *)[DCacheManager getCacheObjectForKey:kParamUid];
        if (_uid.length == 0) {
            _uid = [[NSUserDefaults standardUserDefaults] valueForKey:kParamUid];
        }
    }
    return _uid;
}

- (void)clearUid
{
    _uid = @"";
    [DCacheManager setCacheObjectByData:_uid forKey:kParamUid withTimeoutInterval:kCacheTimeForOneYear];
    [[NSUserDefaults standardUserDefaults] setObject:_uid forKey:kParamUid];
}


#pragma mark 登录成功之后更新用户信息
//登录成功之后更新用户信息
- (void)startUpdateUserInfo
{
    // 做加载必要的数据处理
}

// 重新请求加载用户信息
- (void)reloadUserInfo{
//    [DCacheManager clearUserImgCacheByUid:self.uid];
    [self reloadAccountInfoForNotCache];
}

#pragma mark 用户信息

- (DUserModel *)accountInfo{
    if(_accountInfo == nil){
        NSString *userInfoKey = [NSString stringWithFormat:kCacheAccountInfoByUid,KGLOBALINFOMANAGER.uid];
        DPlistManager *manager = [DPlistManager shareManager];
        NSData *data = [manager getBitDataByFileName:userInfoKey];
        
        if(data.length > 0){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            _accountInfo = [DUserModel modelWithJSON:dic];
            _accountInfo.uid = KGLOBALINFOMANAGER.uid;
        }
        else{
            [[DUserNetwork shareEngine] getAccountNeedCache:NO onSucceeded:^(NSDictionary *dic, BOOL isCache) {
                _accountInfo = [DUserModel modelWithJSON:dic];
                _accountInfo.uid = KGLOBALINFOMANAGER.uid;
            } onError:^(DError *error) {
            }];
        }
    }
    return _accountInfo;
}

- (void)reloadAccountInfoForNotCache{
    [[DUserNetwork shareEngine] getAccountNeedCache:NO onSucceeded:^(NSDictionary *dic, BOOL isCache) {
        _accountInfo = [DUserModel modelWithJSON:dic];
        _accountInfo.uid = KGLOBALINFOMANAGER.uid;
    } onError:^(DError *error) {
    }];
}

/**
 *  清除内存用户信息缓存
 */
- (void)clearAccountInfo{
    _accountInfo = nil;
}


#pragma mark 是否已登录

- (BOOL)isLogin{
    if(KGLOBALINFOMANAGER.uid.length <= 0){
        return NO;
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *strKey = [NSString stringWithFormat:kCacheIsLoginByUid,KGLOBALINFOMANAGER.uid];
    if([userDefault objectForKey:strKey] && [[userDefault objectForKey:strKey] boolValue]){
        return YES;
    }
    return NO;
}


#pragma mark 声音设置

- (void)setNotify_sound:(NSNumber *)notify_sound{
    _notify_sound = notify_sound;
    NSString *strKey = [NSString stringWithFormat:GLOBAL_KEY_SYSTEM_SOUND_BYUID,KGLOBALINFOMANAGER.uid];
    [DCacheManager setCacheObjectByData:notify_sound forKey:strKey withTimeoutInterval:kCacheTimeForOneYear];
}

- (NSNumber *)notify_sound{
    NSString *strKey = [NSString stringWithFormat:GLOBAL_KEY_SYSTEM_SOUND_BYUID,KGLOBALINFOMANAGER.uid];
    id notify_sound = [DCacheManager getCacheObjectForKey:strKey];
    if(notify_sound != nil){
        return notify_sound;
    }
    return @(0);
}

#pragma mark 震动设置

- (void)setNotify_quake:(NSNumber *)notify_quake{
    _notify_quake = notify_quake;
    NSString *strKey = [NSString stringWithFormat:GLOBAL_KEY_SYSTEM_QUAKE_BYUID,KGLOBALINFOMANAGER.uid];
    [DCacheManager setCacheObjectByData:notify_quake forKey:strKey withTimeoutInterval:kCacheTimeForOneYear];
}

- (NSNumber *)notify_quake{
    NSString *strKey = [NSString stringWithFormat:GLOBAL_KEY_SYSTEM_QUAKE_BYUID,KGLOBALINFOMANAGER.uid];
    id notify_quake = [DCacheManager getCacheObjectForKey:strKey];
    if(notify_quake != nil){
        return notify_quake;
    }
    return @(0);
}

#pragma mark 推送token

- (void)setDeviceToken:(NSString *)deviceToken
{
    if (deviceToken) {
        _deviceToken = [NSString stringWithFormat:@"%@",[deviceToken copy]];
        [DCacheManager setCacheObjectByData:_deviceToken forKey:TR_DEVICETOKEN_KEY withTimeoutInterval:GLOBAL_INFO_DEVICE_TOKEN_SAVE_TIME];
    }
}

- (NSString *)deviceToken
{
    if (!_deviceToken) {
        NSString *strToken = (NSString *)[DCacheManager getCacheObjectForKey:TR_DEVICETOKEN_KEY];
        if(strToken.length > 0){
            _deviceToken = strToken;
        }
    }
    return _deviceToken;
}

#pragma mark 访问刷新令牌控制

- (void)setIsGetRefreshToken:(BOOL)isGetRefreshToken{
    @synchronized(_isGetRefreshToken) {
        _isGetRefreshToken = @(isGetRefreshToken);
    }
}

- (BOOL)isGetRefreshToken{
    @synchronized(_isGetRefreshToken) {
        return [_isGetRefreshToken boolValue];
    }
    
}

#pragma mark 弹出其它地方登录控制

- (void)setIsAlertLogout:(BOOL)isLogout{
    @synchronized(_isAlertLogout) {
        _isAlertLogout = @(isLogout);
    }
}

- (BOOL)getIsAlertLogout{
    @synchronized(_isAlertLogout) {
        return [_isAlertLogout boolValue];
    }
}



#pragma mark reachability 网络断开处理

- (void)registerForNetworkReachabilityNotifications
{
    if (_reachability == nil) {
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    [self unsubscribeFromNetworkReachabilityNotifications];
    [_reachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification object:nil];
}


- (void)unsubscribeFromNetworkReachabilityNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}


- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* reachability = note.object;
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    if (networkStatus != NotReachable) {
        if (!self.isLogin) {
            // 重新获取网络后
        }
    }
}

- (NetworkStatus)networkStatus{
    return [_reachability currentReachabilityStatus];
}


#pragma mark 网络任务管理

- (NSMutableDictionary *)dicNetworkTask{
    if(!_dicNetworkTask){
        _dicNetworkTask = [NSMutableDictionary new];
    }
    return _dicNetworkTask;
}

- (void)addTask:(NSURLSessionDataTask *)task userInfo:(NSDictionary *)userInfo{
    if(task && userInfo){
        NSString *viewName = @"";
        DicHasKeyAndDo(userInfo, KVIEWNAME, viewName = [userInfo objectForKey:KVIEWNAME];)
        if(viewName.length > 0){
            NSMutableArray *arrTasks = [self.dicNetworkTask objectForKey:viewName];
            if(arrTasks == nil){
                arrTasks = [NSMutableArray new];
            }
            [arrTasks addObject:task];
            [self.dicNetworkTask setObject:arrTasks forKey:viewName];
        }
    }
}

- (void)removeTask:(NSURLSessionDataTask *)task userInfo:(NSDictionary *)userInfo{
    if(task && userInfo){
        NSString *viewName = @"";
        DicHasKeyAndDo(userInfo, KVIEWNAME, viewName = [userInfo objectForKey:KVIEWNAME];)
        if(viewName.length > 0){
            NSMutableArray *arrTasks = [self.dicNetworkTask objectForKey:viewName];
            if(arrTasks && [arrTasks containsObject:task]){
                [arrTasks removeObject:task];
                [self.dicNetworkTask setObject:arrTasks forKey:viewName];
            }
        }
    }
}

@end
