//
//  DOAuthParamProtocol.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DOAuthParamProtocol <NSObject>

@property (nonatomic, copy) NSString *client_id;
@property (nonatomic, copy) NSString *client_secret;
@property (nonatomic, copy) NSString *redirect_uri;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *grant_type;


- (NSDictionary *)getParamDicForOAuthAccount;

@end
