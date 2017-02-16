//
//  UIImage+DUIImage.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "UIImage+DUIImage.h"
#import "DFileManager.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@implementation UIImage (DUIImage)

+ (UIImage *)circleImageWithName:(NSString *)name{
    
    return [UIImage circleImageWithName:name borderWitg:0 borderColor:0];
}

+ (UIImage *)circleImageWithName:(NSString *)name borderWitg:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    // 加载图片
    UIImage *oldImage = [UIImage getImageWithName:name];
    
    // 开始上下文
    CGFloat imageW = oldImage.size.width;
    CGFloat imageH = oldImage.size.height;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContext(imageSize);
    
    // 取得当前的上下文，得到的是上面刚创建的图片上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 画圆
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    // 小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextClip(ctx);
    
    // 画圆
    [oldImage drawAsPatternInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)
     ];
    
    // 取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

/**
 拉伸图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)imageName{
    return [self resizedImageWithName:imageName left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)imageName left:(CGFloat)left top:(CGFloat)top{
    
    UIImage *image = [UIImage getImageWithName:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
/**
 *  图片拉伸
 *
 *  @param widthFraction  总宽几分之几处
 *  @param heightFraction 总高几分之几处
 *
 *  @return 被拉伸的图片
 */
- (UIImage *)stretchableImageWithCapWidthFraction:(CGFloat)widthFraction
                                CapHeightFraction:(CGFloat)heightFraction
{
    return [self stretchableImageWithLeftCapWidth:self.size.width * widthFraction
                                     topCapHeight:self.size.height * heightFraction];
}


- (void)imageByScalingToMaxSize
{
    if (self.size.width < ORIGINAL_MAX_WIDTH) return;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (self.size.width > self.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = self.size.width * (ORIGINAL_MAX_WIDTH / self.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = self.size.height * (ORIGINAL_MAX_WIDTH / self.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    [self imageByScalingAndCroppingForTargetSize:targetSize];
}



- (UIImage *)imageByScalingAndCroppingForTargetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

//等比例缩放
+ (UIImage*)originImage:(UIImage *)image
{
    int h = image.size.height;
    int w = image.size.width;
    CGSize imageSize = image.size;
    if(w > SCREEN_WIDTH){
        float b = (float)SCREEN_WIDTH/w;
        imageSize = CGSizeMake(b*w, b*h);
    }
    
    UIGraphicsBeginImageContext(imageSize);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

//等比例缩放
+ (UIImage*)originImage:(UIImage *)image newSize:(CGSize)newSize
{
    CGSize imageSize = image.size;
    CGFloat rate = imageSize.width/imageSize.height;
    if(imageSize.width < newSize.width){
        imageSize.width = newSize.width;
        imageSize.height = newSize.width/rate;
    }
    if(imageSize.height < newSize.height){
        imageSize.height = newSize.height;
        imageSize.width = newSize.height * rate;
    }
    
    UIGraphicsBeginImageContext(newSize);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake((imageSize.width - newSize.width)/2.0, (imageSize.height - newSize.height)/2.0, newSize.width, newSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

//等比例缩放
+ (UIImage*)originImage:(UIImage *)image newSize:(CGSize)newSize origin:(CGPoint)origin
{
    CGSize imageSize = image.size;
    CGFloat rate = imageSize.width/imageSize.height;
    if(imageSize.width < newSize.width){
        imageSize.width = newSize.width;
        imageSize.height = newSize.width/rate;
    }
    if(imageSize.height < newSize.height){
        imageSize.height = newSize.height;
        imageSize.width = newSize.height * rate;
    }
    
    UIGraphicsBeginImageContext(newSize);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(origin.x, origin.y, newSize.width, newSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}





+(UIImage *)fixOrientation:(UIImage *)srcImg {
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//对图片尺寸进行压缩--按比例
+ (UIImage*)imageWithImage:(UIImage*)image maxWidth:(CGFloat)maxWidth
{
    if(image.size.width <= maxWidth && image.size.height <= maxWidth){
        return image;
    }
    
    CGFloat rate = image.size.width/image.size.height;
    CGSize newSize;
    if(rate > 1.0){
        newSize = CGSizeMake(maxWidth, maxWidth/rate);
    }
    else{
        newSize = CGSizeMake(maxWidth * rate, maxWidth);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//图片压缩 scale：0 ~1
- (NSData * )imageCompression:(CGFloat)scale
{
    if (UIImagePNGRepresentation(self) == nil) {
        return  UIImageJPEGRepresentation(self, scale);
    } else {
        return UIImagePNGRepresentation(self);
    }
}

/**
 *  获取image
 *
 *  @param name 图片名称
 */
+ (UIImage *)getImageWithName:(NSString*)name{
    return [DFileManager getLocalImageByName:name];
}

/**
 *  获取emojiimage
 *
 *  @param name 图片名称
 */
+ (UIImage *)getEmojiImageWithName:(NSString*)name{
    return [DFileManager getLocalEmmojiImageByName:name];
}

/**
 *  获取image
 *
 *  @param name 图片名称
 *  @param extension 后缀名
 */
+ (UIImage *)getImageWithName:(NSString*)name extension:(NSString *)extension{
    return [DFileManager getLocalImageByName:name extension:extension];
}

- (UIImage *)resizableImgByEdgeInsets:(UIEdgeInsets)edgeInsets
{
    UIImage *imgResize = self;
    if([imgResize respondsToSelector:@selector(resizableImageWithCapInsets:)])
    {
        imgResize = [imgResize resizableImageWithCapInsets:edgeInsets];
    }
    else
    {
        imgResize = [imgResize resizableImageWithCapInsets:edgeInsets
                                              resizingMode:UIImageResizingModeStretch];
    }
    
    return imgResize;
}


/**
 给传入的图片设置圆角后返回圆角图片
 
 @param image 图片
 @param size 大小
 @param radius 圆角
 @return 图片
 */
+ (UIImage *)imageOfRoundRectWithImage:(UIImage *)image
                                  size:(CGSize)size
                                radius:(CGFloat)radius{
    if (!image || (NSNull *)image == [NSNull null]) { return nil; }
    
    const CGFloat width = size.width;
    const CGFloat height = size.height;
    
    radius = MAX(5.f, radius);
    radius = MIN(10.f, radius);
    
    UIImage * img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    //绘制圆角
    CGContextBeginPath(context);
    addRoundRectToPath(context, rect, radius, img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage: imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}


#pragma mark - private
/**
 *  给上下文添加圆角蒙版
 */
void addRoundRectToPath(CGContextRef context, CGRect rect, float radius, CGImageRef image)
{
    float width, height;
    if (radius == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    width = CGRectGetWidth(rect);
    height = CGRectGetHeight(rect);
    
    //裁剪路径
    CGContextMoveToPoint(context, width, height / 2);
    CGContextAddArcToPoint(context, width, height, width / 2, height, radius);
    CGContextAddArcToPoint(context, 0, height, 0, height / 2, radius);
    CGContextAddArcToPoint(context, 0, 0, width / 2, 0, radius);
    CGContextAddArcToPoint(context, width, 0, width, height / 2, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRestoreGState(context);
}

@end
