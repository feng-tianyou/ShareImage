//
//  DUserService.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DUserService.h"

// network
#import "DUserNetwork.h"

// vaildRule
#import "DUserValidRule.h"

// model
#import "DPhotosModel.h"
#import "DCollectionsModel.h"

@interface DUserService ()
{
    NSMutableDictionary *_dicUserInfo;
}
@property (nonatomic, strong) DUserNetwork *userNetwork;

@end

@implementation DUserService

- (DUserNetwork *)userNetwork{
    if(_userNetwork == nil){
        _userNetwork = [DUserNetwork shareEngine];
    }
    _userNetwork.userInfoForCancelTask = _dicUserInfo;
    return _userNetwork;
}
/**
 授权
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)oauthAccountByParamModel:(id<DOAuthParamProtocol>)paramModel
                     onSucceeded:(JsonModelBlock)succeededBlock
                         onError:(ErrorBlock)errorBlock{
    
    [self.network postOauthAccountByParamModel:paramModel onSucceeded:^(id responseObject) {
        DLog(@"%@",responseObject);
        DOAuthAccountModel *model = [DOAuthAccountModel modelWithJSON:responseObject];
        
        KGLOBALINFOMANAGER.accessToken = model.access_token;
        KGLOBALINFOMANAGER.refreshToken = model.refresh_token;
        
        // 归档
        [DOAuthAccountTool saveAccount:model];
        
        [[DUserNetwork shareEngine] getAccountNeedCache:NO onSucceeded:^(NSDictionary *dic, BOOL isCache) {
            DUserModel *userModel = [DUserModel modelWithJSON:dic];
            KGLOBALINFOMANAGER.accountInfo = userModel;
            KGLOBALINFOMANAGER.uid = userModel.uid;
        } onError:^(DError *error) {
        }];
        
        [DBlockTool executeModelBlock:succeededBlock model:model];
    } onError:errorBlock];
}


/**
 *  获取个人信息
 *
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
-(void)fetchAccountByOnSucceeded:(JsonModelBlock)succeededBlock
                       onError:(ErrorBlock)errorBlock{
    [self.network getAccountNeedCache:YES onSucceeded:^(NSDictionary *dic, BOOL isCache) {
        DLog(@"%@", dic);
        [self.info setObject:@(isCache) forKey:kParamCacheData];
        DUserModel *userModel = [DUserModel modelWithJSON:dic];
        [DBlockTool executeModelBlock:succeededBlock model:userModel];
    } onError:errorBlock];
}

/**
 *  获取个人信息(不使用缓存)
 *
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
-(void)fetchAccountWithNotCacheByOnSucceeded:(JsonModelBlock)succeededBlock onError:(ErrorBlock)errorBlock{
    [self.network getAccountNeedCache:NO onSucceeded:^(NSDictionary *dic, BOOL isCache) {
        DLog(@"%@", dic);
        [self.info setObject:@(isCache) forKey:kParamCacheData];
        // 清除用户信息
        [KGLOBALINFOMANAGER clearAccountInfo];
        [KGLOBALINFOMANAGER clearUid];
        
        DUserModel *userModel = [DUserModel modelWithJSON:dic];
        KGLOBALINFOMANAGER.uid = userModel.uid;
        KGLOBALINFOMANAGER.accountInfo = userModel;
        [DBlockTool executeModelBlock:succeededBlock model:userModel];
    } onError:errorBlock];
}

/**
 更改个人信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)updateAccountByParamModel:(id<DUserParamProtocol>)paramModel
                      onSucceeded:(JsonModelBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DUserValidRule checkUpdateAccountByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network putAccountByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        // 清除用户信息
        [KGLOBALINFOMANAGER clearAccountInfo];
        [KGLOBALINFOMANAGER clearUid];
        
        DUserModel *userModel = [DUserModel modelWithJSON:dic];
        KGLOBALINFOMANAGER.uid = userModel.uid;
        KGLOBALINFOMANAGER.accountInfo = userModel;
        [DBlockTool executeModelBlock:succeededBlock model:userModel];
    } onError:errorBlock];
}


/**
 获取用户信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchUserProfileByParamModel:(id<DUserParamProtocol>)paramModel
                         onSucceeded:(JsonModelBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DUserValidRule checkGetUserProfileByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getUserProfileByParamModel:paramModel onSucceeded:^(NSDictionary *dic, BOOL isCache) {
        DLog(@"%@", dic);
        [self.info setObject:@(isCache) forKey:kParamCacheData];
        DUserModel *model = [DUserModel modelWithJSON:dic];
        [DBlockTool executeModelBlock:succeededBlock model:model];
    } onError:errorBlock];
}


/**
 获取用户介绍连接
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchUserProfileLinkByParamModel:(id<DUserParamProtocol>)paramModel
                             onSucceeded:(NSStringBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DUserValidRule checkGetUserProfileByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getUserProfileLinkByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        [DBlockTool executeStrBlock:succeededBlock result:[dic objectForKey:@"url"]];
    } onError:errorBlock];
}


/**
 获取用户的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchUserPhotosByParamModel:(id<DUserParamProtocol>)paramModel
                        onSucceeded:(NSArrayBlock)succeededBlock
                            onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DUserValidRule checkGetUserProfileByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getUserPhotosByParamModel:paramModel onSucceeded:^(NSArray *arr, BOOL isCache) {
        DLog(@"%@", arr);
        [self.info setObject:@(isCache) forKey:kParamCacheData];
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            DPhotosModel *photo = [DPhotosModel modelWithJSON:dic];
            [tmpArr addObject:photo];
        }];
        [DBlockTool executeArrBlock:succeededBlock arrResult:[tmpArr copy]];
    } onError:errorBlock];
}

/**
 获取用户喜欢的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchUserLikePhotosByParamModel:(id<DUserParamProtocol>)paramModel
                            onSucceeded:(NSArrayBlock)succeededBlock
                                onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DUserValidRule checkGetUserProfileByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getUserLikePhotosByParamModel:paramModel onSucceeded:^(NSArray *arr, BOOL isCache) {
        DLog(@"%@", arr);
        [self.info setObject:@(isCache) forKey:kParamCacheData];
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            DPhotosModel *photo = [DPhotosModel modelWithJSON:dic];
            [tmpArr addObject:photo];
        }];
        [DBlockTool executeArrBlock:succeededBlock arrResult:[tmpArr copy]];
    } onError:errorBlock];
}



/**
 获取用户分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchUserCollectionsByParamModel:(id<DUserParamProtocol>)paramModel
                             onSucceeded:(NSArrayBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DUserValidRule checkGetUserProfileByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getUserCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr, BOOL isCache) {
        [self.info setObject:@(isCache) forKey:kParamCacheData];
        DLog(@"%@", arr);
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            DCollectionsModel *model = [DCollectionsModel modelWithJSON:dic];
            [tmpArr addObject:model];
        }];
        [DBlockTool executeArrBlock:succeededBlock arrResult:[tmpArr copy]];
    } onError:errorBlock];
}

/**
 获取用户关注的人
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchUserFollowingByParamModel:(id<DUserParamProtocol>)paramModel
                           onSucceeded:(NSArrayBlock)succeededBlock
                               onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DUserValidRule checkGetUserProfileByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getUserFollowingByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        DLog(@"%@", arr);
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            DUserModel *model = [DUserModel modelWithJSON:dic];
            [tmpArr addObject:model];
        }];
        [DBlockTool executeArrBlock:succeededBlock arrResult:[tmpArr copy]];
    } onError:errorBlock];
}


/**
 获取用户粉丝
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchUserFollowersByParamModel:(id<DUserParamProtocol>)paramModel
                           onSucceeded:(NSArrayBlock)succeededBlock
                               onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DUserValidRule checkGetUserProfileByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getUserFollowersByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        DLog(@"%@", arr);
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            DUserModel *model = [DUserModel modelWithJSON:dic];
            [tmpArr addObject:model];
        }];
        [DBlockTool executeArrBlock:succeededBlock arrResult:[tmpArr copy]];
    } onError:errorBlock];
}


/**
 关注
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)followUserByParamModel:(id<DUserParamProtocol>)paramModel
                   onSucceeded:(JsonModelBlock)succeededBlock
                       onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DUserValidRule checkGetUserProfileByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network postFollowUserByParamModel:paramModel onSucceeded:^(id responseObject) {
//        [DBlockTool executeBoolBlock:succeededBlock result:[responseObject valueForKey:@"success"]];
        
        [self.network getUserProfileByParamModel:paramModel onSucceeded:^(NSDictionary *dic, BOOL isCache) {
            DLog(@"%@", dic);
            if (isCache) {
                return ;
            }
            [self.info setObject:@(isCache) forKey:kParamCacheData];
            DUserModel *model = [DUserModel modelWithJSON:dic];
            [DBlockTool executeModelBlock:succeededBlock model:model];
        } onError:errorBlock];
        
    } onError:errorBlock];
}




/**
 取消关注
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)cancelFollowUserByParamModel:(id<DUserParamProtocol>)paramModel
                         onSucceeded:(JsonModelBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DUserValidRule checkGetUserProfileByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network deleteFollowUserByParamModel:paramModel onSucceeded:^(id responseObject) {
//        [DBlockTool executeBoolBlock:succeededBlock result:[responseObject valueForKey:@"success"]];
        [self.network getUserProfileByParamModel:paramModel onSucceeded:^(NSDictionary *dic, BOOL isCache) {
            DLog(@"%@", dic);
            if (isCache) {
                return ;
            }
            [self.info setObject:@(isCache) forKey:kParamCacheData];
            DUserModel *model = [DUserModel modelWithJSON:dic];
            [DBlockTool executeModelBlock:succeededBlock model:model];
        } onError:errorBlock];
    } onError:errorBlock];
}



@end
