//
//  UIImage+DUIImage.h
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DUIImage)

/**
 *  剪切圆形图片
 *
 *  @param name        图片名称
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 圆形图片
 */
+ (UIImage *)circleImageWithName:(NSString *)name borderWitg:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  剪切圆形图片
 *
 *  @param name        图片名称
 *
 *  @return 圆形图片
 */
+ (UIImage *)circleImageWithName:(NSString *)name;

/**
 拉伸图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)imageName;
+ (UIImage *)resizedImageWithName:(NSString *)imageName left:(CGFloat)left top:(CGFloat)top;
/**
 *  图片拉伸
 *
 *  @param widthFraction  总宽几分之几处
 *  @param heightFraction 总高几分之几处
 *
 *  @return 被拉伸的图片
 */
- (UIImage *)stretchableImageWithCapWidthFraction:(CGFloat)widthFraction
                                CapHeightFraction:(CGFloat)heightFraction;

- (void)imageByScalingToMaxSize;


/**
 图片压缩 scale：0 ~1

 @param scale 0 - 1
 @return data
 */
- (NSData * )imageCompression:(CGFloat)scale;

/**
 *  获取image
 *
 *  @param name 图片名称
 */
+ (UIImage *)getImageWithName:(NSString*)name;

/**
 *  获取emojiimage
 *
 *  @param name 图片名称
 */
+ (UIImage *)getEmojiImageWithName:(NSString*)name;

/**
 *  获取image
 *
 *  @param name 图片名称
 *  @param extension 后缀名
 */
+ (UIImage *)getImageWithName:(NSString*)name extension:(NSString *)extension;

+(UIImage *)fixOrientation:(UIImage *)srcImg;

//等比例缩放
+ (UIImage*)originImage:(UIImage *)image newSize:(CGSize)newSize;

//等比例缩放
+ (UIImage*)originImage:(UIImage *)image newSize:(CGSize)newSize origin:(CGPoint)origin;

//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

//对图片尺寸进行压缩--按比例
+ (UIImage*)imageWithImage:(UIImage*)image maxWidth:(CGFloat)maxWidth;

/**
 *  局部拉伸图片
 *
 *  @param edgeInsets 可拉伸区域
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)resizableImgByEdgeInsets:(UIEdgeInsets)edgeInsets;


/**
 给传入的图片设置圆角后返回圆角图片
 
 @param image 图片
 @param size 大小
 @param radius 圆角
 @return 图片
 */
+ (UIImage *)imageOfRoundRectWithImage:(UIImage *)image
                                  size:(CGSize)size
                                radius:(CGFloat)radius;


- (UIImage *)imageByRoundCornerRadiusWithimageViewSize:(CGSize)imageViewSize;
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin ;
@end
