//
//  DCollectionsService.h
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseService.h"
#import "DCollectionParamProtocol.h"

@interface DCollectionsService : DBaseService

/**
 获取分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                       onSucceeded:(NSArrayBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock;


/**
 获取精选分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchFeaturedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                               onSucceeded:(NSArrayBlock)succeededBlock
                                   onError:(ErrorBlock)errorBlock;


/**
 获取策划分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCuratedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                              onSucceeded:(NSArrayBlock)succeededBlock
                                  onError:(ErrorBlock)errorBlock;



/**
 获取单个分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                      onSucceeded:(JsonModelBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock;


/**
 获取单个策划分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCuratedCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                             onSucceeded:(JsonModelBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock;




/**
 获取分类的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCollectionPhotosByParamModel:(id<DCollectionParamProtocol>)paramModel
                            onSucceeded:(NSArrayBlock)succeededBlock
                                onError:(ErrorBlock)errorBlock;


/**
 获取策划分类的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCuratedCollectionPhotosByParamModel:(id<DCollectionParamProtocol>)paramModel
                                   onSucceeded:(NSArrayBlock)succeededBlock
                                       onError:(ErrorBlock)errorBlock;



/**
 获取分类相关的分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCollectionRelatedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                                        onSucceeded:(NSArrayBlock)succeededBlock
                                            onError:(ErrorBlock)errorBlock;


/**
 创建分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)createCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                       onSucceeded:(JsonModelBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock;


/**
 更新分类的信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)updateCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                      onSucceeded:(JsonModelBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock;


/**
 删除分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)removeCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                         onSucceeded:(BoolBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock;


/**
 添加图片到分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)addPhotoToCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                              onSucceeded:(JsonModelBlock)succeededBlock
                                  onError:(ErrorBlock)errorBlock;

@end
