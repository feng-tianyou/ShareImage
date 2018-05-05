//
//  DPhotoHandleTool.m
//  ShareImage
//
//  Created by FTY on 2017/4/13.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotoHandleTool.h"
#import <SDWebImage/SDWebImageManager.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@implementation DPhotoHandleTool

+ (instancetype)manager{
    return [[self alloc] init];
}

- (void)downloadImageWithURL:(NSURL *)url{
    if (!url) return;
    @weakify(self)
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:url
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             if (expectedSize > 0) {
                                 float progress = receivedSize / (float)expectedSize;
                                 [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
                                 [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                                 [SVProgressHUD showProgress:progress status:kLocalizedLanguage(@"hudDownloading")];
                             }
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (finished) {
                                @strongify(self)
                                [self imageWriteToSavedPhotosAlbumWithImage:image];
                            } else {
                                DLog(@"SDWebImage failed to download image: %@", error);
                            }
                            
                        }];
}

- (void)imageWriteToSavedPhotosAlbumWithImage:(UIImage *)image{
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}


#pragma mark - private
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    // 写入相册,写入失败不做处理
    [SVProgressHUD dismiss];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    if (error) {
        [SVProgressHUD showSuccessWithStatus:kLocalizedLanguage(@"hudSaveSuccess")];
    } else {
        [SVProgressHUD showSuccessWithStatus:kLocalizedLanguage(@"hudSaveFaile")];
    }
}

/// 检查相机授权
+ (BOOL)checkNeedTipForTakeCamera{
    AVAuthorizationStatus state = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(state == AVAuthorizationStatusRestricted || state == AVAuthorizationStatusDenied)
    {
        DAlertView *alertView=[[DAlertView alloc] initWithTitle:nil andMessage:kLocalizedLanguage(@"alertVisitCamera")];
        [alertView addButtonWithTitle:kLocalizedLanguage(@"alertSure") type:CustomAlertViewButtonTypeCancel handler:nil];
        [alertView show];
        return YES;
    }
    return NO;
}
/// 检查相册授权
+ (BOOL)checkNeedTipForTakePhoto{
    BOOL flag = NO;
    if (IOS9) {
        PHAuthorizationStatus state = [PHPhotoLibrary authorizationStatus];
        if(state == PHAuthorizationStatusRestricted || state == PHAuthorizationStatusDenied) {
            flag = YES;
        }
    } else {
        ALAuthorizationStatus state = [ALAssetsLibrary authorizationStatus];
        if(state == AVAuthorizationStatusRestricted || state == AVAuthorizationStatusDenied) {
            flag = YES;
        }
    }
    if (flag) {
        DAlertView *alertView=[[DAlertView alloc] initWithTitle:nil andMessage:kLocalizedLanguage(@"alertVisitPhoto")];
        [alertView addButtonWithTitle:kLocalizedLanguage(@"alertSure") type:CustomAlertViewButtonTypeCancel handler:nil];
        [alertView show];
        return YES;
    }
    return NO;
}


@end
