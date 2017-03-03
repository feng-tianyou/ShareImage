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
 
 参数模型：DOAuthParamModel
 client_id：AppKey(Required)
 client_secret：秘钥;(Required)
 redirect_uri：回调地址;(Required)
 grant_type：授权类型 @"authorization_code";(Required)
 code：固定 code; (Required)
 
 回调：requestServiceSucceedWithModel:(DOAuthAccountModel)
 
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
 *  获取个人信息
 
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
 *  获取个人信息(不使用缓存)
 
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

/**
 更改个人信息
 
 参数模型：DUserParamModel
 username 用户名(Optional)
 first_name 姓(Optional)
 last_name 名(Optional)
 email email,格式必须正确(Optional)
 url 个人简介地址(Optional)
 location 地址(Optional)
 bio 简介(Optional)
 instagram_username instagram昵称
 
 回调：requestServiceSucceedWithModel:(DUserModel)
 
 @param paramModel 参数模型
 */
- (void)updateAccountByParamModel:(id<DUserParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self)
    [self.service updateAccountByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 获取用户信息
 
 参数模型：DUserParamModel
 username 用户名(Required)
 
 回调：requestServiceSucceedWithModel:(DUserModel)
 
 @param paramModel 参数模型
 */
- (void)fetchUserProfileByParamModel:(id<DUserParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self)
    [self.service fetchUserProfileByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 获取用户介绍连接
 
 参数模型：DUserParamModel
 username 用户名(Required)
 
 回调：requestServiceSucceedBackString:(NSSting)
 
 @param paramModel 参数模型
 */
- (void)fetchUserProfileLinkByParamModel:(id<DUserParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self)
    [self.service fetchUserProfileLinkByParamModel:paramModel onSucceeded:^(NSString *str) {
        @strongify(self)
        [self requestServiceSucceedBackString:str];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 获取用户的图片集合
 
 参数模型：DUserParamModel
 username: 用户名(Required)
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 order_by：排序（Valid values: latest, oldest, popular; default: latest）
 
 回调：requestServiceSucceedBackArray:(DPhotosModel)
 
 @param paramModel 参数模型
 */
- (void)fetchUserPhotosByParamModel:(id<DUserParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self)
    [self.service fetchUserPhotosByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        //分页处理:当start为0时需要做clearData处理，当获取的arr数据为空时，调用相关方法告知页面没有数据
        if([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]){
            return;
        }
        
        //分页处理:当获取到的数据小于设置的limit条数时，告知页面没有更多数据了
        if(arr.count < paramModel.per_page){
            [self requestServiceSucceedBackArray:arr];
            [self hasNotMoreData];
            return;
        }
        
        [self requestServiceSucceedBackArray:arr];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 获取用户喜欢的图片集合
 
 参数模型：DUserParamModel
 username: 用户名(Required)
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 order_by：排序（Valid values: latest, oldest, popular; default: latest）
 
 回调：requestServiceSucceedBackArray:(DPhotosModel)
 
 @param paramModel 参数模型
 */
- (void)fetchUserLikePhotosByParamModel:(id<DUserParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self)
    [self.service fetchUserLikePhotosByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        //分页处理:当start为0时需要做clearData处理，当获取的arr数据为空时，调用相关方法告知页面没有数据
        if([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]){
            return;
        }
        
        //分页处理:当获取到的数据小于设置的limit条数时，告知页面没有更多数据了
        if(arr.count < paramModel.per_page){
            [self requestServiceSucceedBackArray:arr];
            [self hasNotMoreData];
            return;
        }
        
        [self requestServiceSucceedBackArray:arr];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 获取用户分类集合
 
 参数模型：DUserParamModel
 username: 用户名(Required)
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 order_by：排序（Valid values: latest, oldest, popular; default: latest）
 
 回调：requestServiceSucceedBackArray:(DCollectionsModel)
 
 @param paramModel 参数模型
 */- (void)fetchUserCollectionsByParamModel:(id<DUserParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self)
    [self.service fetchUserCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        //分页处理:当start为0时需要做clearData处理，当获取的arr数据为空时，调用相关方法告知页面没有数据
        if([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]){
            return;
        }
        
        //分页处理:当获取到的数据小于设置的limit条数时，告知页面没有更多数据了
        if(arr.count < paramModel.per_page){
            [self requestServiceSucceedBackArray:arr];
            [self hasNotMoreData];
            return;
        }
        
        [self requestServiceSucceedBackArray:arr];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}



/**
 获取用户关注的人
 
 参数模型：DUserParamModel
 username: 用户名(Required)
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedBackArray:(DUserModel)
 
 @param paramModel 参数模型
 */
- (void)fetchUserFollowingByParamModel:(id<DUserParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self)
    [self.service fetchUserFollowingByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        //分页处理:当start为0时需要做clearData处理，当获取的arr数据为空时，调用相关方法告知页面没有数据
        if([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]){
            return;
        }
        
        //分页处理:当获取到的数据小于设置的limit条数时，告知页面没有更多数据了
        if(arr.count < paramModel.per_page){
            [self requestServiceSucceedBackArray:arr];
            [self hasNotMoreData];
            return;
        }
        
        [self requestServiceSucceedBackArray:arr];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 获取用户粉丝
 
 参数模型：DUserParamModel
 username: 用户名(Required)
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedBackArray:(DUserModel)
 
 @param paramModel 参数模型
 */
- (void)fetchUserFollowersByParamModel:(id<DUserParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self)
    [self.service fetchUserFollowersByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        //分页处理:当start为0时需要做clearData处理，当获取的arr数据为空时，调用相关方法告知页面没有数据
        if([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]){
            return;
        }
        
        //分页处理:当获取到的数据小于设置的limit条数时，告知页面没有更多数据了
        if(arr.count < paramModel.per_page){
            [self requestServiceSucceedBackArray:arr];
            [self hasNotMoreData];
            return;
        }
        
        [self requestServiceSucceedBackArray:arr];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}



/**
 关注
 
 参数模型：DUserParamModel
 username: 用户名(Required)
 
 回调：requestServiceSucceedBackBool:(BOOL)
 
 @param paramModel 参数模型
 */
- (void)followUserByParamModel:(id<DUserParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self)
    [self.service followUserByParamModel:paramModel onSucceeded:^(BOOL isTrue) {
        [self requestServiceSucceedBackBool:isTrue];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}




/**
 取消关注
 
 参数模型：DUserParamModel
 username: 用户名(Required)
 
 回调：requestServiceSucceedBackBool:(BOOL)
 
 @param paramModel 参数模型
 */
- (void)cancelFollowUserByParamModel:(id<DUserParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self)
    [self.service cancelFollowUserByParamModel:paramModel onSucceeded:^(BOOL isTrue) {
        [self requestServiceSucceedBackBool:isTrue];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}







@end
