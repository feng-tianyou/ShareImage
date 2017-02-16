//
//  UIImage+DEffect.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/12.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "UIImage+DEffect.h"

@implementation UIImage (DEffect)

/**
 *  对图片进行滤镜出离
 *
 *  @param originalImage 原始图
 *  @param filterName    滤镜名
 */
+ (UIImage *)filterWithOriginalImage:(UIImage *)originalImage filterName:(NSString *)filterName{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:originalImage];
    CIFilter *filter;
    if (filterName.length != 0) {
        filter = [CIFilter filterWithName:filterName];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    } else {
        return nil;
    }
}


/**
 *  对图片进行模糊出离
 *
 *  @param originalImage 原始图片
 *  @param blurName      模糊类型
 *  @param radius        模糊度
 *
 *  @return 处理过的图片
 */
+ (UIImage *)blurWithOriginalImage:(UIImage *)originalImage
                          blurName:(NSString *)blurName
                            radius:(NSInteger)radius{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:originalImage];
    CIFilter *filter;
    if (blurName.length != 0) {
        filter = [CIFilter filterWithName:blurName];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        if (![blurName isEqualToString:@"CIMedianFilter"]) {
            [filter setValue:@(radius) forKey:@"inputRadius"];
        }
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    } else {
        return nil;
    }
}


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
                                   contrast:(CGFloat)contrast{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:orignialImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"];
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
    
}


- (UIImage *)imageWithAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextSetAlpha(context, alpha);
    CGContextDrawImage(context, area, self.CGImage);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

@end
