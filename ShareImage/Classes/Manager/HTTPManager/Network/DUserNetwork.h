//
//  DUserNetwork.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseNetwork.h"
#import "DOAuthParamProtocol.h"
#import "DUserParamProtocol.h"

@interface DUserNetwork : DBaseNetwork

#pragma mark 单例实现初始化
+ (DUserNetwork *)shareEngine;


/**
 授权

 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postOauthAccountByParamModel:(id<DOAuthParamProtocol>)paramModel
                     onSucceeded:(NSDictionaryBlock)succeededBlock
                         onError:(ErrorBlock)errorBlock;

/**
 *  获取个人信息
 *
 *  @param isNeedCache    是否需要调用缓存
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
- (void)getAccountNeedCache:(BOOL)isNeedCache
               onSucceeded:(NSObjectForCacheBlock)succeededBlock
                   onError:(ErrorBlock)errorBlock;



/**
 更改个人信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)putAccountByParamModel:(id<DUserParamProtocol>)paramModel
                         onSucceeded:(NSDictionaryBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock;



/**
 获取用户信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserProfileByParamModel:(id<DUserParamProtocol>)paramModel
                         onSucceeded:(NSObjectForCacheBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock;


/**
 获取用户介绍连接
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserProfileLinkByParamModel:(id<DUserParamProtocol>)paramModel
                       onSucceeded:(NSDictionaryBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock;



/**
 获取用户的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserPhotosByParamModel:(id<DUserParamProtocol>)paramModel
                           onSucceeded:(NSObjectForCacheBlock)succeededBlock
                               onError:(ErrorBlock)errorBlock;


/**
 获取用户喜欢的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserLikePhotosByParamModel:(id<DUserParamProtocol>)paramModel
                      onSucceeded:(NSObjectForCacheBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock;


/**
 获取用户分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserCollectionsByParamModel:(id<DUserParamProtocol>)paramModel
                          onSucceeded:(NSObjectForCacheBlock)succeededBlock
                              onError:(ErrorBlock)errorBlock;



/**
 获取用户关注的人
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserFollowingByParamModel:(id<DUserParamProtocol>)paramModel
                       onSucceeded:(NSObjectBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock;


/**
 获取用户粉丝
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserFollowersByParamModel:(id<DUserParamProtocol>)paramModel
                       onSucceeded:(NSObjectBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock;



@end
