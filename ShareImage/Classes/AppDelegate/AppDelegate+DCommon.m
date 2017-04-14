//
//  AppDelegate+DCommon.m
//  DFrame
//
//  Created by DaiSuke on 2017/2/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "AppDelegate+DCommon.h"
#import <UMSocialCore/UMSocialCore.h>
#import <WXApi.h>

#import "DChooesRootViewControllerTool.h"
#import "DWebViewController.h"

#import "DTabBarViewController.h"


#define kBAIDU_TONGJI_APP_KEY       @"39846ebc46" // 百度统计
#define kJSPATCH_APP_KEY            @"9c2c9c38150f0643" // JSPatch

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate (DCommon)
#pragma mark - 跟控制器
/**
 初始化跟控制器
 */
- (void)setupRootViewController{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    self.window.rootViewController = [[DTabBarViewController alloc] init];
    [DChooesRootViewControllerTool setupRootViewControllerWithWindow:self.window];
}

#pragma mark - 回调地址
/**
 处理应用回调的地址
 
 @param url 地址
 @return 是否处理
 */
- (BOOL)handleApplicationOpenURL:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        // 其他如支付等SDK的回调
        //        if([url.host isEqualToString:@"safepay"])
        //        {
        //            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        //                NSLog(@"result = %@",resultDic);
        //                NSString *resultStr = resultDic[@"result"];
        //
        //                NSLog(@"resultStr = %@",resultStr);
        //            }];
        //        }
        //
        //        if([url.host isEqualToString:@"platformapi"])
        //        {
        //            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
        //                NSLog(@"result = %@",resultDic);
        //                NSString *resultStr = resultDic[@"result"];
        //
        //                NSLog(@"resultStr = %@",resultStr);
        //            }];
        //
        //        }
        
        
        //处理微信通过URL启动App时传递的数据(微信支付)
        //        [WXApi handleOpenURL:url delegate:self];
        
    }
    return result;
}


#pragma mark - WXApiDelegate
/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
//-(void)onReq:(BaseReq*)req{
//
//}



/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
//-(void)onResp:(BaseResp*)resp{
//
//}



#pragma mark - 3DTouch
/**
 初始化3D触控
 
 @param application application
 @param launchOptions launchOptions
 */
+ (void)setupShortcutIcon:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions{
    if (IOS9) {
        id shortcutIcons = [launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey];
        if (shortcutIcons) return;
        
        UIApplicationShortcutIcon *addFriendIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3d_btn_first"];
        UIMutableApplicationShortcutItem *addFriendItem = [[UIMutableApplicationShortcutItem alloc] initWithType:@"1" localizedTitle:@"添加好友" localizedSubtitle:nil icon:addFriendIcon userInfo:nil];
        
        UIApplicationShortcutIcon *publishIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3d_btn_second"];
        UIMutableApplicationShortcutItem *publishItem = [[UIMutableApplicationShortcutItem alloc] initWithType:@"2" localizedTitle:@"发布项目" localizedSubtitle:nil icon:publishIcon userInfo:nil];
        
        UIApplicationShortcutIcon *qrcodeIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3d_btn_third"];
        UIMutableApplicationShortcutItem *qrcodeItem = [[UIMutableApplicationShortcutItem alloc] initWithType:@"3" localizedTitle:@"扫二维码" localizedSubtitle:nil icon:qrcodeIcon userInfo:nil];
        
        application.shortcutItems = @[addFriendItem, publishItem, qrcodeItem];
    }
}


- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    NSInteger index = [shortcutItem.type integerValue];
    UIViewController *viewController = nil;
    switch (index) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            viewController = [[DWebViewController alloc] initWithUrl:@"http://daisuke.cn"];
        }
            break;
        case 3:
        {
            viewController = [[DWebViewController alloc] initWithUrl:@"https://www.baidu.com"];
        }
            break;
            
        default:
            break;
    }
    
    if (viewController) {
        DTabBarViewController *rootContoller = (DTabBarViewController *)self.window.rootViewController;
        UINavigationController *navController = rootContoller.selectedViewController;
        [navController pushViewController:viewController animated:YES];

    }
}

#pragma mark - Widget
- (void)handleApplicationOpenURLForWidget:(NSURL *)url{
    if ([url.scheme isEqualToString:@"DWidgetURL"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ExtenicationNotification" object:url.host];
        DLog(@"----%@", url.host);
        UIViewController *viewController = nil;
        switch ([url.host integerValue]) {
            case 1:
            {
                
            }
                break;
            case 2:
            {
                viewController = [[DWebViewController alloc] initWithUrl:@"http://daisuke.cn"];
            }
                break;
            case 3:
            {
                viewController = [[DWebViewController alloc] initWithUrl:@"https://www.baidu.com"];
            }
                break;
            case 4:
            {
                viewController = [[DWebViewController alloc] initWithUrl:@"https://www.baidu.com"];
            }
                break;
                
            default:
                break;
        }
        
        if (viewController) {
            DTabBarViewController *rootContoller = (DTabBarViewController *)self.window.rootViewController;
            UINavigationController *navController = rootContoller.selectedViewController;
            [navController pushViewController:viewController animated:YES];
            
        }
    }
}

@end
