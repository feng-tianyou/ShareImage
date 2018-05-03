//
//  DAlertLoading.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/23.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DAlertLoading.h"
#import <QuartzCore/QuartzCore.h>

#define TAG_RIGHTIMG 100

@implementation DAlertLoading

+(UIView *)alertLoadingWithMessage:(NSString *)msg andFrame:(CGRect)frame isBelowNav:(BOOL)isBelowNav
{
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    CGFloat y = 0;
    if(isBelowNav){
        y = 44;
        if(IOS7){
            y = 64;
        }
    }
    
    UIView *viewAll=[[UIView alloc] initWithFrame:CGRectMake(0, y, width, height - y)];
    viewAll.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    UIView *viewSub=[[UIView alloc] initWithFrame:frame];
    viewSub.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    viewSub.layer.cornerRadius=8.0;
    CGFloat subWidth = frame.size.width;
    CGFloat subHeight= frame.size.height;
    UILabel *lblAlert=[[UILabel alloc] initWithFrame:CGRectMake(0, (subHeight-20)/2.0 + 10, subWidth, 20)];
    lblAlert.text=msg;
    lblAlert.font=DSystemFontAlert;
    lblAlert.textColor=[UIColor whiteColor];
    [lblAlert setTextAlignment:NSTextAlignmentCenter];
    lblAlert.backgroundColor=[UIColor clearColor];
    [viewSub addSubview:lblAlert];
    
    UIActivityIndicatorView *activity=[[UIActivityIndicatorView alloc]
                                       initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.frame=CGRectMake((subWidth - 15)/2.0, (subHeight-15)/2.0 - 20, 15, 15);
    [activity startAnimating];
    [viewSub addSubview:activity];
    [viewAll addSubview:viewSub];
    return viewAll;
}

+(UIView *)alertLoadingWithMessage:(NSString *)msg Image:(UIImage *)img AndTestBg:(UIColor *)color
{
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    UIView *viewAll=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    viewAll.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    UIView *viewSub=[[UIView alloc] initWithFrame:CGRectMake(width/4.0, height/4.0, width/2.0, 150)];
    viewSub.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    viewSub.layer.cornerRadius=4.0;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(52, 20, 50, 100)];
    [imgView setImage:img];
    [viewSub addSubview:imgView];
    
    UILabel *lblAlert=[[UILabel alloc] initWithFrame:CGRectMake(20, 120, width/2.0-40, 20)];
    lblAlert.text=msg;
    [lblAlert.layer setCornerRadius:4];
    [lblAlert setTextAlignment:NSTextAlignmentCenter];
    lblAlert.font=DSystemFontAlert;
    lblAlert.textColor=[UIColor whiteColor];
    lblAlert.backgroundColor=color;
    [viewSub addSubview:lblAlert];
    
    [viewAll addSubview:viewSub];
    return viewAll;
}

+(UIView *)alertLoadingWithMessage:(NSString *)msg leftImage:(UIImage *)imgleft rightImage:(UIImage *)imgRight
{
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    UIView *viewAll=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    viewAll.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    UIView *viewSub=[[UIView alloc] initWithFrame:CGRectMake(width/4.0, height/4.0, width/2.0, 150)];
    viewSub.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    viewSub.layer.cornerRadius=4.0;
    
    UIImageView *imgLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 10, 50, 100)];
    [imgLeftView setImage:imgleft];
    [viewSub addSubview:imgLeftView];
    
    UIImageView *imgRightView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 20, 20, 81)];
    [imgRightView setImage:imgRight];
    [imgRightView setTag:TAG_RIGHTIMG];
    [viewSub addSubview:imgRightView];
    
    UILabel *lblAlert=[[UILabel alloc] initWithFrame:CGRectMake(20, 120, width/2.0-40, 20)];
    lblAlert.text=msg;
    [lblAlert.layer setCornerRadius:4];
    lblAlert.font=DSystemFontAlert;
    lblAlert.textColor=[UIColor whiteColor];
    lblAlert.backgroundColor=[UIColor clearColor];
    [viewSub addSubview:lblAlert];
    
    [viewAll addSubview:viewSub];
    return viewAll;
}

@end
