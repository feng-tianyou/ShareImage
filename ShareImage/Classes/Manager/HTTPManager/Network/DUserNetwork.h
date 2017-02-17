//
//  DUserNetwork.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseNetwork.h"
#import "DOAuthParamProtocol.h"

@interface DUserNetwork : DBaseNetwork

#pragma mark 单例实现初始化
+ (DUserNetwork *)shareEngine;


- (void)oauthAccountByParamModel:(id<DOAuthParamProtocol>)paramModel
                     onSucceeded:(NSObjectBlock)succeededBlock
                         onError:(ErrorBlock)errorBlock;

/**
 *  获取用户信息
 *
 *  @param isNeedCache    是否需要调用缓存
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
- (void)getAccountNeedCache:(BOOL)isNeedCache
               onSucceeded:(NSDictionaryBlock)succeededBlock
                   onError:(ErrorBlock)errorBlock;

@end
