//
//  DTZPhotosManager.m
//  ShareImage
//
//  Created by FTY on 2017/4/13.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DTZPhotosManager.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <TZImagePickerController/TZImageManager.h>
#import <TZImagePickerController/TZPhotoPreviewController.h>
#import <SDWebImage/SDWebImageManager.h>

@interface DTZPhotosManager ()<TZImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) TZImagePickerController *imagecontroller;
@end

@implementation DTZPhotosManager

#pragma mark - Public -> TZImagePickerController
/**
 图片选择器
 ps:页面自动消失，有两个选择：一个是通过相机，一个是通过相册
 (TZImagePickerController)
 
 ps: maxImagesCount:默认限制9张
 
 数据返回：通过didFinishPickingPhotosHandleBlock或者didFinishPickingPhotosWithInfosHandleBlock
 
 */
- (void)photoPickerWithCurrentViewController:(UIViewController *)currentViewController{
    self.maxImagesCount = 9;// 默认限制9张图片
    [self photoPickerWithMaxImagesCount:self.maxImagesCount currentViewController:currentViewController];
}

/**
 图片选择器
 ps:页面自动消失，有两个选择：一个是通过相机，一个是通过相册
 (TZImagePickerController)
 
 PS：想单独使用的货请看
 相机：openCameraWithCurrentViewController:
 相册：openPhotoWithCurrentViewController:
 
 @param maxImagesCount 限制张数
 @param currentViewController 当前控制器
 
 数据返回：通过didFinishPickingPhotosHandleBlock或者didFinishPickingPhotosWithInfosHandleBlock
 
 */
- (void)photoPickerWithMaxImagesCount:(NSInteger)maxImagesCount currentViewController:(UIViewController *)currentViewController{
    [self photoPickerWithMaxImagesCount:maxImagesCount selectedAssets:nil currentViewController:currentViewController];
    
}

#pragma mark - TZImagePickerController
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
                currentViewController:(UIViewController *)currentViewController{
    self.currentViewController = currentViewController;
    self.maxImagesCount = maxImagesCount;
    self.selectedAssets = selectedAssets;
    
    @weakify(self)
    UIAlertController *controller = [[UIAlertController alloc] init];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self openCamera];
    }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self openPhoto];
    }];
    [controller addAction:camera];
    [controller addAction:album];
    [controller addAction:cancel];
    
    [currentViewController presentViewController:controller animated:YES completion:nil];
}


#pragma mark - Private
- (void)openCamera{
    if(IOS7)
    {
        AVAuthorizationStatus state = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(state == AVAuthorizationStatusRestricted || state == AVAuthorizationStatusDenied)
        {
            DAlertView *alertView=[[DAlertView alloc] initWithTitle:nil andMessage:@"请在iPhone的“设置-隐私-相机”选项中允许访问您的手机相机"];
            [alertView addButtonWithTitle:@"确定" type:CustomAlertViewButtonTypeCancel handler:nil];
            [alertView show];
            return;
        }
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController * imgVC = [[UIImagePickerController alloc]init];
        imgVC.delegate = self;
        imgVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        imgVC.showsCameraControls = YES;
        imgVC.allowsEditing = NO;
        [self.currentViewController presentViewController:imgVC animated:YES completion:nil];
    }
}

