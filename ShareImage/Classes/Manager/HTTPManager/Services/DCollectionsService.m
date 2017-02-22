//
//  DCollectionsService.m
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionsService.h"
#import "DCollectionsNetwork.h"

#import "DCollectionsModel.h"

#import "DCollectionsVaildRule.h"

@implementation DCollectionsService

/**
 获取分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                         onSucceeded:(NSArrayBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock{
    [self.network getCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        DLog(@"%@", arr);
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            DCollectionsModel *model = [DCollectionsModel modelWithJSON:dic];
            [tmpArr addObject:model];
        }];
        [DBlockTool executeArrBlock:succeededBlock arrResult:[tmpArr copy]];
    } onError:errorBlock];
}


/**
 获取精选分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchFeaturedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                                 onSucceeded:(NSArrayBlock)succeededBlock
                                     onError:(ErrorBlock)errorBlock{
    [self.network getFeaturedCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        DLog(@"%@", arr);
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            DCollectionsModel *model = [DCollectionsModel modelWithJSON:dic];
            [tmpArr addObject:model];
        }];
        [DBlockTool executeArrBlock:succeededBlock arrResult:[tmpArr copy]];
    } onError:errorBlock];
}


/**
 获取策划分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCuratedCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                                onSucceeded:(NSArrayBlock)succeededBlock
                                    onError:(ErrorBlock)errorBlock{
    [self.network getCuratedCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        DLog(@"%@", arr);
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            DCollectionsModel *model = [DCollectionsModel modelWithJSON:dic];
            [tmpArr addObject:model];
        }];
        [DBlockTool executeArrBlock:succeededBlock arrResult:[tmpArr copy]];
    } onError:errorBlock];
}


/**
 获取单个分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                        onSucceeded:(JsonModelBlock)succeededBlock
                            onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DCollectionsVaildRule checkCollectionIDByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getCollectionByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        DCollectionsModel *model = [DCollectionsModel modelWithJSON:dic];
        [DBlockTool executeModelBlock:succeededBlock model:model];
    } onError:errorBlock];
}


/**
 获取单个策划分类
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCuratedCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel
                               onSucceeded:(JsonModelBlock)succeededBlock
                                   onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DCollectionsVaildRule checkCollectionIDByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getCuratedCollectionByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        DCollectionsModel *model = [DCollectionsModel modelWithJSON:dic];
        [DBlockTool executeModelBlock:succeededBlock model:model];
    } onError:errorBlock];
}







@end
