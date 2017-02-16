//
//  DUserModel.h
//  DFrame
//
//  Created by DaiSuke on 16/10/10.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DJsonModel.h"

@interface DUserModel : DJsonModel

@property (nonatomic, assign) long long uid;//用户id
@property (nonatomic, copy) NSString *thirdUid;//第三方用户id
@property (nonatomic, copy) NSString *iconurl;//头像地址
@property (nonatomic, copy) NSString *job;//职位
@property (nonatomic, copy) NSString *name;//真实姓名
@property (nonatomic, copy) NSString *company;//公司全称
@property (nonatomic, copy) NSString *qq;//qq号码
@property (nonatomic, copy) NSString *email;//邮箱
@property (nonatomic, copy) NSString *address;//地址
@property (nonatomic, copy) NSString *sex;//性别
@property (nonatomic, copy) NSString *mobile;//手机号码
@property (nonatomic, copy) NSString *birthday;//生日

@end
