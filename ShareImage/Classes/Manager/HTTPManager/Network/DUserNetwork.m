//
//  DUserNetwork.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DUserNetwork.h"
#import "DPlistManager.h"

@implementation DUserNetwork

#pragma mark 单例实现初始化
+(DUserNetwork *)shareEngine
{
    static DUserNetwork *_engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _engine = [[DUserNetwork alloc] initWithDefaultHttpURL];
    });
    return _engine;
}

/**
 授权
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postOauthAccountByParamModel:(id<DOAuthParamProtocol>)paramModel
                     onSucceeded:(NSDictionaryBlock)succeededBlock
                         onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForOAuthAccount];
    [self opPostWithUrlPath:@"https://unsplash.com/oauth/token" params:dicParam needUUID:NO needToken:NO onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
    
    
}


/**
 *  获取个人信息
 *
 *  @param isNeedCache    是否需要调用缓存
 *  @param succeededBlock 成功回调
 *  @param errorBlock     失败回调
 */
- (void)getAccountNeedCache:(BOOL)isNeedCache
                onSucceeded:(NSObjectForCacheBlock)succeededBlock
                    onError:(ErrorBlock)errorBlock{
    if(isNeedCache){
        [self readCacheDataWithCacheKey:kCacheAccountInfo succeededBlock:succeededBlock];
    }
    
    [self opGetWithUrlPath:@"/me" params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        // 缓存用户信息
        [self saveDataWithData:responseObject cacheKey:kCacheAccountInfo cacheTime:kCacheTimeForOneMonth];
        // 回调
        ExistActionDo(succeededBlock, succeededBlock(responseObject, NO));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 更改个人信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)putAccountByParamModel:(id<DUserParamProtocol>)paramModel
                   onSucceeded:(NSDictionaryBlock)succeededBlock
                       onError:(ErrorBlock)errorBlock{
    
    NSDictionary *dicParam = [paramModel getParamDicForPostUser];
    [self opPutWithUrlPath:@"/me" params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        // 缓存用户信息
        [self saveDataWithData:responseObject cacheKey:kCacheAccountInfo cacheTime:kCacheTimeForOneMonth];
        // 回调
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 获取用户信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserProfileByParamModel:(id<DUserParamProtocol>)paramModel
                       onSucceeded:(NSObjectForCacheBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock{
    // 读取缓存
    NSString *cachekey = [NSString stringWithFormat:kCacheUsersProfileByUserName,paramModel.username];
    [self readCacheDataWithCacheKey:cachekey succeededBlock:succeededBlock];
    
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/users/%@", paramModel.username] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        // 缓存
        NSString *cachekey = [NSString stringWithFormat:kCacheUsersProfileByUserName,paramModel.username];
        [self saveDataWithData:responseObject cacheKey:cachekey cacheTime:kCacheTimeForOneWeek];
        ExistActionDo(succeededBlock, succeededBlock(responseObject, NO));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}

/**
 获取用户介绍连接
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserProfileLinkByParamModel:(id<DUserParamProtocol>)paramModel
                           onSucceeded:(NSDictionaryBlock)succeededBlock
                               onError:(ErrorBlock)errorBlock{
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/users/%@/portfolio", paramModel.username] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}

/**
 获取用户的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserPhotosByParamModel:(id<DUserParamProtocol>)paramModel
                      onSucceeded:(NSObjectForCacheBlock)succeededBlock
                          onError:(ErrorBlock)errorBlock{
    if (paramModel.page == 1) {
        // 读取缓存
        NSString *cachekey = [NSString stringWithFormat:kCacheUsersPhotosByUserName,paramModel.username];
        [self readCacheDataWithCacheKey:cachekey succeededBlock:succeededBlock];
    }
    
    NSDictionary *dicParam = [paramModel getParamDicForGetUserPhotos];
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/users/%@/photos", paramModel.username] params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        if (paramModel.page == 1) {
            // 缓存
            NSString *cachekey = [NSString stringWithFormat:kCacheUsersPhotosByUserName,paramModel.username];
            [self saveDataWithData:responseObject cacheKey:cachekey cacheTime:kCacheTimeForOneWeek];
        }
        // 回调
        ExistActionDo(succeededBlock, succeededBlock(responseObject, NO));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}

/**
 获取用户喜欢的图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserLikePhotosByParamModel:(id<DUserParamProtocol>)paramModel
                          onSucceeded:(NSObjectForCacheBlock)succeededBlock
                              onError:(ErrorBlock)errorBlock{
    if (paramModel.page == 1) {
        // 读取缓存
        NSString *cachekey = [NSString stringWithFormat:kCacheUsersLikePhotosByUserName,paramModel.username];
        [self readCacheDataWithCacheKey:cachekey succeededBlock:succeededBlock];
    }
    NSDictionary *dicParam = [paramModel getParamDicForGetUserPhotos];
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/users/%@/likes", paramModel.username] params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        if (paramModel.page == 1) {
            // 缓存
            NSString *cachekey = [NSString stringWithFormat:kCacheUsersLikePhotosByUserName,paramModel.username];
            [self saveDataWithData:responseObject cacheKey:cachekey cacheTime:kCacheTimeForOneWeek];
        }
        ExistActionDo(succeededBlock, succeededBlock(responseObject, NO));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 获取用户分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserCollectionsByParamModel:(id<DUserParamProtocol>)paramModel
                           onSucceeded:(NSObjectForCacheBlock)succeededBlock
                               onError:(ErrorBlock)errorBlock{
    if (paramModel.page == 1) {
        // 读取缓存
        NSString *cachekey = [NSString stringWithFormat:kCacheUsersCollectionsByUserName,paramModel.username];
        [self readCacheDataWithCacheKey:cachekey succeededBlock:succeededBlock];
    }
    
    NSDictionary *dicParam = [paramModel getParamDicForGetUserCollections];
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/users/%@/collections", paramModel.username] params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        if (paramModel.page == 1) {
            // 缓存
            NSString *cachekey = [NSString stringWithFormat:kCacheUsersCollectionsByUserName,paramModel.username];
            [self saveDataWithData:responseObject cacheKey:cachekey cacheTime:kCacheTimeForOneWeek];
        }
        ExistActionDo(succeededBlock, succeededBlock(responseObject, NO));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}



/**
 获取用户关注的人
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserFollowingByParamModel:(id<DUserParamProtocol>)paramModel
                         onSucceeded:(NSObjectBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetUserCollections];
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/users/%@/following", paramModel.username] params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 获取用户粉丝
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)getUserFollowersByParamModel:(id<DUserParamProtocol>)paramModel
                         onSucceeded:(NSObjectBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock{
    NSDictionary *dicParam = [paramModel getParamDicForGetUserCollections];
    [self opGetWithUrlPath:[NSString stringWithFormat:@"/users/%@/followers", paramModel.username] params:dicParam needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


/**
 关注
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)postFollowUserByParamModel:(id<DUserParamProtocol>)paramModel
                       onSucceeded:(NSObjectBlock)succeededBlock
                           onError:(ErrorBlock)errorBlock{
    [self opPostWithUrlPath:[NSString stringWithFormat:@"https://unsplash.com/napi/users/%@/follow", paramModel.username] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}




/**
 取消关注
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)deleteFollowUserByParamModel:(id<DUserParamProtocol>)paramModel
                         onSucceeded:(NSObjectBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock{
    [self opDeleteWithUrlPath:[NSString stringWithFormat:@"https://unsplash.com/napi/users/%@/follow", paramModel.username] params:nil needUUID:NO needToken:YES onSucceeded:^(id responseObject) {
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } onError:^(DError *error) {
        ExistActionDo(errorBlock, errorBlock(error));
    }];
}


@end
