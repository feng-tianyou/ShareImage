//
//  DOAuthAccountTool.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOAuthAccountModel.h"

@interface DOAuthAccountTool : NSObject

/**
 归档一个对象

 @param account 对象
 */
+ (void)saveAccount:(DOAuthAccountModel *)account;


/**
 获取账号信息

 @return 对象
 */
+ (DOAuthAccountModel *)account;

@end
