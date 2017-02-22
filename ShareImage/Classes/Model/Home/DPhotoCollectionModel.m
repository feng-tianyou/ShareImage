//
//  DPhotoCollectionModel.m
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotoCollectionModel.h"

@implementation DPhotoCollectionModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"photo":[DUserModel class],
             @"user":[DUserModel class],
             @"collection":[DUserModel class]};
}

@end
