//
//  DUserModel.h
//  DFrame
//
//  Created by DaiSuke on 16/10/10.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DJsonModel.h"

@interface DUserLinksModel : DJsonModel
/// 关注你的用户地址
@property (nonatomic, copy) NSString *followers;
/// 我关注的用户地址
@property (nonatomic, copy) NSString *following;
/// 个人主页地址
@property (nonatomic, copy) NSString *html;
/// 我喜欢的图片地址
@property (nonatomic, copy) NSString *likes;
/// 我的图片地址
@property (nonatomic, copy) NSString *photos;
/// 我的图片简介
@property (nonatomic, copy) NSString *portfolio;
/// self，当前用户的个人简介地址
@property (nonatomic, copy) NSString *selfLinks;

@end

@interface DUserProfileImageModel : DJsonModel
/// 个人头像大图
@property (nonatomic, copy) NSString *large;
/// 个人头像中图
@property (nonatomic, copy) NSString *medium;
/// 个人头像小图
@property (nonatomic, copy) NSString *small;

@end

@interface DUserModel : DJsonModel
/// 用户id
@property (nonatomic, copy) NSString *uid;//用户id
/// numberid
@property (nonatomic, assign) long long numeric_id;
/// 用户名称
@property (nonatomic, copy) NSString *name;
/// 用户昵称
@property (nonatomic, copy) NSString *username;
/// 个人简介地址
@property (nonatomic, copy) NSString *portfolio_url;
/// 个人简介
@property (nonatomic, copy) NSString *bio;
/// Instagram
@property (nonatomic, copy) NSString *Instagram;
/// Instagram名称
@property (nonatomic, copy) NSString *instagram_username;
/// email
@property (nonatomic, copy) NSString *email;
/// 名字的前半部
@property (nonatomic, copy) NSString *first_name;
/// 名字的后半部
@property (nonatomic, copy) NSString *last_name;
/// 位置
@property (nonatomic, copy) NSString *location;
/// 分类集合
@property (nonatomic, assign) NSInteger total_collections;
/// 总喜欢数
@property (nonatomic, assign) NSInteger total_likes;
/// 总图片数
@property (nonatomic, assign) NSInteger total_photos;
/// 图片的下载及介绍连接模型
@property (nonatomic, strong) DUserLinksModel *links;
/// 个人头像的图片地址
@property (nonatomic, strong) DUserProfileImageModel *profile_image;

/// 用户的照片集合
@property (nonatomic, strong) NSArray *u_photos;
/// 是否被用户喜欢
@property (nonatomic, assign) BOOL followed_by_user;
/// 关注数
@property (nonatomic, assign) NSInteger following_count;
/// 粉丝数
@property (nonatomic, assign) NSInteger followers_count;
/// 下载数
@property (nonatomic, assign) NSInteger downloads;
///
@property (nonatomic, assign) BOOL completed_onboarding;
/// 剩余上传图片数
@property (nonatomic, assign) NSInteger uploads_remaining;
/// 提醒数字
@property (nonatomic, assign) NSInteger badge;




@end
