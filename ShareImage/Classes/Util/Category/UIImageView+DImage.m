//
//  UIImageView+DImage.m
//  ShareImage
//
//  Created by FTY on 2018/5/28.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import "UIImageView+DImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+DUIImage.h"

@implementation UIImageView (DImage)

- (void)setImageWithURL:(NSString *)url cornerRadius:(CGFloat)cornerRadius callBack:(UIImageBlock)callBack{
    @weakify(self)
    [self setImageWithURL:[NSURL URLWithString:url] placeholder:nil options:YYWebImageOptionShowNetworkActivity completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (image && error == nil) {
            image = [image imageByRoundCornerRadiusWithimageViewSize:CGSizeMake(cornerRadius * 2, cornerRadius * 2)];
            ExistActionDo(callBack, callBack(image))
            @strongify(self)
            self.image = image;
        }
    }];
}

@end
