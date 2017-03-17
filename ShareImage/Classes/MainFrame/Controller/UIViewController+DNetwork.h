//
//  UIViewController+DNetwork.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBaseManagerProtocol.h"

#define kVIEW_IMG_RELOAD_WIDTH        88
#define kVIEW_IMG_RELOAD_HEIGHT       80


#define kVIEW_TEXT_LOGOUT_CHANGE_DEVICE   @"您的账号在其他设备登录，\n请重新登录后继续使用"
#define kVIEW_TEXT_LOGOUT_NOVALID         @"您的账号登录失效，\n请重新登录后继续使用"
#define kVIEW_TEXT_LOGOUT_NOVERIFYCODE    @"您的账号在此设备中尚未通过短信验证，请重新登录"
#define kVIEW_TEXT_LOGOUT_NORMAL          @"你确定要退出此帐号吗？"
#define kVIEW_TEXT_LOGOUT_EDIT_PSW        @"密码修改成功\n请使用新密码重新登录"


#define kVIEW_KEY_LOGOUT      @"logout_key"
#define kVIEW_KEY_ERROR       @"error_key"
#define kVIEW_KEY_DATE        @"error_date"
#define kVIEW_KEY_CONTENT     @"error_content"
#define kVIEW_ERROR_SAVE_TIME 86400

#define kErrorNeedBackKey           @"error_need_back"

@protocol NoNetworkButtonDelegate <NSObject>

- (void)pressNoNetworkBtnToRefresh;
- (void)pressNoDataBtnToRefresh;

@end

@interface UIViewController (DNetwork)<DBaseManagerProtocol, NoNetworkButtonDelegate>

#pragma mark - 属性
@property (nonatomic,strong) UIControl *noNetworkAlertView;
@property (nonatomic,strong) UIView *networkLoadingView;
@property (nonatomic,strong) UIControl *networkErrorReloadView;
@property (nonatomic,weak) id<NoNetworkButtonDelegate> noNetworkDelegate;

@property (nonatomic, strong) DNoDataView *noDataView;


#pragma mark - Methor

/**
 断网通知
 */
- (void)noNetworkNotify;

/**
 *  添加断网提示页面
 *
 *  @param inView 断网提示页面需要添加到哪个页面
 */
- (void)addNotNetworkAlertViewAddInView:(UIView *)inView;

/**
 *  添加断网提示页面
 *
 *  @param inView 断网提示页面需要添加到哪个页面
 *  @param customY 在页面Y轴距离父view的顶部的距离
 */
- (void)addNotNetworkAlertViewAddInView:(UIView *)inView customY:(CGFloat)customY;

/**
 *  移除断网提示页面
 */
- (void)removeNoNetworkAlertView;

/**
 *  添加网络错误重新加载页面
 *
 *  @param inView 网络错误重新加载页面需要添加到哪个页面
 */
- (void)addnetworkErrorReloadViewAddInView:(UIView *)inView;

/**
 *  移除网络错误重新加载页面
 */
- (void)removeNetworkErrorReloadView;

/**
 *  网络请求加载动画
 *
 *  @param strText 现在加载的文字提示
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
 *  UI本地错误提示
 *
 *  @param alertText         提示内容
 *  @param isAlertFor2Second yes：弹自定义提示控件 no：弹提示对话框
 */
- (void)localError:(NSString *)alertText isAlertFor2Second:(BOOL)isAlertFor2Second;


/**
 吐司弹出成功提示

 @param strText 内容
 */
- (void)localShowSuccess:(NSString *)strText;


/**
 *  账号异常时让用户退出并重新登录，跳转至登陆页面
 */
- (void)logoutByType:(LogoutType)type;



/**
 *  添加空白页面重新加载页面
 *
 *  @param inView 空白页面重新加载页面需要添加到哪个页面
 */
- (void)addNoDataViewAddInView:(UIView *)inView;
/**
 *  移除空白页面重新加载页面
 */
- (void)removeNoDataView;


#pragma mark - 重写方法

/**
 *  锁UI
 */
- (void)lockUI;

/**
 *  解除UI锁定
 */
- (void)unlockUI;

//网络超时-重新获取数据
- (void)reloadDataForBadNetwork;

//网络错误-重新获取数据
- (void)addReloadViewForNetworkError;


@end
