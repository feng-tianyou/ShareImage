//
//  DShareManager.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/5.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DShareManager.h"
#import <MessageUI/MessageUI.h>
#import <UShareUI/UShareUI.h>
#import <SVProgressHUD/SVProgressHUD.h>


@interface DShareManager()<MFMessageComposeViewControllerDelegate>
{
    BoolBlock _resultBlock;
}
@end

@implementation DShareManager

//+ (instancetype)shareManager{
//    static DShareManager *share;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        share = [[DShareManager alloc] init];
//    });
//    return share;
//}

/**
 分享（所有平台）
 
 @param title 标题
 @param content 内容
 @param shareUrl 连接
 @param parentController 当前控制器
 */
+ (void)shareUrlForAllPlatformByTitle:(NSString *)title
                              content:(NSString *)content
                             shareUrl:(NSString *)shareUrl
                     parentController:(UIViewController *)parentController{
    [self shareUrlForAllPlatformByTitle:title content:content shareUrl:shareUrl customPlatforms:nil parentController:parentController eventBlock:nil];
}


/**
 分享（所有平台）(添加自定义平台)
 
 @param title 标题
 @param content 内容
 @param shareUrl 连接
 @param customPlatforms 自定义平台（
 描述： customPlatforms数组存放字典，
 字典格式：@{@"platformIcon":@"平台图片", @"platformName":@"平台名称"}）
 字典两个关键字key：platformIcon、platformName
 @param parentController 当前控制器
 */
+ (void)shareUrlForAllPlatformByTitle:(NSString *)title
                              content:(NSString *)content
                             shareUrl:(NSString *)shareUrl
                      customPlatforms:(NSArray *)customPlatforms
                     parentController:(UIViewController *)parentController
                           eventBlock:(CustomPlatformBlock)eventBlock{
    title = title.length > 0 ? title : @"DaiSuke";
    content = content.length > 0 ? content : @"DaiSuke的网站";
    shareUrl = shareUrl.length > 0 ? shareUrl : @"http://daisuke.cn";
    NSAssert(parentController, @"当前控制器不能为空！");
    
    if (customPlatforms.count > 0) {
        [customPlatforms enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            [UMSocialUIManager addCustomPlatformWithoutFilted:(1000 + idx + 1) withPlatformIcon:[UIImage getImageWithName:[dic objectForKey:@"platformIcon"]] withPlatformName:[dic objectForKey:@"platformName"]];
        }];
    } else {
        [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    }
    
    // 初始化平台
    NSArray *platforms = @[
                           @(UMSocialPlatformType_Sina), //新浪
                           @(UMSocialPlatformType_WechatSession), //微信聊天
                           @(UMSocialPlatformType_WechatTimeLine),//微信朋友圈
                           @(UMSocialPlatformType_QQ),//QQ聊天页面
                           @(UMSocialPlatformType_Qzone),//qq空间
                           @(UMSocialPlatformType_Sms),//短信
                           @(UMSocialPlatformType_Email),//邮件
                           ];
    
    [UMSocialUIManager setPreDefinePlatforms:platforms];
    
    
    
    // 显示分享平板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        if (platformType > 1000 && platformType < 2000) {
            if (eventBlock) {
                eventBlock(platformType, userInfo);
                return ;
            }
        }
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        UIImage *defaultImage = [UIImage getImageWithName:@"tabbar_me_select"];
        // 创建媒体对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:defaultImage];
        //设置网页地址
        shareObject.webpageUrl = shareUrl;
        
        messageObject.shareObject = shareObject;
        
        switch (platformType) {
            case UMSocialPlatformType_Sms:
            {
                // 定制SMS
                messageObject.text = @"这是短信息，需要在DShareManager定制SMS";
                messageObject.shareObject = nil;
            }
                break;
            case UMSocialPlatformType_Sina:{
                
            }
                break;
                
            default:
                break;
        }
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:parentController completion:^(id data, NSError *error) {
            
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
                NSString *message = @"";
                switch (error.code) {
                    case 2001:
                    {
                        message = @"设备不支持发送SMS";
                    }
                        break;
                    case 2003:
                    {
                        message = @"设备不支持发送邮件";
                    }
                        break;
                    case 2009:
                    {
                        return ;
                    }
                        break;
                        
                        
                    default:
                    {
                        message = @"分享失败，请重试！";
                    }
                        break;
                }
                [SVProgressHUD showErrorWithStatus:message maskType:SVProgressHUDMaskTypeBlack];
            }else{
                [SVProgressHUD showSuccessWithStatus:@"分享成功！" maskType:SVProgressHUDMaskTypeBlack];
            }
        }];
        
        
    }];
}


/**
 分享（朋友圈平台）
 
 @param title 标题
 @param content 内容
 @param shareUrl 连接
 @param parentController 当前控制器
 */
- (void)shareUrlForWechatTimeLineByTitle:(NSString *)title
                                 content:(NSString *)content
                                shareUrl:(NSString *)shareUrl
                        parentController:(UIViewController *)parentController{
    title = title.length > 0 ? title : @"DaiSuke";
    content = content.length > 0 ? content : @"DaiSuke的网站";
    shareUrl = shareUrl.length > 0 ? shareUrl : @"http://daisuke.cn";
    NSAssert(parentController, @"当前控制器不能为空！");
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UIImage *img = [UIImage getImageWithName:@"tabbar_me_select"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = shareUrl;
    messageObject.shareObject = shareObject;
    
    // 设置分享平台
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:parentController completion:^(id result, NSError *error) {
        DLog(@"%@-%@",result,error);
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            switch (error.code) {
                case 2008:
                    [SVProgressHUD showErrorWithStatus:@"没有安装微信，分享失败" maskType:SVProgressHUDMaskTypeBlack];
                    break;
                case 2009:
                    // 取消分享
                    return ;
                    break;
                    
                default:
                    break;
            }
            
            [SVProgressHUD showErrorWithStatus:@"分享失败，请重试！" maskType:SVProgressHUDMaskTypeBlack];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"分享成功！" maskType:SVProgressHUDMaskTypeBlack];
        }
    }];
}

/**
 分享短信信息
 
 @param message 内容信息
 @param recipients 联系人集合
 @param parentController 当前控制器
 @param resultBlock 发送回调
 */
- (void)shareSMSWithMessage:(NSString *)message
                 recipients:(NSArray *)recipients
           parentController:(UIViewController *)parentController
                resultBlock:(BoolBlock)resultBlock{

    NSAssert(message, @"内容信息不能为空");
    _resultBlock = resultBlock;
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
        messageVC.body = message;
        messageVC.recipients = recipients;
        messageVC.messageComposeDelegate = self;
        [parentController presentViewController:messageVC animated:YES completion:nil];
    } else {
        [SVProgressHUD showErrorWithStatus:@"设备没有短信功能" maskType:SVProgressHUDMaskTypeBlack];
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    BOOL falg = NO;
    if (result == MessageComposeResultSent) {
        falg = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:0.5];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"发送成功！" maskType:SVProgressHUDMaskTypeBlack];
            });
        });
    } else if (result == MessageComposeResultCancelled){
        return;
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:0.5];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:@"发送失败" maskType:SVProgressHUDMaskTypeBlack];
            });
        });
    }
    
    if (_resultBlock) {
        _resultBlock(falg);
    }
}


@end
