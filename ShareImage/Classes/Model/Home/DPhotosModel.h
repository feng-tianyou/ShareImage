//
//  DPhotosModel.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DJsonModel.h"
@class DUserModel;

/**
 图片分类模型
 */
@interface DPhotosCategoriesLinksModel : DJsonModel
@property (nonatomic, copy) NSString *photos;
@property (nonatomic, copy) NSString *selfCategoriesLinksUrl;
@end


/**
 图片分类模型
 */
@interface DPhotosCategoriesModel : DJsonModel
@property (nonatomic, assign) long cid;
@property (nonatomic, strong) DPhotosCategoriesLinksModel *links;
@property (nonatomic, assign) long photo_count;
@property (nonatomic, copy) NSString *title;
@end


/**
 图片下载路径模型
 */
@interface DPhotosLinksModel : DJsonModel
/// 下载地址
@property (nonatomic, copy) NSString *download;
/// 下载地址
@property (nonatomic, copy) NSString *download_location;
/// 图片HTML
@property (nonatomic, copy) NSString *html;
/// self，图片当前路径
@property (nonatomic, copy) NSString *selfPhotosLinksUrl;

@end

/**
 图片的大小图路径模型
 */
@interface DPhotosUrlsModel : DJsonModel
/// 全图
@property (nonatomic, copy) NSString *full;
/// 原图
@property (nonatomic, copy) NSString *raw;
/// 正常
@property (nonatomic, copy) NSString *regular;
/// 小图
@property (nonatomic, copy) NSString *small;
/// 缩略图
@property (nonatomic, copy) NSString *thumb;
@end



/**
 拍摄工具模型
 */
@interface DPhotosExifModel : DJsonModel
// 光圈
@property (nonatomic, copy) NSString *aperture;
// 曝光
@property (nonatomic, copy) NSString *exposure_time;
// 焦距
@property (nonatomic, assign) NSInteger focal_length;
// iso
@property (nonatomic, assign) NSInteger iso;
// 相机名称
@property (nonatomic, copy) NSString *make;
// 相机型号
@property (nonatomic, copy) NSString *model;
@end



/**
 经纬度
 */
@interface DPhotosPositionModel : DJsonModel
/// 纬度
@property (nonatomic, copy) NSString *latitude;
/// 经度
@property (nonatomic, copy) NSString *longitude;
@end


/**
 相片的地点坐标
 */
@interface DPhotosLocationModel : DJsonModel
/// 城市
@property (nonatomic, copy) NSString *city;
/// 国家
@property (nonatomic, copy) NSString *country;
/// 城市名称
@property (nonatomic, copy) NSString *name;
/// 经纬度
@property (nonatomic, strong) DPhotosPositionModel *position;
@end


/**
 图片总模型
 */
@interface DPhotosModel : DJsonModel
/// 图片id
@property (nonatomic, copy) NSString *pid;
/// 喜欢你的用户个数
@property (nonatomic, assign) NSInteger liked_by_user;
/// 喜欢图片的个数
@property (nonatomic, assign) NSInteger likes;
/// 分类 --DPhotosCategoriesModel
@property (nonatomic, strong) NSArray *categories;
/// 颜色
@property (nonatomic, copy) NSString *color;
/// 创建时间
@property (nonatomic, copy) NSString *created_at;
/// 当前用户集合
@property (nonatomic, strong) NSArray *current_user_collections;
/// 图片的高度
@property (nonatomic, assign) NSInteger height;
/// 图片的宽度
@property (nonatomic, assign) NSInteger width;
/// 图片的路径模型（高清、缩略等）
@property (nonatomic, strong) DPhotosUrlsModel *urls;
/// 图片的下载及介绍连接模型
@property (nonatomic, strong) DPhotosLinksModel *links;
/// 图片的作者信息
@property (nonatomic, strong) DUserModel *user;
/// 图片的拍摄工具
@property (nonatomic, strong) DPhotosExifModel *exif;
/// 图片的地址信息
@property (nonatomic, strong) DPhotosLocationModel *location;

// 单张图片详情新增
/// 图片的下载数
@property (nonatomic, assign) NSInteger downloads;
/// 图片的标题
@property (nonatomic, copy) NSString *title;


@end
