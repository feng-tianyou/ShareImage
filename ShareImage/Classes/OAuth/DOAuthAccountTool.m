//
//  DOAuthAccountTool.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DOAuthAccountTool.h"

#define kAccountUrl  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation DOAuthAccountTool

/**
 归档一个对象
 
 @param account 对象
 */
+ (void)saveAccount:(DOAuthAccountModel *)account{
    NSDate *nowTime = [NSDate date];
    account.expiresTime = [nowTime dateByAddingTimeInterval:account.created_at];
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountUrl];
    
}

/**
 获取账号信息
 
 @return 对象
 */
+ (DOAuthAccountModel *)account{
    DOAuthAccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountUrl];
    NSDate *nowTime = [NSDate date];
    if ([nowTime compare:account.expiresTime] == NSOrderedAscending) {
        // 没过期
        return account;
    } else {
        return nil;
    }
}

@end
