//
//  DUserAPIManager.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DUserAPIManager.h"
#import "DUserService.h"

@implementation DUserAPIManager
/**
 授权
 
 @param paramModel 参数模型
 */
- (void)oauthAccountByParamModel:(id<DOAuthParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self)
    [self.service oauthAccountByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 *  获取用户信息
 
 回调：requestServiceSucceedWithModel:(DUserModel)
 *
 */
-(void)fetchAccountProfile{
    @weakify(self)
    [self.service fetchAccountByOnSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 *  获取用户信息(不使用缓存)
 
 回调：requestServiceSucceedWithModel:(DUserModel)
 *
 */
-(void)fetchAccountProfileWithNotCache{
    [self addLoadingView];
    @weakify(self)
    [self.service fetchAccountWithNotCacheByOnSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

@end
