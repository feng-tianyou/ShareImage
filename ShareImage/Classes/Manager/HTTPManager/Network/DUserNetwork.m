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
    
    [self opGetWithUrlPath:kPathAccount params:nil needUUID:NO needToken:YES onSucceeded:^(NSDictionary *dic) {
        if(HTTPSTATECODESUCCESS){
            [KGLOBALINFOMANAGER clearAccountInfo];
            NSData *dataUser = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
            [manager writeDataToPlistByFileName:userInfoKey data:dataUser];
        }
        ExistActionDo(succeededBlock, succeededBlock(dic));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}

@end
