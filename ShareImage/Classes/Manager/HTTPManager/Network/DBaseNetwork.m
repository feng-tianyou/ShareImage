//
//  DBaseNetwork.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseNetwork.h"
#import "OpenUDID.h"
#import "AppDelegate.h"

#define YWQ_NETWORK_KEY_FOR_SUCCEEDBLOCK    @"succeedBlock"
#define YWQ_NETWORK_KEY_FOR_ERRORBLOCK      @"errorBlock"
#define YWQ_NETWORK_KEY_FOR_OPERATION       @"operation"
#define YWQ_NETWORK_KEY_FOR_RESPONSE        @"responseObject"
#define YWQ_NETWORK_KEY_FOR_ERROR           @"error"

#define YWQ_NETWORK_KEY_FOR_POSTBYUID       @"post-%@"

@interface DBaseNetwork ()

@end

@implementation DBaseNetwork

{
    NSMutableArray *_arrSucceedBlock;
    NSMutableArray *_arrErrorBlock;
    //    BOOL _isGetRefreshToken;
    NSDictionary *_dicRefreshToken;
    DError *_error;
}

#pragma mark 根据kHttpURL初始化
-(id)initWithDefaultHttpURL
{
    self = [self initWithBaseURL:[NSURL URLWithString:kHttpURL]];
    if(!self)
    {
        return nil;
    }
    return self;
}

#pragma mark 根据kFileUrl初始化
-(id)initWithDefaultFileURL
{
    self = [self initWithBaseURL:[NSURL URLWithString:@""]];
    if(!self)
    {
        return nil;
    }
    return self;
}

#pragma mark 根据url初始化
-(id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(!self)
    {
        return nil;
    }
    _arrSucceedBlock = [NSMutableArray new];
    _arrErrorBlock = [NSMutableArray new];
    self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
    return self;
}

#pragma mark - GET
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
                onError:(ErrorBlock) errorBlock{
    if(needUUID)
    {
        paramsDic = [self addUDIDForDicParam:paramsDic];
    }
    __weak DBaseNetwork *weakSelf = self;
    
    if (needToken)
    {
        [self setTokenForHead];
        [self opGetByPath:path param:paramsDic onSucceeded:^(id responseObject) {
            ExistActionDo(succeededBlock, succeededBlock(responseObject));
        } onError:^(DError *error) {
            if([error.errorCode isEqualToString:ERRCODE0001] && KGLOBALINFOMANAGER.isLogin)
            {
                if(KGLOBALINFOMANAGER.isGetRefreshToken){
                    [self waitRefreshTokenByMethor:kHttpMethorGet path:path paramsDic:paramsDic onSucceeded:succeededBlock onError:errorBlock];
                    return;
                }
                
                [weakSelf reFreshTokenOnSucceeded:^(NSDictionary *dic) {
                    [weakSelf opGetWithUrlPath:path
                                        params:paramsDic
                                      needUUID:needUUID
                                     needToken:needToken
                                   onSucceeded:^(NSDictionary *dic) {
                                       ExistActionDo(succeededBlock, succeededBlock(dic));
                                   } onError:errorBlock];
                } onError:errorBlock];
            }
            else
            {
                ExistActionDo(errorBlock, errorBlock(error));
            }
        }];
    }
    else
    {
        [self opGetByPath:path param:paramsDic onSucceeded:^(id responseObject) {
            ExistActionDo(succeededBlock, succeededBlock(responseObject));
        } onError:errorBlock];
    }
}

-(void)opGetByPath:(NSString *)path
             param:(NSDictionary *)paramsDic
       onSucceeded:(NSObjectBlock) succeededBlock
           onError:(ErrorBlock) errorBlock{
    __weak DBaseNetwork *weakSelf = self;
    DLog(@"%@,%@",self.userInfoForCancelTask,path);
    NSURLSessionDataTask *task = [self GET:path parameters:paramsDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf proccessResponseData:responseObject task:task onSucceeded:succeededBlock onError:errorBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf proccessError:error task:task onError:errorBlock];
    }];
    
    [KGLOBALINFOMANAGER addTask:task userInfo:self.userInfoForCancelTask];
}


