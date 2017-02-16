//
//  DUserManager.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DUserManager.h"
#import "DUserService.h"

@implementation DUserManager

/**
 *  获取用户信息
 
 *  callbackMethor <- requestServiceSucceedWithModel -> 回调方法
 *  callbackModel  <- TGUserModel -> 回调Model
 */
-(void)getAccount{
    [self addLoadingView];
    @weakify(self)
    [self.service getAccountByOnSucceeded:^(DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 *  获取用户信息(不使用缓存)
 
 *  callbackMethor <- requestServiceSucceedWithModel -> 回调方法
 *  callbackModel  <- TGUserModel -> 回调Model
 */
-(void)getAccountWithNotCache{
    [self addLoadingView];
    @weakify(self)
    [self.service getAccountWithNotCacheByOnSucceeded:^(DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

@end
