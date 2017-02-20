//
//  DPhotosModel.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotosModel.h"
/**
 图片分类模型
 */
@implementation DPhotosCategoriesLinksModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"selfCategoriesLinksUrl":@"self"};
}

@end

/**
 图片分类模型
 */
@implementation DPhotosCategoriesModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"cid":@"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"links":[DPhotosCategoriesLinksModel class]};
}

@end


/**
 图片下载路径模型
 */
@implementation DPhotosLinksModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"selfPhotosLinksUrl":@"self"};
}

@end

/**
 图片的大小图路径模型
 */
@implementation DPhotosUrlsModel



@end

/**
 拍摄工具模型
 */
@implementation DPhotosExifModel



@end

/**
 经纬度
 */
@implementation DPhotosPositionModel



@end

/**
 相片的地点坐标
 */
@implementation DPhotosLocationModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"position":[DPhotosPositionModel class]};
}

@end


@implementation DPhotosModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"pid":@"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"user":[DUserModel class],
             @"urls":[DPhotosUrlsModel class],
             @"links":[DPhotosLinksModel class],
             @"categories":[DPhotosCategoriesModel class]};
}





@end
