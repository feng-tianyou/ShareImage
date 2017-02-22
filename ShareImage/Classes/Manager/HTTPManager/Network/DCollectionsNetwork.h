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


@end
