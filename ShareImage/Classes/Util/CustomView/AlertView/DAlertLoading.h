//
//  DAlertLoading.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/23.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAlertLoading : UIView

+(UIView *)alertLoadingWithMessage:(NSString *)msg andFrame:(CGRect)frame isBelowNav:(BOOL)isBelowNav;

+(UIView *)alertLoadingWithMessage:(NSString *)msg Image:(UIImage *)img AndTestBg:(UIColor *)color;

+(UIView *)alertLoadingWithMessage:(NSString *)msg leftImage:(UIImage *)imgleft rightImage:(UIImage *)imgRight;


@end
