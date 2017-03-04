//
//  DUserListViewController.h
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseViewController.h"

typedef NS_ENUM(NSInteger, FollowType) {
    FollowingType,
    FollowersType
};

@interface DUserListViewController : DBaseViewController

- (instancetype)initWithTitle:(NSString *)title userName:(NSString *)userName type:(FollowType)type;

@end
