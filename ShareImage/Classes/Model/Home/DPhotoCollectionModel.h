//
//  DPhotoCollectionModel.h
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//  添加图片到分类所需要的模型

#import "DJsonModel.h"
#import "DPhotosModel.h"
#import "DUserModel.h"
#import "DCollectionsModel.h"

@interface DPhotoCollectionModel : DJsonModel

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, strong) DPhotosModel *photo;
@property (nonatomic, strong) DUserModel *user;
@property (nonatomic, strong) DCollectionsModel *collection;


@end
