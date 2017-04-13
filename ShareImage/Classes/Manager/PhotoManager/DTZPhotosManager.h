//
//  DTZPhotosManager.h
//  ShareImage
//
//  Created by FTY on 2017/4/13.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotoManager.h"

@class PHAsset;
@interface DTZPhotosManager : DPhotoManager



#pragma mark - 图片选择器相关-TZImagePickerController
/// 用户选中过的图片数组
@property (nonatomic, strong) NSArray<PHAsset *> *selectedAssets;

#pragma mark - 浏览图片相关-TZPhotoPreviewController
@property (nonatomic, strong) NSArray<PHAsset *> *photoArr;                ///< All photos / 所有图片的数组(PHAsset类型)
@property (nonatomic, assign) NSInteger currentIndex;           ///< Index of the photo user click / 用户点击的图片的索引
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;       ///< If YES,return original photo / 是否返回原图

/// Return the new selected photos / 返回最新的选中图片数组
@property (nonatomic, copy) void (^backButtonClickBlock)(BOOL isSelectOriginalPhoto);
@property (nonatomic, copy) void (^okButtonClickBlock)(BOOL isSelectOriginalPhoto);




#pragma mark - TZImagePickerController
/**
 图片选择器
 ps:页面自动消失，有两个选择：一个是通过相机，一个是通过相册
 (TZImagePickerController)
 
 ps: maxImagesCount:默认限制9张
 
 数据返回：通过didFinishPickingPhotosHandleBlock或者didFinishPickingPhotosWithInfosHandleBlock
 
 */
- (void)photoPickerWithCurrentViewController:(UIViewController *)currentViewController;

/**
 图片选择器
 ps:页面自动消失，有两个选择：一个是通过相机，一个是通过相册
 (TZImagePickerController)
 
 @param maxImagesCount 限制张数
 @param currentViewController 当前控制器
 
 数据返回：通过didFinishPickingPhotosHandleBlock或者didFinishPickingPhotosWithInfosHandleBlock
 
 */
- (void)photoPickerWithMaxImagesCount:(NSInteger)maxImagesCount currentViewController:(UIViewController *)currentViewController;

/**
 图片选择器
 ps:页面自动消失，有两个选择：一个是通过相机，一个是通过相册
 (TZImagePickerController)
 
 @param maxImagesCount 限制张数
 @param selectedAssets 已选的相片集合
 @param currentViewController 当前控制器
 
 数据返回：通过didFinishPickingPhotosHandleBlock或者didFinishPickingPhotosWithInfosHandleBlock
 
 */
- (void)photoPickerWithMaxImagesCount:(NSInteger)maxImagesCount
                       selectedAssets:(NSArray<PHAsset *> *)selectedAssets
                currentViewController:(UIViewController *)currentViewController;


#pragma mark - TZPhotoPreviewController
/**
 浏览图片(自动关闭页面)(TZPhotoPreviewController)
 
 @param photoArray 图片集合（PHAsset）
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotoArray:(NSArray *)photoArray
                      currentIndex:(NSInteger)currentIndex
             currentViewController:(UIViewController *)currentViewController;


@end
