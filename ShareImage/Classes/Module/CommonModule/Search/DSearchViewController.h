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

@end
