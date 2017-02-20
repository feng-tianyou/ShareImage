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
 
 参数模型：DPhotosParamModel
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 order_by：排序（Valid values: latest, oldest, popular; default: latest）
 
 回调：requestServiceSucceedBackArray:
 
 @param paramModel 参数模型
 */
- (void)fetchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel;



/**
 获取单张图片详情
 
 参数模型：DPhotosParamModel
 pid：图片id（必须）
 w：图片宽度
 h：图片高度
 rect:裁剪矩形
 
 回调：requestServiceSucceedWithModel:

 @param paramModel 参数模型
 */
- (void)fetchPhotoDetailsByParamModel:(id<DPhotosParamProtocol>)paramModel;


/**
 随机获取一张图片
 
 参数模型：DPhotosParamModel
 根据分类id，collections;
 根据特色，featured;
 根据昵称，username;
 根据匹配，query;
 w	Image width in pixels.
 h	Image height in pixels.
 根据方向，orientation;
 获取张数 (Default: 1; max: 30)，count;（暂时不开放）
 
 回调：requestServiceSucceedWithModel:
 
 @param paramModel 参数模型
 */
- (void)fetchRandomPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel;


/**
 获取图片的统计信息
 
 参数模型：DPhotosParamModel
 pid：图片id（必须）
 
 回调：requestServiceSucceedWithModel:
 
 @param paramModel 参数模型
 */
- (void)fetchPhotoStatsByParamModel:(id<DPhotosParamProtocol>)paramModel;


/**
 获取图片的下载地址
 
 参数模型：DPhotosParamModel
 pid：图片id（必须）
 
 回调：requestServiceSucceedBackString:
 
 @param paramModel 参数模型
 */
- (void)fetchPhotoDownloadLinkByParamModel:(id<DPhotosParamProtocol>)paramModel;


/**
 更新图片（没有权限）
 
 参数模型：DPhotosParamModel
 pid：图片id（必须）
 
 纬度,latitude;
 经度,longitude;
 城市,city;
 国家,country;
 城市名称,name;
 confidential;
 光圈,perture_value;
 曝光,exposure_time;
 焦距,focal_length;
 iso,iso_speed_ratings;
 相机名称,make;
 相机型号,model;
 
 回调：requestServiceSucceedWithModel:
 
 @param paramModel 参数模型
 */
//- (void)updatePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel;


/**
 喜欢图片
 
 参数模型：DPhotosParamModel
 pid：图片id（必须）
 
 回调：requestServiceSucceedWithModel:
 
 @param paramModel 参数模型
 */
- (void)likePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel;

/**
 取消喜欢图片
 
 参数模型：DPhotosParamModel
 pid：图片id（必须）
 
 回调：requestServiceSucceedWithModel:
 
 @param paramModel 参数模型
 */
- (void)unLikePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel;

@end
