//
//  DCommonPhotoController.h
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseViewController.h"

typedef NS_ENUM(NSInteger, APIManagerType) {
    UserAPIManagerType,
    CollectionAPIManagerType
};

@interface DCommonPhotoController : DBaseViewController

@property (nonatomic, copy) NSString *username;
@property (nonatomic, assign) long long collectionId;

- (instancetype)initWithTitle:(NSString *)title type:(APIManagerType)type;

@end