#pragma mark - POST
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
                 onError:(ErrorBlock) errorBlock{
    if(needUUID)
    {
        paramsDic = [self addUDIDForDicParam:paramsDic];
    }
    __weak DBaseNetwork *weakSelf = self;
    if (needToken){
        [self setTokenForHead];
        [self opPostByPath:path param:paramsDic onSucceeded:^(id responseObject) {
            ExistActionDo(succeededBlock, succeededBlock(responseObject));
        } onError:^(DError *error) {
            if([error.errorCode isEqualToString:ERRCODE0001] && KGLOBALINFOMANAGER.isLogin)
            {
                //访问密钥失效时刷新处理
                if(KGLOBALINFOMANAGER.isGetRefreshToken){
                    [self waitRefreshTokenByMethor:kHttpMethorPost path:path paramsDic:paramsDic onSucceeded:succeededBlock onError:errorBlock];
                    return;
                }
                
                [weakSelf reFreshTokenOnSucceeded:^(NSDictionary *dic) {
                    [weakSelf opPostWithUrlPath:path
                                         params:paramsDic
                                       needUUID:needUUID
                                      needToken:needToken
                                    onSucceeded:^(NSDictionary *dic) {
                                        ExistActionDo(succeededBlock, succeededBlock(dic));
                                    } onError:errorBlock];
                } onError:errorBlock];
            }
            else
            {
                ExistActionDo(errorBlock, errorBlock(error));
            }
        }];
    }
    else
    {
        [self opPostByPath:path param:paramsDic onSucceeded:^(id responseObject) {
            ExistActionDo(succeededBlock, succeededBlock(responseObject));
        } onError:errorBlock];
    }
}

-(void)opPostByPath:(NSString *)path
              param:(NSDictionary *)paramsDic
        onSucceeded:(NSObjectBlock) succeededBlock
            onError:(ErrorBlock) errorBlock
{
    __weak DBaseNetwork *weakSelf = self;
    NSURLSessionDataTask *task = [self POST:path parameters:paramsDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf proccessResponseData:responseObject task:task onSucceeded:succeededBlock onError:errorBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf proccessError:error task:task onError:errorBlock];
    }];
    
    [KGLOBALINFOMANAGER addTask:task userInfo:self.userInfoForCancelTask];
    
}

#pragma mark - PUT
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
                onError:(ErrorBlock) errorBlock{
    if(needUUID)
    {
        paramsDic = [self addUDIDForDicParam:paramsDic];
    }
    __weak DBaseNetwork *weakSelf = self;
    if (needToken){
        [self setTokenForHead];
        [self opPutByPath:path param:paramsDic onSucceeded:^(id responseObject) {
            ExistActionDo(succeededBlock, succeededBlock(responseObject));
        } onError:^(DError *error) {
            if([error.errorCode isEqualToString:ERRCODE0001] && KGLOBALINFOMANAGER.isLogin)
            {
                //访问密钥失效时刷新处理
                if(KGLOBALINFOMANAGER.isGetRefreshToken){
                    [self waitRefreshTokenByMethor:kHttpMethorPut path:path paramsDic:paramsDic onSucceeded:succeededBlock onError:errorBlock];
                    return;
                }
                [weakSelf reFreshTokenOnSucceeded:^(NSDictionary *dic) {
                    [weakSelf opPutWithUrlPath:path
                                        params:paramsDic
                                      needUUID:needUUID
                                     needToken:needToken
                                   onSucceeded:^(NSDictionary *dic) {
                                       ExistActionDo(succeededBlock, succeededBlock(dic));
                                   } onError:errorBlock];
                } onError:errorBlock];
            }
            else
            {
                ExistActionDo(errorBlock, errorBlock(error));
            }
        }];
    }
    else
    {
        [self opPutByPath:path param:paramsDic onSucceeded:^(id responseObject) {
            ExistActionDo(succeededBlock, succeededBlock(responseObject));
        } onError:errorBlock];
    }
}

-(void)opPutByPath:(NSString *)path
             param:(NSDictionary *)paramsDic
       onSucceeded:(NSDictionaryBlock) succeededBlock
           onError:(ErrorBlock) errorBlock
{
    __weak DBaseNetwork *weakSelf = self;
    NSURLSessionDataTask *task = [self PUT:path parameters:paramsDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf proccessResponseData:responseObject task:task onSucceeded:succeededBlock onError:errorBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf proccessError:error task:task onError:errorBlock];
    }];
    [KGLOBALINFOMANAGER addTask:task userInfo:self.userInfoForCancelTask];
}

#pragma mark - DELETE
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
                   onError:(ErrorBlock) errorBlock{
    if(needUUID)
    {
        paramsDic = [self addUDIDForDicParam:paramsDic];
    }
    __weak DBaseNetwork *weakSelf = self;
    if (needToken){
        [self setTokenForHead];
        [self opDeleteByPath:path param:paramsDic onSucceeded:^(id responseObject) {
            ExistActionDo(succeededBlock, succeededBlock(responseObject));
        } onError:^(DError *error) {
            if([error.errorCode isEqualToString:ERRCODE0001] && KGLOBALINFOMANAGER.isLogin)
            {
                //访问密钥失效时刷新处理
                if(KGLOBALINFOMANAGER.isGetRefreshToken){
                    [self waitRefreshTokenByMethor:kHttpMethorDelete path:path paramsDic:paramsDic onSucceeded:succeededBlock onError:errorBlock];
                    return;
                }
                
                [weakSelf reFreshTokenOnSucceeded:^(NSDictionary *dic) {
                    [weakSelf opDeleteWithUrlPath:path
                                           params:paramsDic
                                         needUUID:needUUID
                                        needToken:needToken
                                      onSucceeded:^(NSDictionary *dic) {
                                          ExistActionDo(succeededBlock, succeededBlock(dic));
                                      } onError:errorBlock];
                } onError:errorBlock];
            }
            else
            {
                ExistActionDo(errorBlock, errorBlock(error));
            }
        }];
    }
    else
    {
        [self opDeleteByPath:path param:paramsDic onSucceeded:^(id responseObject) {
            ExistActionDo(succeededBlock, succeededBlock(responseObject));
        } onError:errorBlock];
    }
}

