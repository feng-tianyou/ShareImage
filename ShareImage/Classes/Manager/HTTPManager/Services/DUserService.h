//
//  DUserService.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseService.h"
#import "DOAuthParamProtocol.h"

@interface DUserService : DBaseService
/**
 授权
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)oauthAccountByParamModel:(id<DOAuthParamProtocol>)paramModel
                     onSucceeded:(JsonModelBlock)succeededBlock
                         onError:(ErrorBlock)errorBlock;

/**
 *  获取用户信息
 *
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
-(void)fetchAccountByOnSucceeded:(JsonModelBlock)succeededBlock
                       onError:(ErrorBlock)errorBlock;

/**
 *  获取用户信息(不使用缓存)
 *
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
-(void)fetchAccountWithNotCacheByOnSucceeded:(JsonModelBlock)succeededBlock onError:(ErrorBlock)errorBlock;

@end
