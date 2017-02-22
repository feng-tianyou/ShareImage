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




@end
