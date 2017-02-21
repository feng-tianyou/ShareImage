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

@property (nonatomic, assign) long c_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *c_description;
@property (nonatomic, copy) NSString *published_at;
@property (nonatomic, assign) BOOL curated;
@property (nonatomic, assign) BOOL featured;
@property (nonatomic, assign) NSInteger total_photos;
@property (nonatomic, assign) BOOL c_private;
@property (nonatomic, copy) NSString *share_key;
@property (nonatomic, strong) DPhotosModel *cover_photo;


@end
