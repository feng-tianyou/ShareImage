//
//  DLoginManager.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DLoginManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import "DLoginService.h"





static NSInteger iErrorCount = 0;
@implementation DLoginManager

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
- (void)loginByParamModel:(id<DLoginParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self)
    [self.service loginByParamModel:paramModel onSucceeded:^{
        iErrorCount = 0;
        //登录成功之后跳转到主页面
        [self requestServiceSucceedByUserInfo];
    } onError:^(DError *error) {
        @strongify(self)
        int errorCode = [DErrorRespone getErrorCodeByError:error];
        switch (errorCode) {
            case 10002:{
                if(iErrorCount >= 2){
                    [self requestServiceSucceedBackErrorType:ErrorTypeForAlertResetPassword];
                    iErrorCount = 0;
                }
                else{
                    iErrorCount++;
                    [self proccessNetwordError:error];
                }
                break;
            }
            default:{
                [self proccessNetwordError:error];
            }
                break;
        }
    }];
}


/**
 第三方登录，获取用户信息
 
 @param platformType 登录平台
 */
- (void)loginByThirdPlatform:(LoginPlatformType)platformType{
    UMSocialPlatformType type = -2;
    BOOL flag = NO;
    NSString *message = @"";
    switch (platformType) {
        case LoginPlatformType_Sina:
            type = UMSocialPlatformType_Sina;
            flag = YES;
            break;
        case LoginPlatformType_Wechat:
        {
            flag = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
            type = UMSocialPlatformType_WechatSession;
            message = @"手机未安装微信，授权失败";
        }
            break;
        case LoginPlatformType_QQ:
        {
            flag = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
            type = UMSocialPlatformType_QQ;
            message = @"手机未安装QQ，授权失败";
        }
            break;
            
        default:
            break;
    }
    
    if (!flag) {
        [self proccessLocalErrorByText:message];
        return;
    }
    
    //    if (type == UMSocialPlatformType_WechatSession) {
    //        [self proccessLocalErrorByText:@"很遗憾，微信登录需要300元/年，作者没钱"];
    //        return;
    //    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        DLog(@" uid: %@", resp.uid);
        DLog(@" openid: %@", resp.openid);
        DLog(@" accessToken: %@", resp.accessToken);
        DLog(@" refreshToken: %@", resp.refreshToken);
        DLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        DLog(@" name: %@", resp.name);
        DLog(@" iconurl: %@", resp.iconurl);
        DLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        DLog(@" originalResponse: %@", resp.originalResponse);
        if (resp.uid.length == 0 || resp.uid == nil) {
            [self requestServiceSucceedBackErrorType:ErrorTypeForAlertUserThirdLoginFail result:@"授权失败"];
            return ;
        }
        DUserModel *user = [[DUserModel alloc] init];
        KGLOBALINFOMANAGER.thirdUid = resp.uid;
        KGLOBALINFOMANAGER.accessToken = resp.accessToken;
        KGLOBALINFOMANAGER.refreshToken = resp.refreshToken;
        user.thirdUid = resp.uid;
        user.name = resp.name;
        user.iconurl = resp.iconurl;
        user.sex = resp.gender;
        KGLOBALINFOMANAGER.accountInfo = user;
        [self requestServiceSucceedByUserInfo];
    }];
}








@end
