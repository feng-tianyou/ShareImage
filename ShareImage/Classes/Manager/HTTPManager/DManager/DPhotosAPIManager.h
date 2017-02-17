//
//  DPhotosAPIManager.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseManager.h"
#import "DPhotosParamProtocol.h"

@interface DPhotosAPIManager : DBaseManager

/**
 获取首页图片集合
 
 @param paramModel 参数模型
 */
- (void)fetchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel;



/**
 获取单张图片详情

 @param paramModel 参数模型
 */
- (void)fetchPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel;






@end
