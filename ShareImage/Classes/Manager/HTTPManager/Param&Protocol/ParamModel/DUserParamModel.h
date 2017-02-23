//
//  DUserParamModel.h
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUserParamProtocol.h"

@interface DUserParamModel : NSObject<DUserParamProtocol>
/// 昵称
@property (nonatomic, copy) NSString *username;
/// 姓
@property (nonatomic, copy) NSString *first_name;
/// 名
@property (nonatomic, copy) NSString *last_name;
/// email
@property (nonatomic, copy) NSString *email;
/// 个人简介地址
@property (nonatomic, copy) NSString *url;
/// 地址
@property (nonatomic, copy) NSString *location;
/// 简介
@property (nonatomic, copy) NSString *bio;
/// instagram昵称
@property (nonatomic, copy) NSString *instagram_username;
/// 页数，默认1
@property (nonatomic, assign) NSInteger page;
/// 每页多少条，默认10
@property (nonatomic, assign) NSInteger per_page;
/// 排序：(Valid values: latest, oldest, popular; default: latest)
@property (nonatomic, copy) NSString *order_by;

@end
