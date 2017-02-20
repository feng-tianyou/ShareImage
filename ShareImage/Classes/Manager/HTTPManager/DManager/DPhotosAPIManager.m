//
//  DPhotosAPIManager.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotosAPIManager.h"
#import "DPhotosService.h"

@implementation DPhotosAPIManager

/**
 获取首页图片集合
 
 @param paramModel 参数模型
 */
- (void)fetchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel{
    
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    
    [self.service fetchPhotosByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        
        //分页处理:当start为0时需要做clearData处理，当获取的arr数据为空时，调用相关方法告知页面没有数据
        if([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]){
            return;
        }
        
        [self requestServiceSucceedBackArray:arr];
        
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}

/**
 获取单张图片详情
 
 @param paramModel 参数模型
 */
- (void)fetchPhotoDetailsByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
    [self.service fetchPhotoDetailsByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}

/**
 随机获取一张图片
 
 @param paramModel 参数模型
 */
- (void)fetchRandomPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self.service fetchRandomPhotoByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}

/**
 获取图片的统计信息
 
 @param paramModel 参数模型
 */
- (void)fetchPhotoStatsByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self.service fetchPhotoStatsByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}

/**
 获取图片的下载地址
 
 参数模型：DPhotosParamModel
 pid：图片id（必须）
 
 回调：requestServiceSucceedWithModel:
 
 @param paramModel 参数模型
 */
- (void)fetchPhotoDownloadLinkByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self.service fetchPhotoDownloadLinkByParamModel:paramModel onSucceeded:^(NSString *str) {
        [self requestServiceSucceedBackString:str];
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}

@end
