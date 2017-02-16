//
//  UIImage+DEffect.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/12.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DEffect)

/**
 *  对图片进行滤镜出离
 *
 *  @param originalImage 原始图
 *  @param filterName    滤镜名
 *  @return 处理过的图片
 
 CIPhotoEffectInstant   --> 怀旧
 CIPhotoEffectMono      --> 单色
 CIPhotoEffectNoir      --> 黑白
 CIPhotoEffectFade      --> 褪色
 CIPhotoEffectTonal     --> 色调
 CIPhotoEffectProcess   --> 冲印
 CIPhotoEffectTransfer  --> 岁月
 CIPhotoEffectChrome    --> 洛黄
 
 */

+ (UIImage *)filterWithOriginalImage:(UIImage *)originalImage filterName:(NSString *)filterName;

/**
 *  对图片进行模糊出离
 *
 *  @param originalImage 原始图片
 *  @param blurName      模糊类型
 *  @param radius        模糊度
 *
 *  @return 处理过的图片
 
 CIGaussianBlur     -->高斯模糊
 CIBoxBlur          -->均值模糊（9.0或以上）
 CIDiscBlur         -->环形卷积模糊（9.0或以上）
 CIMedianFilter     -->中值模糊，用于消除图像噪点，无需设置radius（9.0或以上）
 CIMotionBlur       -->运动模糊，用于模拟相机移动拍摄时的扫描效果（9.0或以上）
 
 
 */
+ (UIImage *)blurWithOriginalImage:(UIImage *)originalImage
                          blurName:(NSString *)blurName
                            radius:(NSInteger)radius;

/**
 *  调整图片饱和度，亮度，对比度
 *
 *  @param orignialImage 原图
 *  @param saturation    饱和度
 *  @param brightness    亮度 -1.0~1.0
 *  @param contrast      对比度
 *
 *  @return 处理后的图片
 */
+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)orignialImage
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast;
/**
 *  设置一张图片的透明度
 *
 *  @param alpha 要用于渲染透明度
 *
 *  @return 设置了透明度之后的图片
 */
- (UIImage *)imageWithAlpha:(CGFloat)alpha;


@end
