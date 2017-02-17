//
//  DPhotosNetwork.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotosNetwork.h"

@implementation DPhotosNetwork

#pragma mark 单例实现初始化
+(DPhotosNetwork *)shareEngine
{
    static DPhotosNetwork *_engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _engine = [[DPhotosNetwork alloc] initWithDefaultHttpURL];
    });
    return _engine;
}

/**
 获取首页图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel
                  onSucceeded:(NSArrayBlock)succeededBlock
                      onError:(ErrorBlock)errorBlock{
    NSDictionary *paramDic = [paramModel getParamDicForGetPhotos];
    [self opGetWithUrlPath:@"/photos" params:paramDic needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}

@end