//
//  DUserModel.h
//  DFrame
//
//  Created by DaiSuke on 16/10/10.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DJsonModel.h"

@interface DUserLinksModel : DJsonModel

@property (nonatomic, copy) NSString *followers;
@property (nonatomic, copy) NSString *following;
@property (nonatomic, copy) NSString *html;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *photos;
@property (nonatomic, copy) NSString *portfolio;
// self
@property (nonatomic, copy) NSString *selfLinks;

@end

@interface DUserProfileImageModel : DJsonModel

@property (nonatomic, copy) NSString *large;
@property (nonatomic, copy) NSString *medium;
@property (nonatomic, copy) NSString *small;

@end

@interface DUserModel : DJsonModel
// id
@property (nonatomic, copy) NSString *uid;//用户id
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *portfolio_url;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *Instagram;
@property (nonatomic, copy) NSString *first_name;
@property (nonatomic, copy) NSString *last_name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, assign) NSInteger total_collections;
@property (nonatomic, assign) NSInteger total_likes;
@property (nonatomic, assign) NSInteger total_photos;

@property (nonatomic, strong) DUserLinksModel *links;
@property (nonatomic, strong) DUserProfileImageModel *profile_image;


@end
