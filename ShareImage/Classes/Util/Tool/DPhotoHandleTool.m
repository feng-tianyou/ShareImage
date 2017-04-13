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
                                 [SVProgressHUD showProgress:progress status:@"Downloading..."];
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
    [SVProgressHUD setMaximumDismissTimeInterval:1.0];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    if (error) {
        [SVProgressHUD showSuccessWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}


@end
