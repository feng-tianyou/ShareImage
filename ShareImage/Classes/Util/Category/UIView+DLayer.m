//
//  UIView+DLayer.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/12.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "UIView+DLayer.h"

@implementation UIView (DLayer)

/**
 添加渐变颜色，在layer层渲染
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 */
- (void)addSubGradientLayerWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size{
    [self addSubGradientLayerWithColors:colors locations:nil horizontal:YES size:size];
}

/**
 添加渐变颜色，在layer层渲染
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 */
- (void)addSubGradientLayerWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations size:(CGSize)size{
    [self addSubGradientLayerWithColors:colors locations:locations horizontal:YES size:size];
}

/**
 添加渐变颜色，在layer层渲染
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 */
- (void)addSubGradientLayerWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations horizontal:(BOOL)horizontal size:(CGSize)size{
    NSAssert(colors, @"colors is nil");
    
    // 处理colors
    NSMutableArray *cgColocrs = [NSMutableArray arrayWithCapacity:colors.count];
    [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [cgColocrs addObject:(__bridge id)obj.CGColor];
    }];
    
    //
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = [cgColocrs copy];
    
    // 处理locations
    gradientLayer.locations = @[@0.0, @1.0];
    if (locations.count > 0) {
        gradientLayer.locations = locations;
    }
    
    // 渐变方向
    if (horizontal) {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
    } else {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
    }
    
    // 设置渲染图层的frame
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (size.width > 0) {
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    gradientLayer.frame = rect;
    [self.layer addSublayer:gradientLayer];
}


/**
 通过颜色获取图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

/**
 通过渐变颜色数组获取图片
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 @param size 图层大小（如果没有设置默认使用frame.size,但是调用前先设置frame）
 @return 图片
 */
- (UIImage *)getImageWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size{
    return [self getImageWithColors:colors locations:nil horizontal:YES size:size];
}

/**
 通过渐变颜色数组获取图片
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 @param size 图层大小（如果没有设置默认使用frame.size,但是调用前先设置frame）
 @return 图片
 */
- (UIImage *)getImageWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations size:(CGSize)size{
    return [self getImageWithColors:colors locations:locations horizontal:YES size:size];
}

/**
 通过渐变颜色数组获取图片
 
 @param colors 颜色数组
 @param locations 颜色分割线位置数组（默认是从0~1.0）eg:@[@0.0, @1.0]
 @param horizontal 横向渐变（默认YES）
 @param size 图层大小（如果没有设置默认使用frame.size,但是调用前先设置frame）
 @return 图片
 */
- (UIImage *)getImageWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations horizontal:(BOOL)horizontal size:(CGSize)size{
    NSAssert(colors, @"colors is nil");
    
    // 处理colors
    NSMutableArray *cgColocrs = [NSMutableArray arrayWithCapacity:colors.count];
    [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [cgColocrs addObject:(__bridge id)obj.CGColor];
    }];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = [cgColocrs copy];
    
    // 处理locations
    gradientLayer.locations = @[@0.0, @1.0];
    if (locations.count > 0) {
        gradientLayer.locations = locations;
    }
    
    // 渐变方向
    if (horizontal) {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
    } else {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
    }
    // 描述矩形
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (size.width > 0) {
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    gradientLayer.frame = rect;
    
    // 生成图片
    UIGraphicsBeginImageContext(rect.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
