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
 
 参数模型：DPhotosParamModel
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 order_by：排序（Valid values: latest, oldest, popular; default: latest）
 
 回调：requestServiceSucceedBackArray:
 
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
 
 参数模型：DPhotosParamModel
 pid：图片id
 w：图片宽度
 h：图片高度
 rect:裁剪矩形
 
 回调：requestServiceSucceedWithModel:
 
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

@end
