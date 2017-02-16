//
//  AppDelegate+DShare.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/5.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "AppDelegate+DShare.h"
#import <UMSocialCore/UMSocialCore.h>


@interface AppDelegate()

@end

@implementation AppDelegate (DShare)

/**
 初始化分享
 */
+ (void)setupShareManager{
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"	586e1935f43e484f53001135"];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    // e0fe913fd114bc7bd45f807bc9b63967  wxbf2b8c78afe292b9
    // 3baf1193c85774b3fd9d18447d76cab0  wxdc1e388c3822c80b
    
    //设置分享到QQ互联的appKey和appSecret
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105933558"  appSecret:nil redirectURL:@"http://daisuke.cn"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"654552552"  appSecret:@"ced9b6de2fd7fa866d975ad503b215ec" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];

   
    
}



@end
