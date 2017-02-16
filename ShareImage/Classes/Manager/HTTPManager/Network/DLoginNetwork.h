//
//  DLoginNetwork.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseNetwork.h"
#import "DLoginParamProtocol.h"

@interface DLoginNetwork : DBaseNetwork

#pragma mark 单例实现初始化
+ (DLoginNetwork *)shareEngine;

/**
 *  获取授权码
 *
 *  @param paramModel     参数模型
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
- (void)getTokenByParamModel:(id<DLoginParamProtocol>)paramModel
                onSucceeded:(NSDictionaryBlock)succeededBlock
                    onError:(ErrorBlock)errorBlock;

@end
