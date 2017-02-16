//
//  DTabBarBadgeButton.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DTabBarBadgeButton.h"

@implementation DTabBarBadgeButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizedImageWithName:@"common_red_circle"] forState:UIControlStateNormal];
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}


- (void)setBadgeValue:(NSString *)badgeValue{
    
    _badgeValue = [badgeValue copy];
    
    if (badgeValue && [badgeValue integerValue] != 0) {
        self.hidden = NO;
        
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            if (badgeSize.width > 19.0) {
                [self setTitle:@"..." forState:UIControlStateNormal];
                badgeW = badgeSize.width + 2;
            } else {
                badgeW = badgeSize.width + 10;
            }
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH+2;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
    
}

@end
