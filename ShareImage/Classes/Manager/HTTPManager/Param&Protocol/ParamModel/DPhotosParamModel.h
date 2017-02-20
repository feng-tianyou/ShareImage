//
//  DPhotosParamModel.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPhotosParamProtocol.h"

@interface DPhotosParamModel : NSObject<DPhotosParamProtocol>

// ------获取图片集合
// 页数，默认1
@property (nonatomic, assign) NSInteger page;
// 每页多少条，默认10
@property (nonatomic, assign) NSInteger per_page;
// 排序：(Valid values: latest, oldest, popular; default: latest)
@property (nonatomic, copy) NSString *order_by;

// ------获取单张图片详情
// 图片ID
@property (nonatomic, copy) NSString *pid;
// 图片的宽度，以像素为单位
@property (nonatomic, assign) NSInteger width;
// 图片的高度，以像素为单位
@property (nonatomic, assign) NSInteger height;
// 裁剪rect，用逗号分隔整数，表示裁剪矩形的x,y,w,h
@property (nonatomic, copy) NSString *rect;

// ------随机获取一张图片
// 根据分类id
@property (nonatomic, copy) NSString *collections;
// 根据特色
@property (nonatomic, copy) NSString *featured;
// 根据昵称
@property (nonatomic, copy) NSString *username;
// 根据匹配
@property (nonatomic, assign) NSInteger query;
//w	Image width in pixels.
//h	Image height in pixels.
// 根据方向
@property (nonatomic, copy) NSString *orientation;
// 获取张数 (Default: 1; max: 30)
@property (nonatomic, assign) NSInteger count;

@end
