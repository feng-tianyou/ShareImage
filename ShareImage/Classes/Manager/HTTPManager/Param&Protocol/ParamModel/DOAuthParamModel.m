//
//  DOAuthParamModel.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DOAuthParamModel.h"

@implementation DOAuthParamModel

- (NSDictionary *)getParamDicForOAuthAccount{
    return @{@"client_id":self.client_id,
             @"client_secret":self.client_secret,
             @"redirect_uri":self.redirect_uri,
             @"code":self.code,
             @"grant_type":self.grant_type,};
}

@end
