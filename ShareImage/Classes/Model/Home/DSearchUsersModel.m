//
//  DSearchUsersModel.m
//  ShareImage
//
//  Created by FTY on 2017/2/21.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSearchUsersModel.h"
#import "DUserModel.h"

@implementation DSearchUsersModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"users":@"results"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"users":[DUserModel class]};
}


@end