-(void)opDeleteByPath:(NSString *)path
                param:(NSDictionary *)paramsDic
          onSucceeded:(NSDictionaryBlock) succeededBlock
              onError:(ErrorBlock) errorBlock
{
    __weak DBaseNetwork *weakSelf = self;
    NSURLSessionDataTask *task = [self DELETE:path parameters:paramsDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf proccessResponseData:responseObject task:task onSucceeded:succeededBlock onError:errorBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf proccessError:error task:task onError:errorBlock];
    }];
    [KGLOBALINFOMANAGER addTask:task userInfo:self.userInfoForCancelTask];
}


#pragma mark - 私有方法
- (void)proccessResponseData:(id)responseObject
                        task:(NSURLSessionDataTask *)task
                 onSucceeded:(NSObjectBlock) succeededBlock
                     onError:(ErrorBlock) errorBlock{
    [KGLOBALINFOMANAGER removeTask:task userInfo:self.userInfoForCancelTask];
    
//    [self saveCookies];
    if(responseObject){
        //返回结果
        ExistActionDo(succeededBlock, succeededBlock(responseObject));
    } else {
        //返回结果
        ExistActionDo(succeededBlock, succeededBlock(@{@"success":@(YES)}));
    }
}


- (void)proccessError:(NSError * _Nonnull)error
                 task:(NSURLSessionDataTask *)task
              onError:(ErrorBlock) errorBlock{
    [KGLOBALINFOMANAGER removeTask:task userInfo:self.userInfoForCancelTask];
    if ([error code] != NSURLErrorCancelled) {
        DError *customError=[[DError alloc] initWithCode:error.code
                                               description:error.localizedDescription];
        ExistActionDo(errorBlock, errorBlock(customError));
    }
}

- (void)waitRefreshTokenByMethor:(NSString *)methor
                            path:(NSString *)path
                       paramsDic:(NSDictionary *)paramsDic
                     onSucceeded:(NSDictionaryBlock) succeededBlock
                         onError:(ErrorBlock) errorBlock{
    __weak DBaseNetwork *weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        while (KGLOBALINFOMANAGER.isGetRefreshToken) {
            [NSThread sleepForTimeInterval:1.0];
        }
        [weakSelf setTokenForHead];
        if([methor isEqualToString:kHttpMethorGet]){
            [weakSelf opGetByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
                ExistActionDo(succeededBlock, succeededBlock(dic));
            } onError:^(DError *error) {
                if([error.errorCode isEqualToString:ERRCODE0001] && KGLOBALINFOMANAGER.isLogin)
                {
                    if(KGLOBALINFOMANAGER.isGetRefreshToken){
                        [self waitRefreshTokenByMethor:kHttpMethorGet path:path paramsDic:paramsDic onSucceeded:succeededBlock onError:errorBlock];
                        return;
                    }
                    
                    BOOL needUUID = NO;
                    NSString *uuid = @"";
                    
                    DicHasKeyAndDo(paramsDic, kParamUUID, uuid = [paramsDic objectForKey:kParamUUID];);
                    if(uuid.length > 0){
                        needUUID = YES;
                    }
                    
                    [weakSelf reFreshTokenOnSucceeded:^(NSDictionary *dic) {
                        [weakSelf opGetWithUrlPath:path
                                            params:paramsDic
                                          needUUID:needUUID
                                         needToken:YES
                                       onSucceeded:^(NSDictionary *dic) {
                                           ExistActionDo(succeededBlock, succeededBlock(dic));
                                       } onError:errorBlock];
                    } onError:errorBlock];
                }
                else
                {
                    ExistActionDo(errorBlock, errorBlock(error));
                }
            }];
        }
        else if([methor isEqualToString:kHttpMethorPost]){
            [weakSelf opPostByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
                ExistActionDo(succeededBlock, succeededBlock(dic));
            } onError:errorBlock];
        }
        else if([methor isEqualToString:kHttpMethorPut]){
            [weakSelf opPutByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
                ExistActionDo(succeededBlock, succeededBlock(dic));
            } onError:errorBlock];
        }
        else if([methor isEqualToString:kHttpMethorDelete]){
            [weakSelf opDeleteByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
                ExistActionDo(succeededBlock, succeededBlock(dic));
            } onError:errorBlock];
        }
    });
}



