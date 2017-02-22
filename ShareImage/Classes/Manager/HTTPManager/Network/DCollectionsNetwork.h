//
//  DCollectionsNetwork.h
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseNetwork.h"
#import "DCollectionParamProtocol.h"

@interface DCollectionsNetwork : DBaseNetwork

#pragma mark 单例实现初始化
+ (DCollectionsNetwork *)shareEngine;

/**
 获取分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                  onSucceeded:(NSArrayBlock)succeededBlock
                      onError:(ErrorBlock)errorBlock;

/**
 获取精选分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getFeaturedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                       onSucceeded:(NSArrayBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock;

/**
 获取策划分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCuratedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                               onSucceeded:(NSArrayBlock)succeededBlock
                                   onError:(ErrorBlock)errorBlock;


/**
 获取单个分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                             onSucceeded:(NSDictionaryBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock;


/**
 获取单个策划分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCuratedCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                              onSucceeded:(NSDictionaryBlock)succeededBlock
                                  onError:(ErrorBlock)errorBlock;



/**
 获取分类的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCollectionPhotosByParamModel:(id<DCollectionParamProtocol>)paramModel
                      onSucceeded:(NSArrayBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock;


/**
 获取策划分类的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCuratedCollectionPhotosByParamModel:(id<DCollectionParamProtocol>)paramModel
                             onSucceeded:(NSArrayBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock;



/**
 获取分类相关的分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getCollectionRelatedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                                   onSucceeded:(NSArrayBlock)succeededBlock
                                       onError:(ErrorBlock)errorBlock;




/**
 创建分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                                        onSucceeded:(NSDictionaryBlock)succeededBlock
                                            onError:(ErrorBlock)errorBlock;


/**
 更新分类的信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)putCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                       onSucceeded:(NSDictionaryBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock;




@end
