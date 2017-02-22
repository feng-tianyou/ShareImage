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

/**
 获取策划分类集合
 
 @param paramModel 参数模型
 */
- (void)fetchCuratedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service fetchCuratedCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        
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
 获取单个分类
 
 @param paramModel 参数模型;
 */
- (void)fetchCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service fetchCollectionByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}


/**
 获取单个策划分类
 
 @param paramModel 参数模型;
 */
- (void)fetchCuratedCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service fetchCuratedCollectionByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}


/**
 获取分类的图片集合
 
 @param paramModel 参数模型;
 */
- (void)fetchCollectionPhotosByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service fetchCollectionPhotosByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        
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
 获取策划分类的图片集合
 
 @param paramModel 参数模型;
 */
- (void)fetchCuratedCollectionPhotosByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service fetchCuratedCollectionPhotosByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        
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
 获取分类相关的分类集合
 
 @param paramModel 参数模型
 */
- (void)fetchCollectionRelatedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service fetchCollectionRelatedCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        
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
 创建分类
 
 @param paramModel 参数模型;
 */
- (void)createCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service createCollectionByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}

/**
 更新分类的信息
 
 @param paramModel 参数模型
 */
- (void)updateCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service updateCollectionByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}


@end
