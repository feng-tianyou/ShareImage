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

@end
