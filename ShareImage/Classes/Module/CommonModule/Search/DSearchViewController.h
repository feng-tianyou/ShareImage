//
//  DSearchViewController.h
//  ShareImage
//
//  Created by DaiSuke on 2017/3/1.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseViewController.h"

typedef NS_ENUM(NSInteger, SearchType) {
    UserSearchType,
    PhotoSearchType,
    CollectionSearchType,
    OtherSearchType
};

@interface DSearchViewController : DBaseViewController

- (instancetype)initWithSearchType:(SearchType)searchType;

@property (nonatomic, assign, readonly) SearchType searchType;

@end
