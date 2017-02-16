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

-(void)opGetWithUrlPath:(NSString *)path
                 params:(NSDictionary *)paramsDic
               needUUID:(BOOL)needUUID
              needToken:(BOOL)needToken
            onSucceeded:(NSDictionaryBlock) succeededBlock
                onError:(ErrorBlock) errorBlock{
    if(needUUID)
    {
        paramsDic = [self addUDIDForDicParam:paramsDic];
    }
    __weak DBaseNetwork *weakSelf = self;
    
    if (needToken)
    {
        [self setTokenForHead];
        [self opGetByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
            [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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
                                       [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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
        [self opGetByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
            [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
        } onError:errorBlock];
    }
}

-(void)opGetByPath:(NSString *)path
             param:(NSDictionary *)paramsDic
       onSucceeded:(NSDictionaryBlock) succeededBlock
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

-(void)opPostWithUrlPath:(NSString *)path
                  params:(NSDictionary *)paramsDic
                needUUID:(BOOL)needUUID
               needToken:(BOOL)needToken
             onSucceeded:(NSDictionaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock{
    if(needUUID)
    {
        paramsDic = [self addUDIDForDicParam:paramsDic];
    }
    __weak DBaseNetwork *weakSelf = self;
    if (needToken){
        [self setTokenForHead];
        [self opPostByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
            [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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
                                        [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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
        [self opPostByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
            [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
        } onError:errorBlock];
    }
}

-(void)opPostByPath:(NSString *)path
              param:(NSDictionary *)paramsDic
        onSucceeded:(NSDictionaryBlock) succeededBlock
            onError:(ErrorBlock) errorBlock
{
    __weak DBaseNetwork *weakSelf = self;
    if(paramsDic != nil){
//        NSString *strKey = [NSString stringWithFormat:YWQ_NETWORK_KEY_FOR_POSTBYUID,self.userId];
        
//        NSString *strParam = (NSString *)[TGCacheManager getTGObjectForKey:strKey];
//        NSString *strNewParam = [ZKBTools getStrJsonByDic:paramsDic];
//        if(strParam.length > 0 && [strParam isEqualToString:strNewParam]){
//            return;
//        }
//        DLog(@"%@",strNewParam);
//        [TGCacheManager setTGObjectByData:strNewParam forKey:strKey];
    }
//    NSURLSessionDataTask *task = [self POST:path parameters:paramsDic success:^(NSURLSessionDataTask *task, id responseObject) {
////        NSString *strKey = [NSString stringWithFormat:YWQ_NETWORK_KEY_FOR_POSTBYUID,self.userId];
//        //        [TGCacheManager setTGObjectByData:nil forKey:strKey];
//        [weakSelf proccessResponseData:responseObject task:task onSucceeded:succeededBlock onError:errorBlock];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
////        NSString *strKey = [NSString stringWithFormat:YWQ_NETWORK_KEY_FOR_POSTBYUID,self.userId];
//        //        [TGCacheManager setTGObjectByData:nil forKey:strKey];
//        [weakSelf proccessError:error task:task onError:errorBlock];
//    }];
    NSURLSessionDataTask *task = [self POST:path parameters:paramsDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf proccessResponseData:responseObject task:task onSucceeded:succeededBlock onError:errorBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf proccessError:error task:task onError:errorBlock];
    }];
    
    [KGLOBALINFOMANAGER addTask:task userInfo:self.userInfoForCancelTask];
    
}

-(void)opPutWithUrlPath:(NSString *)path
                 params:(NSDictionary *)paramsDic
               needUUID:(BOOL)needUUID
              needToken:(BOOL)needToken
            onSucceeded:(NSDictionaryBlock) succeededBlock
                onError:(ErrorBlock) errorBlock{
    if(needUUID)
    {
        paramsDic = [self addUDIDForDicParam:paramsDic];
    }
    __weak DBaseNetwork *weakSelf = self;
    if (needToken){
        [self setTokenForHead];
        [self opPutByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
            [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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
                                       [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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
        [self opPutByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
            [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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


-(void)opDeleteWithUrlPath:(NSString *)path
                    params:(NSDictionary *)paramsDic
                  needUUID:(BOOL)needUUID
                 needToken:(BOOL)needToken
               onSucceeded:(NSDictionaryBlock) succeededBlock
                   onError:(ErrorBlock) errorBlock{
    if(needUUID)
    {
        paramsDic = [self addUDIDForDicParam:paramsDic];
    }
    __weak DBaseNetwork *weakSelf = self;
    if (needToken){
        [self setTokenForHead];
        [self opDeleteByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
            [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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
                                          [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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
        [self opDeleteByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
            [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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

- (void)proccessResponseData:(id)responseObject
                        task:(NSURLSessionDataTask *)task
                 onSucceeded:(NSDictionaryBlock) succeededBlock
                     onError:(ErrorBlock) errorBlock{
    [KGLOBALINFOMANAGER removeTask:task userInfo:self.userInfoForCancelTask];
    id result=[self handleResponseData:responseObject];
    [self saveCookies];
    if ([result isKindOfClass:[DError class]]
        && ![[(DError *)result errorCode] isEqualToString:@"3840"]) {
        ExistActionDo(errorBlock, errorBlock(result));
        return;
    }else if([result isKindOfClass:[NSDictionary class]]){
        //返回验证结果
        ExistActionDo(succeededBlock, succeededBlock(result));
    }
    else if(responseObject){
        //返回字符串结果
        ExistActionDo(succeededBlock, succeededBlock((NSDictionary *)responseObject));
    }
    else{
        DError *customError=[[DError alloc] initWithCode:10005 description:nil];
        ExistActionDo(errorBlock, errorBlock(customError));
    }
}

- (void)proccessSucceedBlockByDic:(NSDictionary *)dic
                   succeededBlock:(NSDictionaryBlock)succeededBlock
                          onError:(ErrorBlock) errorBlock{
    if(HTTPSTATECODESUCCESS){
        ExistActionDo(succeededBlock, succeededBlock(dic));
    }
    else{
        DError *customError=[[DError alloc] initWithCode:10005 description:nil];
        ExistActionDo(errorBlock, errorBlock(customError));
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
                [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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
                                           [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
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
                [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
            } onError:errorBlock];
        }
        else if([methor isEqualToString:kHttpMethorPut]){
            [weakSelf opPutByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
                [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
            } onError:errorBlock];
        }
        else if([methor isEqualToString:kHttpMethorDelete]){
            [weakSelf opDeleteByPath:path param:paramsDic onSucceeded:^(NSDictionary *dic) {
                [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
            } onError:errorBlock];
        }
    });
}

#pragma mark 处理返回得数据
-(id)handleResponseData:(NSData *)data
{
    DError *error = nil;
    if([[data class] isSubclassOfClass:[NSDictionary class]]){
        id responseDic = data;
        if([responseDic objectForKey:@"state_code"]
           && ![[responseDic objectForKey:@"state_code"] isEqualToString:kSuccessHttp])
        {
            error = [[DError alloc] initWithDictionary:responseDic];
            return error;
        }
        return responseDic;
    }
    if(data)
    {
        NSError *err = nil;
        id responseDic = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableLeaves
                                                           error:&err];
        //        NSJSONReadingMutableContainers = (1UL << 0),  可添加新成员
        //        NSJSONReadingMutableLeaves = (1UL << 1),      返回对象是未知的
        //        NSJSONReadingAllowFragments = (1UL << 2)      不能再修改
        if(err)
        {
            error = [[DError alloc] initWithCode:err.code description:err.description];
            return error;
        }
        else if([responseDic objectForKey:@"state_code"]
                && ![[responseDic objectForKey:@"state_code"] isEqualToString:kSuccessHttp])
        {
            error = [[DError alloc] initWithDictionary:responseDic];
            return error;
        }
        else
        {
            return responseDic;
        }
    }
    return error;
}


- (void)setTokenForHead{
    NSString *strToken = [self.accessToken copy];
    if(strToken.length == 0){
        strToken = @"9ff3e9d525ac18e96f2e02c440d57bae";
    }
    
    [self.requestSerializer setValue:strToken forHTTPHeaderField:@"Authorize"];
    [self.requestSerializer setValue:@"2016-04-18" forHTTPHeaderField:@"Versions"];
    
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
        [KGLOBALINFOMANAGER setUid:[[dicData objectForKey:kParamUid] longLongValue]];
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
    DLog(@"refresh token");
    KGLOBALINFOMANAGER.isGetRefreshToken = YES;
    NSString *refreshToken = @"";
    [self clearUserToken];
    if(self.refreshToken && self.refreshToken.length > 0){
        refreshToken = self.refreshToken;
    }
    NSDictionary *dicParam = @{kParamRefreshToken:refreshToken};
    if(KGLOBALINFOMANAGER.deviceToken && KGLOBALINFOMANAGER.deviceToken.length > 0){
        dicParam = @{kParamRefreshToken:refreshToken,kParamDeviceToken:KGLOBALINFOMANAGER.deviceToken};
    }
    __weak DBaseNetwork *weakSelf = self;
    [self opGetWithUrlPath:kPathToken
                    params:dicParam
                  needUUID:YES
                 needToken:NO
               onSucceeded:^(NSDictionary *dic) {
                   NSDictionary *dicData = [dic objectForKey:@"data"];
                   [self setUserDefaultByDicData:dicData];
                   [weakSelf proccessSucceedBlockByDic:dic succeededBlock:succeededBlock onError:errorBlock];
                   _dicRefreshToken = dic;
                   _error = nil;
                   KGLOBALINFOMANAGER.isGetRefreshToken = NO;
                   
               } onError:^(DError *error) {
                   ExistActionDo(errorBlock, errorBlock(error));
                   int errorCode = [DErrorRespone getErrorCodeByError:error];
                   switch (errorCode) {
                       case 1:
                       case 10003:
                       case 10009:{
                           LogoutType type = 0;
                           switch (errorCode) {
                               case 10003:{
                                   type = LogoutTypeForNoVerifyCode;
                                   break;
                               }
                               case 1:
                               case 10009:{
                                   type = LogoutTypeForNoValid;
                                   break;
                               }
                           }
                           if(type > 0){
                               [_arrSucceedBlock removeAllObjects];
                               [_arrErrorBlock removeAllObjects];
//                               [TGCacheManager setTGObjectByData:nil forKey:ZKBVIEW_KEY_LOGOUT];
                           }
                           KGLOBALINFOMANAGER.isGetRefreshToken = NO;
                           return;
                       }
                   }
                   
                   _error = error;
                   _dicRefreshToken = nil;
                   KGLOBALINFOMANAGER.isGetRefreshToken = NO;
               }];
}

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
    return [NSString stringWithFormat:@"%@",@(KGLOBALINFOMANAGER.uid)];
}

-(NSString *)UDID
{
    NSString *udid = [OpenUDID value];
    
    return udid;
}

-(NSArray *)proccessArrData:(NSArray *)arr
{
    if(arr && arr.count > 0)
    {
        return arr;
    }
    return @[];
}

#pragma mark 数组转换成json
-(NSString *)arrDataToJson:(NSArray *)arr
{
    if(arr && arr.count > 0)
    {
        id result = [NSJSONSerialization dataWithJSONObject:arr options:kNilOptions error:nil];
        NSString *str = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        return str;
    }
    return @"[]";
}


@end
