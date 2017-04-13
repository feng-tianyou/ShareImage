//
//  DPhotoManager.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/7.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//  此类必须作为强引用的全局变量，不然无法返回图片

#import <Foundation/Foundation.h>
@class PHAsset,DPhotosModel;

@interface DPhotoManager : NSObject

#pragma mark - 公共设置
/// 最大限制张数
@property (nonatomic, assign) NSInteger maxImagesCount;

/// block返回图片等资源
@property (nonatomic, copy) void (^didFinishPickingPhotosHandleBlock)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto);
@property (nonatomic, copy) void (^didFinishPickingPhotosWithInfosHandleBlock)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto,NSArray<NSDictionary *> *infos);


@property (nonatomic, strong) UIViewController *currentViewController;


#pragma mark - 方法

/**
 类方法初始化

 @return 初始化对象
 */
+ (instancetype)manager;




@end
