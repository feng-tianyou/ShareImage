//
//  DFingerPrintManager.h
//  DFrame
//
//  Created by DaiSuke on 2017/2/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//  指纹验证管理类

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

typedef void (^PolicyBlock)(BOOL success, NSError *error);

@interface DFingerPrintManager : NSObject

/**
 判断设备是否支持指纹识别功能

 @return 是否支持
 */
+ (BOOL)canEvaluatePolicy;



/**
 加载指纹验证

 @param localizedFallbackTitle 按钮文字，默认：忘记密码
 @param localizedReason 提示文字（副标题），默认：请按住Home键完成验证
 @param policyBlock 回调
 */
+ (void)loadAuthenticationWithPolicyBlock:(PolicyBlock)policyBlock;



/**
 加载指纹验证

 @param localizedFallbackTitle 按钮文字，默认：忘记密码
 @param localizedReason 提示文字（副标题），默认：请按住Home键完成验证
 @param policyBlock 回调
 */
+ (void)loadAuthenticationWithLocalizedFallbackTitle:(NSString *)localizedFallbackTitle localizedReason:(NSString *)localizedReason policyBlock:(PolicyBlock)policyBlock;



@end
