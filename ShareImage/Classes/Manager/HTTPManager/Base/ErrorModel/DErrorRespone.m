//
//  DErrorRespone.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DErrorRespone.h"

@implementation DErrorRespone

/**
 *  获取错误码
 *
 *  @param error 错误对象
 *
 *  @return 错误码
 */
+ (int)getErrorCodeByError:(DError *)error{
    int errorCode = 0;
    if([error.errorCode hasPrefix:@"0x"])
    {
        errorCode = [[error.errorCode substringFromIndex:2] intValue];
    }
    else{
        errorCode = [error.errorCode intValue];
    }
    return errorCode;
}

/**
 *  获取错误提示
 *
 *  @param error 错误对象
 *
 *  @return 错误提示
 */
+ (NSString *)errorResponseByError:(DError *)error
{
    NSString *strDescription = @"";
    
    if([error.errorCode hasPrefix:@"0x"])
    {
        int errorCode = [self getErrorCodeByError:error];
        switch (errorCode) {
            case 0:
            {
                return @"操作成功";
            }
            case 1:
            {
                return @"您的帐号在其他客户端登陆过，\r请重新登陆";
            }
            case 2:
            {
                return [NSString stringWithFormat:@"%@",error.errorDescription];
            }
            case 3:
            {
                return @"出现异常，连接已断开";
            }
            case 4:
            case 5:
            {
                return @"出现异常，请稍后重新尝试";
            }
            case 7:
            {
                return @"您输入的帐号不存在，\r请确认后重新输入";
            }
            case 10001:
            {
                return @"您输入的帐号不存在，\r请确认后重新输入";
                break;
            }
            case 10002:
            {
                return @"您输入的密码有误，\r请重新输入";
            }
            case 10003:
            {
                return @"设备未通过短信验证";
            }
            case 10004:
            {
                return @"此手机号码已注册，请换用其他手机号注册或用此手机号登陆";
            }
            case 10005:
            {
                return @"该手机号未注册";
            }
            case 10006:
            {
                return @"验证码已过期，请尝试再次获取新的验证码";
            }
            case 10007:
            {
                return @"验证码不正确，请核对是否与短信中的验证码一致";
            }
            case 10008:
            {
                return @"请输入您的真实姓名，方便您以后的业务合作";
            }
            case 10009:
            {
                return @"您的帐号长时间未登陆，为了您的帐号安全，请重新登陆";
            }
            case 20001:
            {
                return @"好友申请不存在";
            }
            case 20002:
            {
                return @"好友不存在";
            }
            case 20003:
            {
                return @"非好友关系";
            }
            case 20004:
            {
                return @"您已达好友上限，暂时不能添加好友";
            }
            case 20005:
            {
                return @"对方超出好友上限";
            }
            case 30001:
            {
                return @"已达人数上限";
            }
            case 30002:
            {
                return @"不是群聊成员";
            }
            case 40002:
            {
                return @"您查看的项目超出了您购买的服务地区，有需要请联系客服：020-66351168";
            }
            case 40003:
            {
                return @"您的工程信息帐号尚未激活，请联系客服激活：020-66351168";
            }
            default:
            {
                //                return [NSString stringWithFormat:@"%@:%d",error.errorDescription,[error.errorCode intValue]];
                return [NSString stringWithFormat:@"%@",error.errorDescription];
            }
                break;
        }
    }
    else
    {
        //        strDescription = [NSString stringWithFormat:@"%@:%@",error.errorDescription,error.errorCode];
        strDescription = [NSString stringWithFormat:@"%@",error.errorDescription];
    }
    
    return strDescription;
}

/**
 *  错误处理
 *
 *  @param engineError       错误对象
 *  @param delegate          实现代理
 *  @param isAlertFor2Second 是否提示两秒消失
 */
+ (void)proccessError:(DError *)engineError delegate:(id<DBaseManagerProtocol>)delegate isAlertFor2Second:(BOOL)isAlertFor2Second UserInfo:(NSDictionary *)userInfo
{
    int errorCode = [DErrorRespone getErrorCodeByError:engineError];
    DLocalError *localError = [[DLocalError alloc] init];
    localError.isAlertFor2Second = isAlertFor2Second;
    localError.errCode = errorCode;
    switch (errorCode) {
        
        case 301:{
            [DCacheManager setCacheObjectByData:nil forKey:KVIEW_KEY_LOGOUT];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIF_LOGOUT_KEY object:nil userInfo:@{KLOGOUT_TYPE:@(LogoutTypeForNoOAuth)}];
            return;
        }
        case 422:{
            localError.alertText = @"参数错误";
        }
        case -1011:{
            localError.alertText = @"服务器错误";
            
            if ([engineError.errorDescription isContainsString:@"401"]) {
                [DCacheManager setCacheObjectByData:nil forKey:KVIEW_KEY_LOGOUT];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIF_LOGOUT_KEY object:nil userInfo:@{KLOGOUT_TYPE:@(LogoutTypeForNoOAuth)}];
                return;
            }
            
            if ([engineError.errorDescription isContainsString:@"403"]) {
                localError.alertText = @"没有权限访问";
            }
            
            if ([engineError.errorDescription isContainsString:@"500"]) {
                localError.alertText = @"服务器错误";
            }
            
            
            }
            break;
        default:{
            localError.alertText = [DErrorRespone errorResponseByError:engineError];
            break;
        }
    }
    if(delegate && [delegate respondsToSelector:@selector(localError:userInfo:)]){
        [delegate localError:localError userInfo:userInfo];
    }
    else{
        DLog(@"未实现localError:UserInfo:方法");
    }
}


@end
