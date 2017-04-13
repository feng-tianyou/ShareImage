//
//  DMWPhotosManager.h
//  ShareImage
//
//  Created by FTY on 2017/4/13.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotoManager.h"
@class DPhotosModel;
@interface DMWPhotosManager : DPhotoManager

@property (nonatomic, assign) NSInteger currentIndex;           ///< Index of the photo user click / 用户点击的图片的索引
@property (nonatomic, strong) NSArray<NSString *> *photoUrls;                ///< All photos / 所有图片的数组(相片路径)
@property (nonatomic, strong) NSArray<UIImage *> *photos;                ///< All photos / 所有图片的数组(UIImage类型)




/**
 浏览图片(自动关闭页面)(MWPhotoBrowser)
 
 @param photoUrls 图片路径集合
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotoUrls:(NSArray *)photoUrls
                     currentIndex:(NSInteger)currentIndex
            currentViewController:(UIViewController *)currentViewController;


/**
 浏览图片(自动关闭页面)(MWPhotoBrowser)
 
 @param photos 图片集合
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotos:(NSArray *)photos
                  currentIndex:(NSInteger)currentIndex
         currentViewController:(UIViewController *)currentViewController;


/**
 浏览图片(自动关闭页面)(MWPhotoBrowser)
 
 @param photoModels 图片集合
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotoModels:(NSArray<DPhotosModel *> *)photoModels
                       currentIndex:(NSInteger)currentIndex
              currentViewController:(UIViewController *)currentViewController;


/**
 浏览图片(自动关闭页面)(MWPhotoBrowser)
 
 @param photoUrls 图片路径集合
 @param photos 图片集合
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotoUrls:(NSArray *)photoUrls
                           photos:(NSArray *)photos
                     currentIndex:(NSInteger)currentIndex
            currentViewController:(UIViewController *)currentViewController;




@end
