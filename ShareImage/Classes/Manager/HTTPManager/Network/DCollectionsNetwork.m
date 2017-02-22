//
//  DCollectionsNetwork.m
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionsNetwork.h"

@implementation DCollectionsNetwork
#pragma mark 单例实现初始化
+(DCollectionsNetwork *)shareEngine
{
    static DCollectionsNetwork *_engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _engine = [[DCollectionsNetwork alloc] initWithDefaultHttpURL];
    });
    return _engine;
}

/**
 获取分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                       onSucceeded:(NSArrayBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetCollections];
    [self opGetWithUrlPath:@"/collections" params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}

@end
