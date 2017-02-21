//
//  DSearchCollectionsModel.h
//  ShareImage
//
//  Created by FTY on 2017/2/21.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DJsonModel.h"
#import "DCollectionsModel.h"

@interface DSearchCollectionsModel : DJsonModel

/// 分类模型数组
@property (nonatomic, strong) NSArray *collections;
/// 总条数
@property (nonatomic, assign) NSInteger total;
/// 总页数
@property (nonatomic, assign) NSInteger total_pages;

@end
