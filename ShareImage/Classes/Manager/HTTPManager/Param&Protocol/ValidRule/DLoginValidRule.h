//
//  DLoginValidRule.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//  登录请求模块参数验证类

#import <Foundation/Foundation.h>
#import "DLoginParamProtocol.h"

@interface DLoginValidRule : NSObject


+ (NSString *)checkParamIsValidForLoginByParamModel:(id<DLoginParamProtocol>)paramModel;

@end
