//
//  DUserAPIManager.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseManager.h"
#import "DOAuthParamProtocol.h"
#import "DOAuthParamModel.h"

@interface DUserAPIManager : DBaseManager

/**
 授权
 
 参数模型：DOAuthParamModel
 client_id：AppKey(Required)
 client_secret：秘钥;(Required)
 redirect_uri：回调地址;(Required)
 grant_type：授权类型 @"authorization_code";(Required)
 code：固定 code; (Required)
 
 回调：requestServiceSucceedWithModel:(DOAuthAccountModel)
 
 @param paramModel 参数模型
 */
- (void)oauthAccountByParamModel:(id<DOAuthParamProtocol>)paramModel;

/**
 *  获取用户信息
 
  回调：requestServiceSucceedWithModel:(DUserModel)
 *
 */
-(void)fetchAccountProfile;

/**
 *  获取用户信息(不使用缓存)
 
  回调：requestServiceSucceedWithModel:(DUserModel)
 *
 */
-(void)fetchAccountProfileWithNotCache;


@end
