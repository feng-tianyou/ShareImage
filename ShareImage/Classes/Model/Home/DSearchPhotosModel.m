//
//  DSearchPhotosModel.m
//  ShareImage
//
//  Created by FTY on 2017/2/21.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchPhotosModel.h"


@implementation DSearchPhotosModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"photos":@"results"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"photos":[DPhotosModel class]};
}

@end
