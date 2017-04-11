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

#pragma mark - 浏览图片相关-MWPhotoBrowser
@property (nonatomic, strong) NSArray<NSString *> *photoUrls;                ///< All photos / 所有图片的数组(相片路径)
@property (nonatomic, strong) NSArray<UIImage *> *photos;                ///< All photos / 所有图片的数组(UIImage类型)


#pragma mark - 方法

/**
 类方法初始化

 @return 初始化对象
 */
+ (instancetype)manager;


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


#pragma mark - MWPhotoBrowser
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





#pragma mark - 打开相机
/**
 打开相机

 @param currentViewController 当前控制器
 
 数据返回：通过didFinishPickingPhotosHandleBlock或者didFinishPickingPhotosWithInfosHandleBlock
 */
- (void)openCameraWithCurrentViewController:(UIViewController *)currentViewController;

#pragma mark - 打开相册
/**
 打开相册(如要设置相关参数，请在调用前设置)
 
 相关设置：
 可设置maxImagesCount：张数限制
 可设置selectedAssets：已选的图片集合

 @param currentViewController 当前控制器
 
 数据返回：通过didFinishPickingPhotosHandleBlock或者didFinishPickingPhotosWithInfosHandleBlock
 */
- (void)openPhotoWithCurrentViewController:(UIViewController *)currentViewController;




@end
