//
//  DLoginParamProtocol.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DLoginParamProtocol <NSObject>

#pragma mark - 请求所有的参数变量（必须与DLoginParamModel的变量一致）
@property (nonatomic, copy) NSString *userNo;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *actualName;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *checkPassword;
@property (nonatomic, copy) NSString *oldPassword;
@property (nonatomic, copy) NSString *theNewPassword;

#pragma mark - 代理方法，交给DLoginParamModel实现获取对应的请求参数
- (NSDictionary *)getParamDicForGetToken;

- (NSDictionary *)getParamDicForPostVerifyCode;

- (NSDictionary *)getParamDicForPostTokenActual;

- (NSDictionary *)getParamDicForGetTokenVerify;

- (NSDictionary *)getParamDicForPostAccount;

@end
