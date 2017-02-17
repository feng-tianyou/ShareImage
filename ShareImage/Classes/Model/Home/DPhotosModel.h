//
//  DPhotosModel.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DJsonModel.h"
@class DUserModel;

@interface DPhotosLinksModel : DJsonModel

@property (nonatomic, copy) NSString *download;
@property (nonatomic, copy) NSString *download_location;
@property (nonatomic, copy) NSString *html;
// self
@property (nonatomic, copy) NSString *selfUrl;

@end


@interface DPhotosUrlsModel : DJsonModel

@property (nonatomic, copy) NSString *full;
@property (nonatomic, copy) NSString *raw;
@property (nonatomic, copy) NSString *regular;
@property (nonatomic, copy) NSString *small;
@property (nonatomic, copy) NSString *thumb;

@end


@interface DPhotosModel : DJsonModel
// id
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, assign) NSInteger liked_by_user;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, strong) NSArray *current_user_collections;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, strong) DPhotosUrlsModel *urls;
@property (nonatomic, strong) DPhotosLinksModel *links;
@property (nonatomic, strong) DUserModel *user;

@end
