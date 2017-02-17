//
//  DBaseNetwork.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface DBaseNetwork : AFHTTPSessionManager

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *UDID;

@property (nonatomic, strong) NSMutableDictionary *userInfoForCancelTask;

#pragma mark 根据kHttpURL初始化
-(id)initWithDefaultHttpURL;

#pragma mark 根据kFileUrl初始化
-(id)initWithDefaultFileURL;

-(id)initWithBaseURL:(NSURL *)url;


#pragma mark - 额外方法
-(void)saveCookies;

-(void)setUserDefaultByDicData:(NSDictionary *)dicData;

-(void)clearUserToken;

- (void)clearRefreshTokenBlockCache;

- (void)proccessResponseData:(id)responseObject
                        task:(NSURLSessionDataTask *)task
                 onSucceeded:(NSObjectBlock) succeededBlock
                     onError:(ErrorBlock) errorBlock;

#pragma mark - 请求方法
/**
 GET请求
 
 @param path 请求路径
 @param paramsDic 参数
 @param needUUID UUID
 @param needToken Token
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
-(void)opGetWithUrlPath:(NSString *)path
                 params:(NSDictionary *)paramsDic
               needUUID:(BOOL)needUUID
              needToken:(BOOL)needToken
            onSucceeded:(NSObjectBlock) succeededBlock
                onError:(ErrorBlock) errorBlock;


/**
 POST请求

 @param path 请求路径
 @param paramsDic 参数
 @param needUUID UUID
 @param needToken Token
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
-(void)opPostWithUrlPath:(NSString *)path
                  params:(NSDictionary *)paramsDic
                needUUID:(BOOL)needUUID
               needToken:(BOOL)needToken
             onSucceeded:(NSObjectBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock;



/**
 PUT请求
 
 @param path 请求路径
 @param paramsDic 参数
 @param needUUID UUID
 @param needToken Token
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
-(void)opPutWithUrlPath:(NSString *)path
                 params:(NSDictionary *)paramsDic
               needUUID:(BOOL)needUUID
              needToken:(BOOL)needToken
            onSucceeded:(NSObjectBlock) succeededBlock
                onError:(ErrorBlock) errorBlock;

/**
 DELETE请求
 
 @param path 请求路径
 @param paramsDic 参数
 @param needUUID UUID
 @param needToken Token
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
-(void)opDeleteWithUrlPath:(NSString *)path
                    params:(NSDictionary *)paramsDic
                  needUUID:(BOOL)needUUID
                 needToken:(BOOL)needToken
               onSucceeded:(NSObjectBlock) succeededBlock
                   onError:(ErrorBlock) errorBlock;


#pragma mark 处理网络缓存
- (BOOL)proccessCacheDataByKey:(NSString *)key
                succeededBlock:(NSDictionaryForCacheBlock)succeededBlock;

- (void)saveCacheDataByDic:(NSDictionary *)dic
                  cacheKey:(NSString *)cacheKey;

- (void)saveCacheDataByDic:(NSDictionary *)dic
                  cacheKey:(NSString *)cacheKey
                 cacheTime:(NSTimeInterval)cacheTime;

#pragma mark 刷新token
-(void)reFreshTokenOnSucceeded:(NSDictionaryBlock)succeededBlock
                       onError:(ErrorBlock)errorBlock;



#pragma mark 添加Token到参数
- (NSDictionary *)addAccessTokenForDicParam:(NSDictionary *)dicParam;


@end
