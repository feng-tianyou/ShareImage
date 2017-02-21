//
//  DSearchCollectionsModel.m
//  ShareImage
//
//  Created by FTY on 2017/2/21.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchCollectionsModel.h"

@implementation DSearchCollectionsModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"collections":@"results"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"collections":[DCollectionsModel class]};
}

@end
