//
//  AppDelegate.h
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DGlobalManagerProtocol;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic, nullable) UIWindow *window;

@property (nonatomic,strong,nullable)id<DGlobalManagerProtocol> globalManager;

@property (copy, nonatomic, nullable) NSString *deviceId;

NS_ASSUME_NONNULL_END
@end

