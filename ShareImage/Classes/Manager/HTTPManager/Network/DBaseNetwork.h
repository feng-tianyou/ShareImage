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

#pragma mark 处理返回得数据
-(id)handleResponseData:(NSData *)data;

-(void)saveCookies;

-(void)setUserDefaultByDicData:(NSDictionary *)dicData;

-(void)clearUserToken;

- (void)clearRefreshTokenBlockCache;

- (void)proccessResponseData:(id)responseObject
                        task:(NSURLSessionDataTask *)task
                 onSucceeded:(NSDictionaryBlock) succeededBlock
                     onError:(ErrorBlock) errorBlock;

-(void)opPostWithUrlPath:(NSString *)path
                  params:(NSDictionary *)paramsDic
                needUUID:(BOOL)needUUID
               needToken:(BOOL)needToken
             onSucceeded:(NSDictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock;

-(void)opGetWithUrlPath:(NSString *)path
                 params:(NSDictionary *)paramsDic
               needUUID:(BOOL)needUUID
              needToken:(BOOL)needToken
            onSucceeded:(NSDictionaryBlock) succeededBlock
                onError:(ErrorBlock) errorBlock;

-(void)opPutWithUrlPath:(NSString *)path
                 params:(NSDictionary *)paramsDic
               needUUID:(BOOL)needUUID
              needToken:(BOOL)needToken
            onSucceeded:(NSDictionaryBlock) succeededBlock
                onError:(ErrorBlock) errorBlock;

-(void)opDeleteWithUrlPath:(NSString *)path
                    params:(NSDictionary *)paramsDic
                  needUUID:(BOOL)needUUID
                 needToken:(BOOL)needToken
               onSucceeded:(NSDictionaryBlock) succeededBlock
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

//-(BOOL)isValidAccessToken;

-(NSArray *)proccessArrData:(NSArray *)arr;

#pragma mark 数组转换成json
-(NSString *)arrDataToJson:(NSArray *)arr;

-(NSDictionary *)addAccessTokenForDicParam:(NSDictionary *)dicParam;



@end
