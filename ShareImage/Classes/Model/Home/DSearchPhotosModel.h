//
//  DSearchPhotosModel.h
//  ShareImage
//
//  Created by FTY on 2017/2/21.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPhotosModel.h"

@interface DSearchPhotosModel : DJsonModel
/// 图片模型数组
@property (nonatomic, strong) NSArray *photos;
/// 总条数
@property (nonatomic, assign) NSInteger total;
/// 总页数
@property (nonatomic, assign) NSInteger total_pages;

@end
