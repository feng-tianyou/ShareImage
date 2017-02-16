//
//  DLoginNetwork.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DLoginNetwork.h"

@implementation DLoginNetwork

#pragma mark 单例实现初始化
+ (DLoginNetwork *)shareEngine
{
    static DLoginNetwork *_engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _engine = [[DLoginNetwork alloc] initWithDefaultHttpURL];
    });
    return _engine;
}

/**
 *  获取授权码
 *
 *  @param paramModel     参数模型
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
-(void)getTokenByParamModel:(id<DLoginParamProtocol>)paramModel
                onSucceeded:(NSDictionaryBlock)succeededBlock
                    onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetToken];
    [self opGetWithUrlPath:kPathTokenIndex params:dicParam needUUID:YES needToken:NO onSucceeded:^(NSDictionary *dic) {
        NSDictionary *dicData = [dic objectForKey:kParamData];
        [self setUserDefaultByDicData:dicData];
        ExistActionDo(succeededBlock, succeededBlock(dic));
    } onError:errorBlock];
}

- (void)oauthAccountByParamModel:(id<DOAuthParamProtocol>)paramModel
                     onSucceeded:(NSDictionaryBlock)succeededBlock
                         onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForOAuthAccount];
    [self opPostWithUrlPath:@"https://unsplash.com/oauth/token" params:dicParam needUUID:NO needToken:NO onSucceeded:^(NSDictionary *dic) {
        ExistActionDo(succeededBlock, succeededBlock(dic));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
    
    
}

@end
