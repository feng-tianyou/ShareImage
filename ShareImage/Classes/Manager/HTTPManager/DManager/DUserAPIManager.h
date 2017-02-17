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

- (void)oauthAccountByModel:(id<DOAuthParamProtocol>)paramModel;


/**
 *  获取用户信息
 
 *  callbackMethor <- requestServiceSucceedWithModel -> 回调方法
 *  callbackModel  <- TGUserModel -> 回调Model
 */
-(void)getAccount;

/**
 *  获取用户信息(不使用缓存)
 
 *  callbackMethor <- requestServiceSucceedWithModel -> 回调方法
 *  callbackModel  <- TGUserModel -> 回调Model
 */
-(void)getAccountWithNotCache;

@end
