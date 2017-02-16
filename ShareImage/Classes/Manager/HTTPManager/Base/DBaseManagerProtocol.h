//
//  DBaseManagerProtocol.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DJsonModel;
@protocol DBaseManagerProtocol <NSObject>


@optional
/**
 *  网络请求加载动画
 */
- (void)addNetworkLoadingViewByText:(NSString *)strText userInfo:(NSDictionary *)userInfo;

/**
 *  移除网络请求加载动画
 */
- (void)removeNetworkLoadingView;

/**
 *  本地错误提示
 *
 *  @param localError 根据对象的isAlertFor2Second判断提示类型，yes：弹自定义提示控件 no：弹提示对话框
 *                    根据对象的titleText显示提示标题（标题不存在时不显示,只有提示框才有效）
 *                    根据对象的alertText显示提示内容
 */
- (void)localError:(DLocalError *)localError userInfo:(NSDictionary *)userInfo;

/**
 *  账号异常时让用户退出并重新登录，跳转至登陆页面
 */
- (void)logoutByType:(LogoutType)type;

/**
 *  列表(清空UI缓存列表数据)
 */
- (void)clearData;

/**
 *  列表(数据已没有更多)
 */
- (void)hasNotMoreData;

/**
 *  列表(没有相关的数据)
 */
- (void)alertNoData;


/**
 *  锁UI
 */
- (void)lockUI;

/**
 *  解除UI锁定
 */
- (void)unlockUI;

/**
 请求service层成功时的回调方法
 
 @param userInfo 附带信息
 */
- (void)requestServiceSucceedByUserInfo:(NSDictionary *)userInfo;


/**
 请求service层成功时的回调方法
 
 @param isTrue 请求返回的数据
 @param userInfo 附带信息
 */
- (void)requestServiceSucceedBackBool:(BOOL)isTrue userInfo:(NSDictionary *)userInfo;


/**
 请求service层成功时的回调方法
 
 @param strData 请求返回的数据
 @param userInfo 附带信息
 */
- (void)requestServiceSucceedBackString:(NSString *)strData userInfo:(NSDictionary *)userInfo;


/**
 请求service层成功时的回调方法
 
 @param identityId 请求返回的数据
 @param userInfo 附带信息
 */
- (void)requestServiceSucceedBackLongLongValue:(long long)identityId userInfo:(NSDictionary *)userInfo;


/**
 请求service层成功时的回调方法
 
 @param arrData 请求返回的数据
 @param userInfo 附带信息
 */
- (void)requestServiceSucceedBackArray:(NSArray *)arrData userInfo:(NSDictionary *)userInfo;


/**
 请求service层成功时的回调方法
 
 @param dataModel 请求返回的数据
 @param userInfo 附带信息
 */
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo;


/**
 请求service层成功时的回调方法
 
 @param errorType 请求返回的数据
 @param userInfo 附带信息
 */
- (void)requestServiceSucceedBackErrorType:(ErrorType)errorType userInfo:(NSDictionary *)userInfo;


/**
 请求service层成功时的回调方法
 
 @param errorType 错误类型
 @param result 请求返回的数据
 @param userInfo 附带信息
 */
- (void)requestServiceSucceedBackErrorType:(ErrorType)errorType result:(__kindof id)result userInfo:(NSDictionary *)userInfo;


@end
