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
//    [self addLoadingView];
    [self.service fetchPhotosByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        [self requestServiceSucceedBackArray:arr];
    } onError:^(DError *error) {
        [self proccessNetwordError:error];
    }];
}

@end
