//
//  DSearchViewController.h
//  ShareImage
//
//  Created by DaiSuke on 2017/3/1.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseViewController.h"



@interface DSearchViewController : DBaseViewController

- (instancetype)initWithSearchType:(SearchType)searchType;

@property (nonatomic, assign, readonly) SearchType searchType;

/**
 请求图片数据
 */
- (void)getSearchPhotosData;

/**
 请求用户数据
 */
- (void)getSearchUsersData;

/**
 请求分类数据
 */
- (void)getSearchCollectionsData;

@end
