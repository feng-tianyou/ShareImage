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
 
 参数模型：DCollectionsParamModel
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型
 */
- (void)fetchCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self);
    [self.service fetchCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        // 分页处理
        if ([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]) {
            return ;
        }
        
        [self requestServiceSucceedBackArray:arr];
        
        
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 获取精选分类集合
 
 参数模型：DCollectionsParamModel
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型
 */
- (void)fetchFeaturedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self);
    [self.service fetchFeaturedCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        // 分页处理
        if ([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]) {
            return ;
        }
        
        [self requestServiceSucceedBackArray:arr];
        
        
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 获取策划分类集合
 
 参数模型：DCollectionsParamModel
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型
 */
- (void)fetchCuratedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self);
    [self.service fetchCuratedCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        // 分页处理
        if ([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]) {
            return ;
        }
        
        [self requestServiceSucceedBackArray:arr];
        
        
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 获取单个分类
 
 参数模型：DCollectionsParamModel
 collection_id:分类id (Required)
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型;
 */
- (void)fetchCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service fetchCollectionByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 获取单个策划分类
 
 参数模型：DCollectionsParamModel
 collection_id:分类id(策划id) (Required)
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型;
 */
- (void)fetchCuratedCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service fetchCuratedCollectionByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 获取分类的图片集合
 
 collection_id:分类id (Required)
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedBackArray:(DPhotosModel)
 
 @param paramModel 参数模型;
 */
- (void)fetchCollectionPhotosByParamModel:(id<DCollectionParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self);
    [self.service fetchCollectionPhotosByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        // 分页处理
        if ([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]) {
            return ;
        }
        
        [self requestServiceSucceedBackArray:arr];
        
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 获取策划分类的图片集合
 
 collection_id:分类id(策划id) (Required)
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedBackArray:(DPhotosModel)
 
 @param paramModel 参数模型;
 */
- (void)fetchCuratedCollectionPhotosByParamModel:(id<DCollectionParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self);
    [self.service fetchCuratedCollectionPhotosByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        // 分页处理
        if ([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]) {
            return ;
        }
        
        [self requestServiceSucceedBackArray:arr];
        
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 获取分类相关的分类集合
 
 collection_id:分类id (Required)
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型
 */
- (void)fetchCollectionRelatedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self);
    [self.service fetchCollectionRelatedCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        // 分页处理
        if ([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]) {
            return ;
        }
        
        [self requestServiceSucceedBackArray:arr];
        
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 创建分类
 
 title:标题 (Required)
 description_c：描述（Optional）
 isPrivate：是否公开（Optional）
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型;
 */
- (void)createCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service createCollectionByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 更新分类的信息
 
 collection_id:分类id (Required)
 title:标题（Optional）
 description_c：描述（Optional）
 isPrivate：是否公开（Optional）
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型
 */
- (void)updateCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service updateCollectionByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 删除分类
 
 collection_id:分类id (Required)
 
 回调：requestServiceSucceedBackBool:(BOOL)
 
 @param paramModel 参数模型
 */
- (void)removeCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service removeCollectionByParamModel:paramModel onSucceeded:^(BOOL isTrue) {
        @strongify(self)
        [self requestServiceSucceedBackBool:isTrue];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 添加图片到分类
 
 collection_id:分类id (Required)
 photo_id:图片（Required）
 
 回调：requestServiceSucceedWithModel:(DPhotoCollectionModel)
 
 @param paramModel 参数模型
 */
- (void)addPhotoToCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service addPhotoToCollectionByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 删除分类的图片
 
 collection_id:分类id (Required)
 photo_id:图片（Required）
 
 回调：requestServiceSucceedWithModel:(DPhotoCollectionModel)
 
 @param paramModel 参数模型
 */
- (void)removePhotoToCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service removePhotoToCollectionByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}








@end
