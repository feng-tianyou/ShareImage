//
//  DPhotosService.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseService.h"
#import "DPhotosParamProtocol.h"

@interface DPhotosService : DBaseService

/**
 获取首页图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel
                  onSucceeded:(NSArrayBlock)succeededBlock
                      onError:(ErrorBlock)errorBlock;


/**
 获取单张图片详情
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchPhotoDetailsByParamModel:(id<DPhotosParamProtocol>)paramModel
                          onSucceeded:(JsonModelBlock)succeededBlock
                       onError:(ErrorBlock)errorBlock;

/**
 随机获取一张图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchRandomPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                       onSucceeded:(JsonModelBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock;


/**
 获取图片的统计信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchPhotoStatsByParamModel:(id<DPhotosParamProtocol>)paramModel
                      onSucceeded:(JsonModelBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock;

/**
 获取图片的下载地址
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchPhotoDownloadLinkByParamModel:(id<DPhotosParamProtocol>)paramModel
                             onSucceeded:(NSStringBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock;


/**
 更新图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)updatePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                       onSucceeded:(JsonModelBlock)succeededBlock
                        onError:(ErrorBlock)errorBlock;




/**
 喜欢图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)likePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                      onSucceeded:(JsonModelBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock;

/**
 取消喜欢图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)unLikePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                          onSucceeded:(JsonModelBlock)succeededBlock
                        onError:(ErrorBlock)errorBlock;



/**
 搜索图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchSearchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel
                        onSucceeded:(JsonModelBlock)succeededBlock
                            onError:(ErrorBlock)errorBlock;


/**
 搜索分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchSearchCollectionsPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel
                             onSucceeded:(JsonModelBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock;



/**
 搜索用户
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchSearchUsersByParamModel:(id<DPhotosParamProtocol>)paramModel
                       onSucceeded:(JsonModelBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock;













@end
