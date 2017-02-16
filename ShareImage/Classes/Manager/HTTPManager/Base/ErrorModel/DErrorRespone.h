//
//  DErrorRespone.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DBaseManagerProtocol;

@interface DErrorRespone : NSObject

/**
 *  获取错误码
 *
 *  @param error 错误对象
 *
 *  @return 错误码
 */
+ (int)getErrorCodeByError:(DError *)error;

/**
 *  获取错误提示
 *
 *  @param error 错误对象
 *
 *  @return 错误提示
 */
+ (NSString *)errorResponseByError:(DError *)error;

/**
 *  错误处理
 *
 *  @param engineError       错误对象
 *  @param delegate          实现代理
 *  @param isAlertFor2Second 是否提示两秒消失
 */
+ (void)proccessError:(DError *)engineError delegate:(id<DBaseManagerProtocol>)delegate isAlertFor2Second:(BOOL)isAlertFor2Second UserInfo:(NSDictionary *)userInfo;



@end