- (void)openPhoto{
    
    if(IOS6)
    {
        ALAuthorizationStatus state = [ALAssetsLibrary authorizationStatus];
        if(state == ALAuthorizationStatusRestricted || state == ALAuthorizationStatusDenied)
        {
            DAlertView *alertView=[[DAlertView alloc] initWithTitle:nil andMessage:@"请在iPhone的“设置-隐私-相册”选项中允许访问您的手机相册"];
            [alertView addButtonWithTitle:@"确定" type:CustomAlertViewButtonTypeCancel handler:nil];
            [alertView show];
            return;
        }
    }
    
    self.maxImagesCount = self.maxImagesCount > 0 ? self.maxImagesCount : 9;
    self.imagecontroller.maxImagesCount = self.maxImagesCount;
    
    // 设置已选的
    if (self.selectedAssets.count > 0) {
        self.imagecontroller.selectedAssets = [NSMutableArray arrayWithArray:self.selectedAssets];
    }
    
    [self.currentViewController presentViewController:self.imagecontroller animated:YES completion:nil];
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.image"])
    {
        [SVProgressHUD showWithStatus:@"正在处理..."];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        UIImage *originalImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImageWriteToSavedPhotosAlbum(originalImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    // 写入相册,写入失败不做处理
    
    if (error) {
        DLog(@"写入失败");
        [SVProgressHUD dismiss];
    } else {
        
        @weakify(self);
        __block TZAlbumModel *albumModel = nil;
        [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
            albumModel = model;
            [[TZImageManager manager] getAssetsFromFetchResult:albumModel.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                @strongify(self)
                TZAssetModel *model = [models lastObject];
                if (self.didFinishPickingPhotosHandleBlock) {
                    self.didFinishPickingPhotosHandleBlock(@[image], @[model.asset], NO);
                }
                
                if (self.didFinishPickingPhotosWithInfosHandleBlock) {
                    self.didFinishPickingPhotosWithInfosHandleBlock(@[image], @[model.asset], NO, nil);
                }
                [SVProgressHUD dismiss];
            }];
        }];
        
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Public -> TZPhotoPreviewController
/**
 浏览图片(自动关闭页面)(TZPhotoPreviewController)
 
 @param photoArray 图片集合（PHAsset）
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotoArray:(NSArray *)photoArray
                      currentIndex:(NSInteger)currentIndex
             currentViewController:(UIViewController *)currentViewController{
    if (photoArray.count == 0) return;
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:photoArray.count];
    [photoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[PHAsset class]]) {
            TZAssetModel *model = [[TZAssetModel alloc] init];
            model.asset = obj;
            [tmpArr addObject:model];
        }
    }];
    
    if (tmpArr.count == 0) return;
    
    self.currentViewController = currentViewController;
    TZPhotoPreviewController *preview = [[TZPhotoPreviewController alloc] init];
    preview.photos = tmpArr;
    preview.currentIndex = currentIndex;
    [currentViewController presentViewController:preview animated:YES completion:nil];
    
    // 回调
    @weakify(self)
    [preview setDoneButtonClickBlock:^(BOOL isSelectOriginalPhoto) {
        
        @strongify(self)
        [self.currentViewController dismissViewControllerAnimated:YES completion:nil];
        if (self.okButtonClickBlock) {
            self.okButtonClickBlock(isSelectOriginalPhoto);
        }
    }];
    
    [preview setBackButtonClickBlock:^(BOOL isSelectOriginalPhoto) {
        @strongify(self)
        [self.currentViewController dismissViewControllerAnimated:YES completion:nil];
        if (self.backButtonClickBlock) {
            self.backButtonClickBlock(isSelectOriginalPhoto);
        }
    }];
}


#pragma mark - TZImagePickerControllerDelegate
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的handle
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    if (self.didFinishPickingPhotosHandleBlock) {
        self.didFinishPickingPhotosHandleBlock(photos, assets, isSelectOriginalPhoto);
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    if (self.didFinishPickingPhotosWithInfosHandleBlock) {
        self.didFinishPickingPhotosWithInfosHandleBlock(photos, assets, isSelectOriginalPhoto, infos);
    }
}

// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{
    
}


#pragma mark - setter & getter

- (TZImagePickerController *)imagecontroller{
    if (!_imagecontroller) {
        _imagecontroller = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        _imagecontroller.allowPickingVideo = NO;
    }
    return _imagecontroller;
}


#pragma mark - getter & setter
- (NSArray *)selectedAssets{
    if (!_selectedAssets) {
        _selectedAssets = [NSArray array];
    }
    return _selectedAssets;
}

@end
