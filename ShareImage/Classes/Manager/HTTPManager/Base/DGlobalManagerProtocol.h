//
//  DGlobalManagerProtocol.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DBaseManager;
@protocol DGlobalManagerProtocol <NSObject>

- (void)addManager:(DBaseManager *)manager;

- (void)removeManager:(DBaseManager *)manager;

- (void)removeManagerByUserInfo:(NSDictionary *)userInfo;

@end