- (void)setTokenForHead{
    NSString *strToken = [self.accessToken copy];
    DOAuthAccountModel *model = [DOAuthAccountTool account];
    if(strToken.length == 0){
        strToken = model.access_token;
    }
    
    [self.requestSerializer setValue:[NSString stringWithFormat:@"%@ %@", model.token_type, strToken] forHTTPHeaderField:@"Authorization"];
    [self.requestSerializer setValue:@"v1" forHTTPHeaderField:@"Accept-Versions"];
    
}


-(NSDictionary *)addUDIDForDicParam:(NSDictionary *)dicParam
{
    
    NSString *UDID = ExistStringGet(kAPPDELEGATE.deviceId);
    
    if (!dicParam) {
        dicParam =[NSDictionary dictionaryWithObject:UDID forKey:kParamUUID];
    }else{
        NSMutableDictionary *dicWithToken=[NSMutableDictionary dictionaryWithDictionary:dicParam];
        [dicWithToken setValue:UDID forKey:kParamUUID];
        dicParam=dicWithToken;
    }
    return dicParam;
}

-(NSDictionary *)addAccessTokenForDicParam:(NSDictionary *)dicParam
{
    if (dicParam == nil) {
        dicParam = @{kParamAccessToken:ExistStringGet(self.accessToken)};
    }else{
        NSMutableDictionary *dicWithToken=[NSMutableDictionary dictionaryWithDictionary:dicParam];
        [dicWithToken setValue:ExistStringGet(self.accessToken) forKey:kParamAccessToken];
        dicParam=dicWithToken;
    }
    return dicParam;
}

-(void)saveCookies
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSData *dataCookies = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dataCookies forKey:@"cookies"];
    [userDefaults synchronize];
}

-(void)setUserDefaultByDicData:(NSDictionary *)dicData
{
    if([dicData objectForKey:kParamUid] && [dicData objectForKey:kParamUid] != kNull){
        [KGLOBALINFOMANAGER setUid:[dicData objectForKey:kParamUid]];
    }
    if([dicData objectForKey:kParamAccessToken] && [dicData objectForKey:kParamAccessToken] != kNull){
        [KGLOBALINFOMANAGER setAccessToken:[dicData objectForKey:kParamAccessToken]];
    }
    if([dicData objectForKey:kParamRefreshToken] && [dicData objectForKey:kParamRefreshToken] != kNull){
        [KGLOBALINFOMANAGER setRefreshToken:[dicData objectForKey:kParamRefreshToken]];
    }
}

-(void)clearUserToken
{
    [KGLOBALINFOMANAGER clearAccessToken];
}

- (void)clearRefreshTokenBlockCache{
    [_arrSucceedBlock removeAllObjects];
    [_arrErrorBlock removeAllObjects];
}

#pragma mark 处理网络缓存
- (BOOL)proccessCacheDataByKey:(NSString *)key
                succeededBlock:(NSDictionaryForCacheBlock)succeededBlock{
//    NSData *data = (NSData *)[TGCacheManager getTGObjectForKey:key];
//    if(data.length > 0)
//    {
//        NSDictionary *dicUser = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        ExistActionDo(succeededBlock, succeededBlock(dicUser,YES));
//        return YES;
//    }
    return NO;
}

- (void)saveCacheDataByDic:(NSDictionary *)dic
                  cacheKey:(NSString *)cacheKey{
    [self saveCacheDataByDic:dic cacheKey:cacheKey cacheTime:kCacheTimeForOneDay];
}

- (void)saveCacheDataByDic:(NSDictionary *)dic
                  cacheKey:(NSString *)cacheKey
                 cacheTime:(NSTimeInterval)cacheTime{
//    NSData *dataUser = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
//    [TGCacheManager setTGObjectByData:dataUser forKey:cacheKey withTimeoutInterval:cacheTime];
}

#pragma mark 刷新token
-(void)reFreshTokenOnSucceeded:(NSDictionaryBlock)succeededBlock
                       onError:(ErrorBlock)errorBlock
{
    
}



#pragma mark - get & set
-(NSString *)accessToken
{
    return KGLOBALINFOMANAGER.accessToken;
}

-(NSString *)refreshToken
{
    return KGLOBALINFOMANAGER.refreshToken;
}

-(NSString *)userId
{
    return KGLOBALINFOMANAGER.uid;
}

-(NSString *)UDID
{
    NSString *udid = [OpenUDID value];
    
    return udid;
}



@end
