//
//  DPhotoHandleTool.h
//  ShareImage
//
//  Created by FTY on 2017/4/13.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPhotoHandleTool : NSObject

+ (instancetype)manager;

- (void)downloadImageWithURL:(NSURL *)url;

- (void)imageWriteToSavedPhotosAlbumWithImage:(UIImage *)image;

/// 检查相机授权
+ (BOOL)checkNeedTipForTakeCamera;
/// 检查相册授权
+ (BOOL)checkNeedTipForTakePhoto;


@end
