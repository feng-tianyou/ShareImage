//
//  UIButton+DWebImage.m
//  ShareImage
//
//  Created by FTY on 2018/5/28.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import "UIButton+DWebImage.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "UIImage+DUIImage.h"
#import "UIImageView+DImage.m"

@implementation UIButton (DWebImage)

- (void)setImageWithURL:(NSString *)url forState:(UIControlState)state cornerRadius:(CGFloat)cornerRadius{
    @weakify(self)
    [self.imageView setImageWithURL:url cornerRadius:cornerRadius callBack:^(UIImage *img) {
        @strongify(self)
        [self setImage:img forState:state];
    }];
    
}

@end
