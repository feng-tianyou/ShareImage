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




@end
