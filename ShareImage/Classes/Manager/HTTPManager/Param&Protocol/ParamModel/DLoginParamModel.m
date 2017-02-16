//
//  DLoginParamModel.m
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DLoginParamModel.h"

@implementation DLoginParamModel


- (NSDictionary *)getParamDicForGetToken{
    NSString *version = @"";
    //2.请求网络新数据
    NSDictionary *dicParam = @{kParamUserName:ExistStringGet(self.userNo),
                               kParamPassword:ExistStringGet(self.password),
                               kParamRefreshToken:ExistStringGet(self.refreshToken),
                               kParamDeviceId:ExistStringGet(kAPPDELEGATE.deviceId),
                               kParamVersions:ExistStringGet(version)};
    if(KGLOBALINFOMANAGER.deviceToken.length > 0){
        dicParam = @{kParamUserName:ExistStringGet(self.userNo),
                     kParamPassword:ExistStringGet(self.password),
                     kParamRefreshToken:ExistStringGet(self.refreshToken),
                     kParamDeviceToken:KGLOBALINFOMANAGER.deviceToken,
                     kParamDeviceId:ExistStringGet(kAPPDELEGATE.deviceId),
                     kParamVersions:ExistStringGet(version)};
    }
    return dicParam;
}

- (NSDictionary *)getParamDicForPostVerifyCode{
    return @{kParamMobile:ExistStringGet(self.mobile),
             kParamType:@(self.type)};
}

- (NSDictionary *)getParamDicForPostTokenActual{
    return @{kParamName:ExistStringGet(self.actualName),
             kParamCompany:ExistStringGet(self.company)};
}

- (NSDictionary *)getParamDicForGetTokenVerify{
    return @{kParamMobile:ExistStringGet(self.mobile)};
}


- (NSDictionary *)getParamDicForPostAccount{
    return @{kParamCode:ExistStringGet(self.code),
             kParamPassword:ExistStringGet(self.password),
             kParamName:ExistStringGet(self.actualName),
             kParamCompany:ExistStringGet(self.company)};
}



@end
