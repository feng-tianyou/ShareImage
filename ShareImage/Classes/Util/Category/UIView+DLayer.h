//
//  UIView+DLayer.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/12.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DLayer)

/**
 添加渐变颜色，在layer层渲染
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 @param size 图层大小（如果没有设置默认使用frame.size,但是调用前先设置frame）
 */
- (void)addSubGradientLayerWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size;

/**
 添加渐变颜色，在layer层渲染
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 @param size 图层大小（如果没有设置默认使用frame.size,但是调用前先设置frame）
 */
- (void)addSubGradientLayerWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations size:(CGSize)size;

/**
 添加渐变颜色，在layer层渲染
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 @param size 图层大小（如果没有设置默认使用frame.size,但是调用前先设置frame）
 */
- (void)addSubGradientLayerWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations horizontal:(BOOL)horizontal size:(CGSize)size;



/**
 通过颜色获取图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 通过渐变颜色数组获取图片(调用前先设置frame)
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 @param size 图层大小（如果没有设置默认使用frame.size,但是调用前先设置frame）
 @return 图片
 */
- (UIImage *)getImageWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size;

/**
 通过渐变颜色数组获取图片(调用前先设置frame)
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 @param size 图层大小（如果没有设置默认使用frame.size,但是调用前先设置frame）
 @return 图片
 */
- (UIImage *)getImageWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations size:(CGSize)size;

/**
 通过渐变颜色数组获取图片(调用前先设置frame)
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 @param size 图层大小（如果没有设置默认使用frame.size,但是调用前先设置frame）
 @return 图片
 */
- (UIImage *)getImageWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations horizontal:(BOOL)horizontal size:(CGSize)size;


@end
