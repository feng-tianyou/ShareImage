//
//  SDPhotoBrowser.h
//  photobrowser
//
//  Created by aier on 15-2-3.
//  Copyright (c) 2015年 aier. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SDButton, SDPhotoBrowser, DPhotosModel;

@protocol SDPhotoBrowserDelegate <NSObject>

@required

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;



@optional

- (void)photoBrowser:(SDPhotoBrowser *)browser didSelectButtonIndex:(NSInteger)buttonIndex  imageIndex:(NSInteger)imageIndex;

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

- (DPhotosModel *)photoBrowser:(SDPhotoBrowser *)browser photoModelForIndex:(NSInteger)index;


@end


@interface SDPhotoBrowser : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;

@property (nonatomic, weak) id<SDPhotoBrowserDelegate> delegate;

@property (nonatomic, assign, getter=isHideBottomFunctionView) BOOL hideBottomFunctionView; // 底部功能视图



- (void)show;
- (void)hide;

@end
