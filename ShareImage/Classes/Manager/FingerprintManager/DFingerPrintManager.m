//
//  DFingerPrintManager.m
//  DFrame
//
//  Created by DaiSuke on 2017/2/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DFingerPrintManager.h"

#define kLocalizedFallbackTitle     @"忘记密码"
#define kLocalizedReason            @"请按住Home键完成验证"

@implementation DFingerPrintManager

/**
 判断设备是否支持指纹识别功能
 
 @return 是否支持
 */
+ (BOOL)canEvaluatePolicy{
    // 初始化上下文对象
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    BOOL result = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    DLog(@"DFingerPrintManager - canEvaluatePolicy errror:%@", error);
    return result;
}


/**
 加载指纹验证
 
 @param localizedFallbackTitle 按钮文字，默认：忘记密码
 @param localizedReason 提示文字（副标题），默认：请按住Home键完成验证
 @param policyBlock 回调
 */
+ (void)loadAuthenticationWithPolicyBlock:(PolicyBlock)policyBlock{
    [self loadAuthenticationWithLocalizedFallbackTitle:kLocalizedFallbackTitle localizedReason:kLocalizedReason policyBlock:policyBlock];
}


/**
 加载指纹验证
 
 @param localizedFallbackTitle 按钮文字，默认：忘记密码
 @param localizedReason 提示文字（副标题），默认：请按住Home键完成验证
 @param policyBlock 回调
 */
+ (void)loadAuthenticationWithLocalizedFallbackTitle:(NSString *)localizedFallbackTitle localizedReason:(NSString *)localizedReason policyBlock:(PolicyBlock)policyBlock{
    
    localizedFallbackTitle = localizedFallbackTitle.length > 0 ? localizedFallbackTitle : kLocalizedFallbackTitle;
    
    localizedReason = localizedReason.length > 0 ? localizedReason : kLocalizedReason;
    
    // 初始化上下文对象
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = localizedFallbackTitle;
    
    NSError *authError = nil;
    NSString *localzedReasonString = localizedReason;
    // 判断设备是否支持指纹识别
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localzedReasonString reply:^(BOOL success, NSError * _Nullable error) {
            
            // 执行block
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                ExistActionDo(policyBlock, policyBlock(success, error));
            }];
            
            // 下面可定制
            if (success) {
                DLog(@"指纹认证成功");
                
            } else {
                DLog(@"指纹认证失败， error :%@", error.description);
                DLog(@"%ld", (long)error.code); // 错误码 error.code
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                    {
                        DLog(@"授权失败"); // -1 连续三次指纹识别错误
                    }
                        break;
                    case LAErrorUserCancel:
                    {
                        DLog(@"用户取消验证Touch ID"); // -2 在TouchID对话框中点击了取消按钮
                    }
                        break;
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            DLog(@"用户选择输入密码，切换主线程处理"); // -3 在TouchID对话框中点击了输入密码按钮
                        }];
                    }
                        break;
                    case LAErrorSystemCancel:
                    {
                        DLog(@"取消授权，如其他应用切入，用户自主"); // -4 TouchID对话框被系统取消，例如按下Home或者电源键
                    }
                        break;
                    case LAErrorPasscodeNotSet:
                    {
                        DLog(@"设备系统未设置密码"); // -5
                    }
                        break;
                    case LAErrorTouchIDNotAvailable:
                    {
                        DLog(@"设备未设置Touch ID"); // -6
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled:
                    {
                        DLog(@"用户未录入指纹"); // -7
                    }
                        break;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
                    case LAErrorTouchIDLockout:
                    {
                        DLog(@"Touch ID被锁，需要用户输入密码解锁"); // -8 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
                    }
                        break;
                    case LAErrorAppCancel:
                    {
                        // 如突然来了电话，电话应用进入前台，APP被挂起啦
                        DLog(@"用户不能控制情况下APP被挂起"); // -9
                    }
                        break;
                    case LAErrorInvalidContext:
                    {
                        DLog(@"LAContext传递给这个调用之前已经失效"); // -10
                    }
                        break;
                        
#endif
                        
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            DLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                        
                }
            }
        }];
    } else {
        DLog(@"设备不支持指纹");
        // 回调
        ExistActionDo(policyBlock, policyBlock(NO, authError));
        switch (authError.code)
        {
            case LAErrorTouchIDNotEnrolled:
            {
                DLog(@"用户未录入指纹");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                DLog(@"设备系统未设置密码");
                break;
            }
            default:
            {
                DLog(@"TouchID not available");
                break;
            }
        }
    }
}


@end
