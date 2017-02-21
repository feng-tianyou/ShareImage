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

/**
 获取单张图片详情
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getPhotoDetailsByParamModel:(id<DPhotosParamProtocol>)paramModel
                 onSucceeded:(NSDictionaryBlock)succeededBlock
                     onError:(ErrorBlock)errorBlock{
    
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/photos/%@", paramModel.pid] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 随机获取一张图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getRandomPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                       onSucceeded:(NSDictionaryBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetRandomPhoto];
    
    [self opGetWithUrlPath:@"/photos/random" params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            ExistActionDo(succeededBlock, succeededBlock(responseObject));
        }
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}

/**
 获取图片的统计信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getPhotoStatsByParamModel:(id<DPhotosParamProtocol>)paramModel
                      onSucceeded:(NSDictionaryBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock{
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/photos/%@/stats", paramModel.pid] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 获取图片的下载地址
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getPhotoDownloadLinkByParamModel:(id<DPhotosParamProtocol>)paramModel
                             onSucceeded:(NSDictionaryBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock{
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/photos/%@/download", paramModel.pid] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 更新图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)putUpdatePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                       onSucceeded:(NSDictionaryBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock{
    [self opPutWithUrlPath:[NSString stringWithFormat:@"/photos/%@", paramModel.pid] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}



/**
 喜欢图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postLikePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                      onSucceeded:(NSDictionaryBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock{
    [self opPostWithUrlPath:[NSString stringWithFormat:@"/photos/%@/like", paramModel.pid] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 取消喜欢图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)deleteUnLikePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                          onSucceeded:(NSDictionaryBlock)succeededBlock
                              onError:(ErrorBlock)errorBlock{
    [self opDeleteWithUrlPath:[NSString stringWithFormat:@"/photos/%@/like", paramModel.pid] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}



/**
 搜索图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getSearchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel
                        onSucceeded:(NSDictionaryBlock)succeededBlock
                            onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetSearchPhotos];
    [self opGetWithUrlPath:@"/search/photos" params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 搜索分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getSearchCollectionsByParamModel:(id<DPhotosParamProtocol>)paramModel
                             onSucceeded:(NSDictionaryBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetSearchPhotos];
    [self opGetWithUrlPath:@"/search/collections" params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}














@end
