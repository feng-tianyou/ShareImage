//
//  DCollectionsAPIManager.h
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseManager.h"
#import "DCollectionParamProtocol.h"

@interface DCollectionsAPIManager : DBaseManager

/**
 获取分类集合
 
 参数模型：DCollectionsParamModel
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型
 */
- (void)fetchCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel;


/**
 获取精选分类集合
 
 参数模型：DCollectionsParamModel
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型
 */
- (void)fetchFeaturedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel;

/**
 获取策划分类集合
 
 参数模型：DCollectionsParamModel
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型
 */
- (void)fetchCuratedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel;

@end
