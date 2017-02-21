//
//  DPhotosNetwork.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseNetwork.h"
#import "DPhotosParamProtocol.h"


@interface DPhotosNetwork : DBaseNetwork

#pragma mark 单例实现初始化
+ (DPhotosNetwork *)shareEngine;



/**
 获取首页图片集合

 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel
                  onSucceeded:(NSArrayBlock)succeededBlock
                      onError:(ErrorBlock)errorBlock;

/**
 获取单张图片详情
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getPhotoDetailsByParamModel:(id<DPhotosParamProtocol>)paramModel
                   onSucceeded:(NSDictionaryBlock)succeededBlock
                       onError:(ErrorBlock)errorBlock;


/**
 随机获取一张图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getRandomPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                       onSucceeded:(NSDictionaryBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock;


/**
 获取图片的统计信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getPhotoStatsByParamModel:(id<DPhotosParamProtocol>)paramModel
                        onSucceeded:(NSDictionaryBlock)succeededBlock
                            onError:(ErrorBlock)errorBlock;

/**
 获取图片的下载地址
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getPhotoDownloadLinkByParamModel:(id<DPhotosParamProtocol>)paramModel
                      onSucceeded:(NSDictionaryBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock;

/**
 更新图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)putUpdatePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                             onSucceeded:(NSDictionaryBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock;




/**
 喜欢图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postLikePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                       onSucceeded:(NSDictionaryBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock;



/**
 取消喜欢图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)deleteUnLikePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                      onSucceeded:(NSDictionaryBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock;


/**
 搜索图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getSearchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel
                          onSucceeded:(NSDictionaryBlock)succeededBlock
                              onError:(ErrorBlock)errorBlock;



/**
 搜索分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getSearchCollectionsByParamModel:(id<DPhotosParamProtocol>)paramModel
                        onSucceeded:(NSDictionaryBlock)succeededBlock
                            onError:(ErrorBlock)errorBlock;



/**
 搜索用户
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getSearchUsersByParamModel:(id<DPhotosParamProtocol>)paramModel
                             onSucceeded:(NSDictionaryBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock;










@end
