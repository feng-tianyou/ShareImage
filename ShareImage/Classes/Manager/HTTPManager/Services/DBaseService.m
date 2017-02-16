//
//  DBaseService.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseService.h"
#import "DNetworkFactory.h"
#import "DBaseNetwork.h"
#import "DCacheManager.h"
#import "NSObject+YYModel.h"

@implementation DBaseService

+ (id)getServiceByInfo:(NSMutableDictionary *)info{
    DBaseService *baseService = [[self alloc] init];
    baseService.info = info;
    return baseService;
}

- (id)network{
    if(!_network){
        _network = [DNetworkFactory getNetworkByService:self];
    }
    [(DBaseNetwork *)_network setUserInfoForCancelTask:self.info];
    return _network;
}

- (long long)getLongLongValueByDic:(NSDictionary *)dic key:(NSString *)key{
    NSDictionary *dicData = [dic objectForKey:kParamData];
    long long value = 0;
    DicHasKeyAndDo(dicData, key, value = [[dicData objectForKey:key] longLongValue];)
    return value;
}

- (BOOL)getBoolValueByDic:(NSDictionary *)dic key:(NSString *)key{
    NSDictionary *dicData = [dic objectForKey:kParamData];
    BOOL value = NO;
    DicHasKeyAndDo(dicData, key, value = [[dicData objectForKey:key] boolValue];)
    return value;
}

- (id)getValueByDic:(NSDictionary *)dic key:(NSString *)key{
    NSDictionary *dicData = [dic objectForKey:kParamData];
    id value = nil;
    DicHasKeyAndDo(dicData, key, value = [dicData objectForKey:key];)
    return value;
}

- (BOOL)needReturnForRepeatSendByDicParam:(NSDictionary *)dicParam
                                      key:(NSString *)key{
    NSString *strParam = (NSString *)[DCacheManager getCacheObjectForKey:key];
    NSString *strNewParam = [dicParam modelToJSONString];
    if(strParam.length > 0 && [strParam isEqualToString:strNewParam]){
        return YES;
    }
    [DCacheManager setCacheObjectByData:strNewParam forKey:key];
    return NO;
}


@end
