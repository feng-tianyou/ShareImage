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

@end
