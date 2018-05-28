//
//  UIButton+DWebImage.h
//  ShareImage
//
//  Created by FTY on 2018/5/28.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DWebImage)

- (void)setImageWithURL:(NSString *)url forState:(UIControlState)state cornerRadius:(CGFloat)cornerRadius;


@end
