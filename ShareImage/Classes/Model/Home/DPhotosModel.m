//
//  DPhotosModel.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotosModel.h"

@implementation DPhotosLinksModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"selfUrl":@"self"};
}

@end

@implementation DPhotosUrlsModel



@end


@implementation DPhotosModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"pid":@"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"user":[DUserModel class],
             @"urls":[DPhotosUrlsModel class],
             @"links":[DPhotosLinksModel class]};
}

@end
