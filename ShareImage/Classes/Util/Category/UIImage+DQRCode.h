//
//  UIImage+DQRCode.h
//  DFrame
//
//  Created by DaiSuke on 2017/2/5.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kURL                @"http://daisuke.cn"
#define kQRImageSize        100

@interface UIImage (DQRCode)

/**
 通过路径字符串生成二维码

 @param url 路径
 @return 二维码图片
 */
+ (UIImage *)imageForQRWithURL:(NSString *)url;

/**
 通过路径字符串生成二维码
 
 @param url 路径
 @param qrImageSize 二维码大小
 @return 二维码图片
 */
+ (UIImage *)imageForQRWithURL:(NSString *)url
                   qrImageSize:(CGFloat)qrImageSize;

/**
 通过路径字符串生成二维码
 
 @param url 路径
 @param qrImageSize 二维码大小
 @param qrRed 二维码颜色RGB
 @param qrGreen 二维码颜色RGB
 @param qrBlue 二维码颜色RGB
 @return 二维码图片
 */
+ (UIImage *)imageForQRWithURL:(NSString *)url
                   qrImageSize:(CGFloat)qrImageSize
                           qrRed: (NSUInteger)qrRed
                         qrGreen: (NSUInteger)qrGreen
                          qrBlue: (NSUInteger)qrBlue;

/**
 通过路径字符串生成二维码
 
 @param url 路径
 @param qrImageSize 二维码大小
 @param qrRed 二维码颜色RGB
 @param qrGreen 二维码颜色RGB
 @param qrBlue 二维码颜色RGB
 @param insertImage 插入头像图片
 @return 二维码图片
 */
+ (UIImage *)imageForQRWithURL:(NSString *)url
                   qrImageSize:(CGFloat)qrImageSize
                         qrRed: (NSUInteger)qrRed
                       qrGreen: (NSUInteger)qrGreen
                        qrBlue: (NSUInteger)qrBlue
                   insertImage:(UIImage *)insertImage;


/**
 通过路径字符串生成二维码
 
 @param url 路径
 @param qrImageSize 二维码大小
 @param qrRed 二维码颜色RGB
 @param qrGreen 二维码颜色RGB
 @param qrBlue 二维码颜色RGB
 @param insertImage 插入头像图片
 @param insertImageRoundRadius 插入头像图片圆角
 @return 二维码图片
 */
+ (UIImage *)imageForQRWithURL:(NSString *)url
                   qrImageSize:(CGFloat)qrImageSize
                         qrRed: (NSUInteger)qrRed
                       qrGreen: (NSUInteger)qrGreen
                        qrBlue: (NSUInteger)qrBlue
                   insertImage:(UIImage *)insertImage
        insertImageRoundRadius:(CGFloat)insertImageRoundRadius;

@end
