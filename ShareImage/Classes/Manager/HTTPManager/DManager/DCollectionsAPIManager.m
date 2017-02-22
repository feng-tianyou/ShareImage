//
//  DCollectionsAPIManager.m
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionsAPIManager.h"
#import "DCollectionsService.h"

@implementation DCollectionsAPIManager
/**
 获取分类集合
 
 @param paramModel 参数模型
 */
- (void)fetchCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service fetchCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        
        // 分页处理
        if ([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]) {
            return ;
        }
        
        [self requestServiceSucceedBackArray:arr];
        
        
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}


/**
 获取精选分类集合
 
 @param paramModel 参数模型
 */
- (void)fetchFeaturedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service fetchFeaturedCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        
        // 分页处理
        if ([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]) {
            return ;
        }
        
        [self requestServiceSucceedBackArray:arr];
        
        
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}

@end
