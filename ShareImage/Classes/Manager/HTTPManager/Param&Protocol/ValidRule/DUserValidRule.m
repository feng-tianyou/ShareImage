//
//  DUserValidRule.m
//  ShareImage
//
//  Created by FTY on 2017/2/23.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DUserValidRule.h"

@implementation DUserValidRule

+ (NSString *)checkUpdateAccountByParamModel:(id<DUserParamProtocol>)paramModel{
    if (![paramModel.email validateEmail]) {
        return @"邮箱格式不正确！";
    }
    return @"";
}

+ (NSString *)checkGetUserProfileByParamModel:(id<DUserParamProtocol>)paramModel{
    if (paramModel.username.length == 0) {
        return @"需要用户名！";
    }
    return @"";
}

@end
