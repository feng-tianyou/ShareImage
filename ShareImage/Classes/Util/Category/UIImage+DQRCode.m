//
//  UIImage+DQRCode.m
//  DFrame
//
//  Created by DaiSuke on 2017/2/5.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "UIImage+DQRCode.h"
#import "UIImage+DUIImage.h"

@implementation UIImage (DQRCode)

/**
 通过路径字符串生成二维码
 
 @param url 路径
 @return 二维码图片
 */
+ (UIImage *)imageForQRWithURL:(NSString *)url{
    return [self imageForQRWithURL:url qrImageSize:kQRImageSize qrRed:0 qrGreen:0 qrBlue:0 insertImage:nil insertImageRoundRadius:0.f];
}

/**
 通过路径字符串生成二维码
 
 @param url 路径
 @param qrImageSize 二维码大小
 @return 二维码图片
 */
+ (UIImage *)imageForQRWithURL:(NSString *)url
                   qrImageSize:(CGFloat)qrImageSize{
    return [self imageForQRWithURL:url qrImageSize:qrImageSize qrRed:0 qrGreen:0 qrBlue:0 insertImage:nil insertImageRoundRadius:0.f];
}

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
                        qrBlue: (NSUInteger)qrBlue{
    return [self imageForQRWithURL:url qrImageSize:qrImageSize qrRed:qrRed qrGreen:qrGreen qrBlue:qrBlue insertImage:nil insertImageRoundRadius:0.f];
}

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
                   insertImage:(UIImage *)insertImage{
    return [self imageForQRWithURL:url qrImageSize:qrImageSize qrRed:qrRed qrGreen:qrGreen qrBlue:qrBlue insertImage:insertImage insertImageRoundRadius:0.f];
}


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
        insertImageRoundRadius:(CGFloat)insertImageRoundRadius{
    if (!url || (NSNull *)url == [NSNull null]) { return nil; }
    /** 颜色不可以太接近白色*/
    NSUInteger rgb = (qrRed << 16) + (qrGreen << 8) + qrBlue;
    NSAssert((rgb & 0xffffff00) <= 0xd0d0d000, @"The color of QR code is two close to white color than it will diffculty to scan");
    qrImageSize = [self validateCodeSize: qrImageSize];
    
    CIImage * originImage = [self createQRFromAddress: url];
    UIImage * progressImage = [self excludeFuzzyImageFromCIImage: originImage size: qrImageSize];       //到了这里二维码已经可以进行扫描了
    
    UIImage * effectiveImage = [self imageFillBlackColorAndTransparent: progressImage red: qrRed green: qrGreen blue: qrBlue];  //进行颜色渲染后的二维码
    
    return [self imageInsertedImage: effectiveImage insertImage: insertImage radius: insertImageRoundRadius];
}


#pragma mark - private
/*!
 * @function ProviderReleaseData
 *
 * @abstract
 * 回调函数
 */
void ProviderReleaseData(void * info, const void * data, size_t size) {
    free((void *)data);
}

/**
 *  控制二维码尺寸在合适的范围内
 */
+ (CGFloat)validateCodeSize: (CGFloat)codeSize
{
    codeSize = MAX(160, codeSize);
    codeSize = MIN(CGRectGetWidth([UIScreen mainScreen].bounds) - 80, codeSize);
    return codeSize;
}

/*!
 * @function createQRFromAddress:
 *
 * @abstract
 * 通过链接地址生成原生的二维码图（由于大小不好控制，需要加工）
 */
+ (CIImage *)createQRFromAddress: (NSString *)networkAddress
{
    NSData * stringData = [networkAddress dataUsingEncoding: NSUTF8StringEncoding];
    
    CIFilter * qrFilter = [CIFilter filterWithName: @"CIQRCodeGenerator"];
    [qrFilter setValue: stringData forKey: @"inputMessage"];
    [qrFilter setValue: @"H" forKey: @"inputCorrectionLevel"];
    
    return qrFilter.outputImage;
}

/*!
 * @function createNonInterpolatedImageFromCIImage: size:
 *
 * @abstract
 * 对生成的原始二维码进行加工，返回大小适合的黑白二维码图。因此还需要进行颜色填充
 */
+ (UIImage *)excludeFuzzyImageFromCIImage: (CIImage *)image size: (CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    //创建灰度色调空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext * context = [CIContext contextWithOptions: nil];
    CGImageRef bitmapImage = [context createCGImage: image fromRect: extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage: scaledImage];
}

/*!
 * @function imageFillBlackColorToTransparent: red: green: blue:
 *
 * @abstract
 * 对加工过的黑白二维码进行颜色填充，并转换成透明背景
 */
+ (UIImage *)imageFillBlackColorAndTransparent: (UIImage *)image red: (NSUInteger)red green: (NSUInteger)green blue: (NSUInteger)blue
{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t * rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, (CGRect){(CGPointZero), (image.size)}, image.CGImage);
    
    //遍历像素
    int pixelNumber = imageHeight * imageWidth;
    [self fillWhiteToTransparentOnPixel: rgbImageBuf pixelNum: pixelNumber red: red green: green blue: blue];
    
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    
    UIImage * resultImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    return resultImage;
}

/*!
 * @function fillWhiteToTransparentOnPixel: pixelNum: red: green: blue:
 *
 * @abstract
 * 遍历所有像素点，将白色区域填充为透明色
 */
+ (void)fillWhiteToTransparentOnPixel: (uint32_t *)rgbImageBuf pixelNum: (int)pixelNum red: (NSUInteger)red green: (NSUInteger)green blue: (NSUInteger)blue
{
    uint32_t * pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xffffff00) < 0x99999900) {
            uint8_t * ptr = (uint8_t *)pCurPtr;
            ptr[3] = red;
            ptr[2] = green;
            ptr[1] = blue;
        }
        else {
            //将白色变成透明色
            uint8_t * ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
}

/*!
 * @function imageInsertedImage: insertImage:
 *
 * @abstract
 * 在渲染后的二维码图上进行图片插入，如插入图为空，直接返回二维码图
 */
+ (UIImage *)imageInsertedImage: (UIImage *)originImage insertImage: (UIImage *)insertImage radius: (CGFloat)radius
{
    if (!insertImage) { return originImage; }
    insertImage = [UIImage imageOfRoundRectWithImage: insertImage size: insertImage.size radius: radius];
    UIImage * whiteBG = [UIImage imageNamed: @"whiteBG"];
    whiteBG = [UIImage imageOfRoundRectWithImage: whiteBG size: whiteBG.size radius: radius];
    
    //白色边缘宽度
    const CGFloat whiteSize = 5.f;
    CGSize brinkSize = CGSizeMake(originImage.size.width / 4, originImage.size.height / 4);
    CGFloat brinkX = (originImage.size.width - brinkSize.width) * 0.5;
    CGFloat brinkY = (originImage.size.height - brinkSize.height) * 0.5;
    
    CGSize imageSize = CGSizeMake(brinkSize.width - 2 * whiteSize, brinkSize.height - 2 * whiteSize);
    CGFloat imageX = brinkX + whiteSize;
    CGFloat imageY = brinkY + whiteSize;
    
    UIGraphicsBeginImageContext(originImage.size);
    [originImage drawInRect: (CGRect){ 0, 0, (originImage.size) }];
    [whiteBG drawInRect: (CGRect){ brinkX, brinkY, (brinkSize) }];
    [insertImage drawInRect: (CGRect){ imageX, imageY, (imageSize) }];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

@end
