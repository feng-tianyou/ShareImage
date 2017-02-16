//
//  DLoginParamModel.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/26.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLoginParamProtocol.h"

@interface DLoginParamModel : NSObject<DLoginParamProtocol>

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



@end
