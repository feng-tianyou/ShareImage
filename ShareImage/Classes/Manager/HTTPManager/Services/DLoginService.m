//
//  DLoginService.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DLoginService.h"
#import "DLoginValidRule.h"

// network
#import "DLoginNetwork.h"

@implementation DLoginService

/**
 *  当用户点击登陆，即调用此接口
 *
 *  userNo       用户账号
 *  password     用户密码
 
 *  @param paramModel     参数模型
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
- (void)loginByParamModel:(id<DLoginParamProtocol>)paramModel
              onSucceeded:(VoidBlock)succeededBlock
                  onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DLoginValidRule checkParamIsValidForLoginByParamModel:paramModel];
    if(strAlert.length > 0){
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    
    [self.network getTokenByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        if(RESPONSESUCCESS){
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:@(YES) forKey:[NSString stringWithFormat:kCacheIsLoginByUid,@(KGLOBALINFOMANAGER.uid)]];
            
            //登录成功后绑定阿里云账号
//            NSString *strUid = [NSString stringWithFormat:@"%@",@(KGLOBALINFOMANAGER.uid)];//6306134
//            [[TGALiPushManager share] bindAccountByAccountStr:strUid];
            
            NSDictionary *dicData = [dic objectForKey:kParamData];
            BOOL changeDevice = NO;
            DicHasKeyAndDo(dicData, kParamDeviceChanged, changeDevice = [[dicData objectForKey:kParamDeviceChanged] boolValue];);
            
            if(changeDevice){
                //清除本地缓存
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [KGLOBALINFOMANAGER clearLocalUserInfo];
                    [KGLOBALINFOMANAGER startUpdateUserInfo];
                });
            }
            else{
                //添加登录成功之后获取用户信息
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [KGLOBALINFOMANAGER startUpdateUserInfo];
                });
            }
            
            [DBlockTool executeVoidBlock:succeededBlock];
        }
    } onError:errorBlock];
}

@end
