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
             @"c_private":@"private"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"cover_photo":[DPhotosModel class]};
}

@end
