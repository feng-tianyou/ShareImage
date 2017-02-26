//
//  UIColor+DColor.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DColor)
/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “#987567”
 *
 *  @return UIColor*
 */
+ (UIColor *)setHexColor:(NSString *)hexColor;

/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “#987567”
 *  @param alpha    0 ~ 1
 *
 *  @return UIColor
 */
+ (UIColor *)setHexColor:(NSString *)hexColor colorAlpha:(CGFloat)alpha;


/**
 随机颜色

 @return 颜色
 */
+ (UIColor *)lightRandom;

@end
