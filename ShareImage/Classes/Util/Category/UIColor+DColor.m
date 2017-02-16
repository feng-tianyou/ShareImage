//
//  UIColor+DColor.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "UIColor+DColor.h"

@implementation UIColor (DColor)

/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “#987567”
 *
 *  @return UIColor*
 */
+ (UIColor *)setHexColor:(NSString *)hexColor{
    return [UIColor setHexColor:hexColor colorAlpha:1.0];
}

/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “#987567”
 *  @param alpha    0 ~ 1
 *
 *  @return UIColor
 */
+ (UIColor *)setHexColor:(NSString *)hexColor colorAlpha:(CGFloat)alpha{
    NSAssert(hexColor, @"获取到颜色UICOLOR -->hexColor not be nil");
    
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }else if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }else if ([cString length] != 6){
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

@end
