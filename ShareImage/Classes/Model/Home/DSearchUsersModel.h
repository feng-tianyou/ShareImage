//
//  DSearchUsersModel.h
//  ShareImage
//
//  Created by FTY on 2017/2/21.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DJsonModel.h"

@interface DSearchUsersModel : DJsonModel

/// 用户模型数组
@property (nonatomic, strong) NSArray *users;
/// 总条数
@property (nonatomic, assign) NSInteger total;
/// 总页数
@property (nonatomic, assign) NSInteger total_pages;

@end
