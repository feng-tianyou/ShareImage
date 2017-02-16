//
//  DLoginService.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseService.h"
#import "DLoginParamProtocol.h"

@interface DLoginService : DBaseService

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
                  onError:(ErrorBlock)errorBlock;

@end
