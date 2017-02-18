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

@end
