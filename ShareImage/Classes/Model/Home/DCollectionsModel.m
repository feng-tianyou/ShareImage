//
//  DCollectionsModel.m
//  ShareImage
//
//  Created by FTY on 2017/2/21.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionsModel.h"

@implementation DCollectionsModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"c_id":@"id",
             @"c_description":@"description",
             @"c_private":@"private",
             @"c_links":@"links",
             @"c_user":@"user"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"cover_photo":[DPhotosModel class],
             @"c_links":[DPhotosLinksModel class],
             @"c_user":[DUserModel class]};
}

@end
