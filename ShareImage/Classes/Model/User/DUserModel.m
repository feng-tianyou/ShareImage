//
//  DUserModel.m
//  DFrame
//
//  Created by DaiSuke on 16/10/10.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DUserModel.h"

@implementation DUserLinksModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"selfLinks":@"self"};
}

@end


@implementation DUserProfileImageModel



@end

@implementation DUserModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"profile_image":[DUserProfileImageModel class],
             @"links":[DUserLinksModel class]};
}


@end
