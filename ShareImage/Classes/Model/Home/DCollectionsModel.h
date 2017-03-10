//
//  DCollectionsModel.h
//  ShareImage
//
//  Created by FTY on 2017/2/21.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DJsonModel.h"
#import "DPhotosModel.h"

@interface DCollectionsModel : DJsonModel
/// 分类id
@property (nonatomic, assign) long long c_id;
/// 分类标题
@property (nonatomic, copy) NSString *title;
/// 分类描述
@property (nonatomic, copy) NSString *c_description;
/// 发布时间
@property (nonatomic, copy) NSString *published_at;
///
@property (nonatomic, assign) BOOL curated;
///
@property (nonatomic, assign) BOOL featured;
/// 总图片
@property (nonatomic, assign) NSInteger total_photos;
/// 是否私人
@property (nonatomic, assign) BOOL c_private;
///
@property (nonatomic, copy) NSString *share_key;
/// 图片
@property (nonatomic, strong) DPhotosModel *cover_photo;

/// 图片连接
@property (nonatomic, strong) DPhotosLinksModel *c_links;

/// 用户
@property (nonatomic, strong) DUserModel *c_user;


@end
