//
//  DPhotoManager.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/7.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotoManager.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <TZImagePickerController/TZImageManager.h>
#import <TZImagePickerController/TZPhotoPreviewController.h>

@interface DPhotoManager()<TZImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, strong) TZImagePickerController *imagecontroller;
@property (nonatomic, strong) UIViewController *currentViewController;



/**
 MWPhoto集合
 */
@property (nonatomic, strong) NSArray<MWPhoto *> *mwPhotos;

@end

@implementation DPhotoManager
#pragma mark - getter & setter
- (NSArray *)selectedAssets{
    if (!_selectedAssets) {
        _selectedAssets = [NSArray array];
    }
    return _selectedAssets;
}

- (TZImagePickerController *)imagecontroller{
    if (!_imagecontroller) {
        _imagecontroller = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        _imagecontroller.allowPickingVideo = NO;
    }
    return _imagecontroller;
}

- (NSArray<MWPhoto *> *)mwPhotos{
    if (!_mwPhotos) {
        _mwPhotos = [NSArray array];
    }
    return _mwPhotos;
}


#pragma mark - Public
/**
 初始化
 
 @return 对象
 */
+ (instancetype)manager{
    return [[self alloc] init];
}

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

#pragma mark - Public -> MWPhotoBrowser
/**
 浏览图片(自动关闭页面)(MWPhotoBrowser)
 
 @param photoUrls 图片路径集合
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotoUrls:(NSArray *)photoUrls
                     currentIndex:(NSInteger)currentIndex
            currentViewController:(UIViewController *)currentViewController{
    if (photoUrls.count == 0) return;
    [self photoPreviewWithPhotoUrls:photoUrls photos:nil currentIndex:currentIndex currentViewController:currentViewController];
}


/**
 浏览图片(自动关闭页面)(MWPhotoBrowser)
 
 @param photos 图片集合
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotos:(NSArray *)photos
                  currentIndex:(NSInteger)currentIndex
         currentViewController:(UIViewController *)currentViewController{
    if (photos.count == 0) return;
    [self photoPreviewWithPhotoUrls:nil photos:photos currentIndex:currentIndex currentViewController:currentViewController];
}


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
            currentViewController:(UIViewController *)currentViewController{
    self.photoUrls = photoUrls;
    self.photos = photos;
    self.currentIndex = currentIndex;
    self.currentViewController = currentViewController;
    
    NSMutableArray *tmpPhotos = [NSMutableArray arrayWithCapacity:0];
    if (photos.count > 0) {
        [photos enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * _Nonnull stop) {
            [tmpPhotos addObject:[MWPhoto photoWithImage:image]];
        }];
    } else if (photoUrls.count > 0){
        [photoUrls enumerateObjectsUsingBlock:^(NSString *imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
            [tmpPhotos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:imageUrl]]];
        }];
    }
    
    self.mwPhotos = [tmpPhotos copy];
    
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = YES;
    browser.zoomPhotosToFill = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;
#endif
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:currentIndex];
    
    // Modal
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [currentViewController presentViewController:nc animated:YES completion:nil];
}

#pragma mark - Public -> 打开相机
/**
 打开相机
 
 @param currentViewController 当前控制器
 
 数据返回：通过didFinishPickingPhotosHandleBlock或者didFinishPickingPhotosWithInfosHandleBlock
 */
- (void)openCameraWithCurrentViewController:(UIViewController *)currentViewController{
    self.currentViewController = currentViewController;
    [self openCamera];
}

#pragma mark - Public -> 打开相册
/**
 打开相册(如要设置相关参数，请在调用前设置)
 
 相关设置：
 可设置maxImagesCount：张数限制
 可设置selectedAssets：已选的图片集合
 
 @param currentViewController 当前控制器
 
 数据返回：通过didFinishPickingPhotosHandleBlock或者didFinishPickingPhotosWithInfosHandleBlock
 */
- (void)openPhotoWithCurrentViewController:(UIViewController *)currentViewController{
    self.currentViewController = currentViewController;
    [self openPhoto];
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:NO completion:nil];

    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.image"])
    {
        [SVProgressHUD showWithStatus:@"正在处理..."];
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

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.mwPhotos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.mwPhotos.count)
        return [self.mwPhotos objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self.currentViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - dealloc
- (void)dealloc{
    self.imagecontroller = nil;
    self.currentViewController = nil;
}

@end
