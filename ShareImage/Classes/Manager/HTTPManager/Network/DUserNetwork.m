//
//  DUserNetwork.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DUserNetwork.h"
#import "DPlistManager.h"

@implementation DUserNetwork

#pragma mark 单例实现初始化
+(DUserNetwork *)shareEngine
{
    static DUserNetwork *_engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _engine = [[DUserNetwork alloc] initWithDefaultHttpURL];
    });
    return _engine;
}

/**
 授权
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postOauthAccountByParamModel:(id<DOAuthParamProtocol>)paramModel
                     onSucceeded:(NSDictionaryBlock)succeededBlock
                         onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForOAuthAccount];
    [self opPostWithUrlPath:@"https://unsplash.com/oauth/token" params:dicParam needUUID:NO needToken:NO onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
    
    
}


/**
 *  获取用户信息
 *
 *  @param isNeedCache    是否需要调用缓存
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
- (void)getAccountNeedCache:(BOOL)isNeedCache
                onSucceeded:(NSDictionaryBlock)succeededBlock
                    onError:(ErrorBlock)errorBlock{
    NSString *userInfoKey = [NSString stringWithFormat:kCacheAccountInfoByUid,self.userId];
    DPlistManager *manager = [DPlistManager shareManager];
    if(isNeedCache){
        
        NSData *data = [manager getBitDataByFileName:userInfoKey];
        if(data.length > 0){
            NSDictionary *dicUser = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            ExistActionDo(succeededBlock, succeededBlock(dicUser));
            return;
        }
    }
    
    [self opGetWithUrlPath:@"me" params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        [KGLOBALINFOMANAGER clearAccountInfo];
        NSData *dataUser = [NSJSONSerialization dataWithJSONObject:responseObject options:kNilOptions error:nil];
        [manager writeDataToPlistByFileName:userInfoKey data:dataUser];
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}

@end
