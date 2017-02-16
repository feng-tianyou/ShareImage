//
//  DBaseManager.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//  manager请求类，所有请求manager都继承DBaseManager

#import <Foundation/Foundation.h>
#import "DBaseManagerProtocol.h"

@class DJsonModel;
@protocol DBaseManagerProtocol;

@interface DBaseManager : NSObject

@property (nonatomic, strong) id service;
@property (nonatomic, weak) id<DBaseManagerProtocol> delegate;
@property (nonatomic, strong) NSMutableDictionary *info;

+ (id)getHTTPManagerByDelegate:(id<DBaseManagerProtocol>)delegate info:(NSMutableDictionary *)info;

- (void)addLoadingView;

- (void)removeLoadingView;

- (BOOL)needExecuteClearAndHasNoDataOperationByStart:(NSInteger)start
                                             arrData:(NSArray *)arrData;

- (void)hasNotMoreData;

- (void)requestServiceSucceedByUserInfo;

- (void)requestServiceSucceedBackBool:(BOOL)isTrue;

- (void)requestServiceSucceedBackString:(NSString *)strData;

- (void)requestServiceSucceedBackLongLongValue:(long long)identityId;

- (void)requestServiceSucceedBackArray:(NSArray *)arrData;

- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)model;

- (void)requestServiceSucceedBackErrorType:(ErrorType)errorType;

- (void)requestServiceSucceedBackErrorType:(ErrorType)errorType result:(id)result;

- (void)localError:(NSString *)text;

- (void)localErrorFor2Second:(NSString *)text;

- (void)localErrorAndUnlockUI:(NSString *)text;

- (void)proccessLocalErrorByText:(NSString *)text;

- (void)proccessNetwordError:(DError *)error;



@end
