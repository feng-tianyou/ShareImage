//
//  DUserProfileViewController.h
//  ShareImage
//
//  Created by FTY on 2017/2/24.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//  用户展示页面

#import "DBaseViewController.h"

typedef NS_ENUM(NSInteger, DUserProfileType)
{
    DUserProfileTypeForMine,
    DUserProfileTypeForOther
};

@interface DUserProfileViewController : DBaseViewController

- (instancetype)initWithUserName:(NSString *)userName type:(DUserProfileType)type;

@end
