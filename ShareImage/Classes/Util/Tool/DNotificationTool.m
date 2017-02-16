//
//  DNotificationTool.m
//  DFrame
//
//  Created by DaiSuke on 2017/2/3.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DNotificationTool.h"
#import "DCacheManager.h"

@implementation DNotificationTool

+ (void)sendNotificationByName:(NSString *)name
                      userInfo:(NSDictionary *)userInfo{
    if([[NSThread currentThread] isMainThread]){
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
        });
    }
}

+ (void)sendNotificationByName:(NSString *)name
                        object:(id)object{
    if([[NSThread currentThread] isMainThread]){
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
        });
    }
}


+ (void)sendTabBarUpdateNotificationWithUserInfo:(NSDictionary *)userInfo{
    [DNotificationTool sendNotificationByName:kTabBar_Badge_value userInfo:userInfo];
}



@end
