//
//  DUserValidRule.h
//  ShareImage
//
//  Created by FTY on 2017/2/23.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUserParamProtocol.h"

@interface DUserValidRule : NSObject

+ (NSString *)checkUpdateAccountByParamModel:(id<DUserParamProtocol>)paramModel;

@end
