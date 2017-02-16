//
//  DLoginManager.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseManager.h"
#import "DLoginParamProtocol.h"
#import "DLoginParamModel.h"

@interface DLoginManager : DBaseManager

/**
 *  用户登陆
 
 *  userNo       用户账号
 *  password     用户密码
 
 成功回调
 *  callbackMethor <- requestServiceSucceedByUserInfo  -> 回调方法
 
 错误处理
 *  callbackMethor <- requestServiceSucceedBackErrorType:ErrorTypeForAlertResetPassword  -> 回调方法
 
 *  callbackMethor <- requestServiceSucceedBackErrorType: result:model  -> 回调方法
 ErrorTypeForPushToChangeDeviceView 跳转至验证设备页面
 ErrorTypeForPushToCheckUserInfoView 跳转至确认个人资料页面
 *  callbackModel  <- TGUserInfoConfirmModel -> 回调Model
 */
- (void)loginByParamModel:(id<DLoginParamProtocol>)paramModel;


/**
 第三方登录，获取用户信息
 
 @param platformType 登录平台
 */
- (void)loginByThirdPlatform:(LoginPlatformType)platformType;

@end
