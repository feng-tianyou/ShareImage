//
//  DBaseService.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DBaseService : NSObject

@property (nonatomic, strong) id network;

@property (nonatomic, strong) NSMutableDictionary *info;



+ (id)getServiceByInfo:(NSMutableDictionary *)info;

- (long long)getLongLongValueByDic:(NSDictionary *)dic key:(NSString *)key;

- (BOOL)getBoolValueByDic:(NSDictionary *)dic key:(NSString *)key;

- (id)getValueByDic:(NSDictionary *)dic key:(NSString *)key;

- (BOOL)needReturnForRepeatSendByDicParam:(NSDictionary *)dicParam
                                      key:(NSString *)key;

@end
