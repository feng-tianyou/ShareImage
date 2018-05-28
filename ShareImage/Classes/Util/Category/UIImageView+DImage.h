//
//  UIImageView+DImage.h
//  ShareImage
//
//  Created by FTY on 2018/5/28.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DImage)

- (void)setImageWithURL:(NSString *)url cornerRadius:(CGFloat)cornerRadius callBack:(UIImageBlock)callBack;

@end
