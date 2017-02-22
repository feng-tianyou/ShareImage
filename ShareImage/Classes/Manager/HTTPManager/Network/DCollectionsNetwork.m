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


/**
 获取精选分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getFeaturedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                               onSucceeded:(NSArrayBlock)succeededBlock
                                   onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetCollections];
    [self opGetWithUrlPath:@"/collections/featured" params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 获取策划分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCuratedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                              onSucceeded:(NSArrayBlock)succeededBlock
                                  onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetCollections];
    [self opGetWithUrlPath:@"/collections/curated" params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 获取单个分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                      onSucceeded:(NSDictionaryBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock{
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/collections/%@",@(paramModel.collection_id)] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 获取单个策划分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCuratedCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                             onSucceeded:(NSDictionaryBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock{
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/collections/curated/%@", @(paramModel.collection_id)] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 获取分类的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCollectionPhotosByParamModel:(id<DCollectionParamProtocol>)paramModel
                            onSucceeded:(NSArrayBlock)succeededBlock
                                onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetCollections];
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/collections/%@/photos",@(paramModel.collection_id)] params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 获取策划分类的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCuratedCollectionPhotosByParamModel:(id<DCollectionParamProtocol>)paramModel
                                   onSucceeded:(NSArrayBlock)succeededBlock
                                       onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetCollections];
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/collections/curated/%@/photos", @(paramModel.collection_id)] params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}

/**
 获取分类相关的分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCollectionRelatedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                                        onSucceeded:(NSArrayBlock)succeededBlock
                                            onError:(ErrorBlock)errorBlock{
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/collections/%@/related", @(paramModel.collection_id)] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 创建分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                       onSucceeded:(NSDictionaryBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForPostCollection];
    [self opPostWithUrlPath:@"/collections" params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 更新分类的信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)putCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                      onSucceeded:(NSDictionaryBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForPostCollection];
    [self opPutWithUrlPath:[NSString stringWithFormat:@"/collections/%@", @(paramModel.collection_id)] params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}

/**
 删除分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)deleteCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                         onSucceeded:(NSDictionaryBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock{
    [self opDeleteWithUrlPath:[NSString stringWithFormat:@"/collections/%@", @(paramModel.collection_id)] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 添加图片到分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postPhotoToCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                              onSucceeded:(NSDictionaryBlock)succeededBlock
                                  onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForPostPhotoToCollection];
    [self opPostWithUrlPath:[NSString stringWithFormat:@"/collections/%@/add", @(paramModel.collection_id)] params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 删除分类的图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)deletePhotoToCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                                onSucceeded:(NSDictionaryBlock)succeededBlock
                                    onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForPostPhotoToCollection];
    [self opDeleteWithUrlPath:[NSString stringWithFormat:@"/collections/%@/remove", @(paramModel.collection_id)] params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}








@end
