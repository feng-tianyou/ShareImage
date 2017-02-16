//
//  DOAuthAccountModel.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DJsonModel.h"

@interface DOAuthAccountModel : DJsonModel<NSCoding>

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) long long created_at;
@property (nonatomic, copy) NSString *refresh_token;
@property (nonatomic, copy) NSString *token_type;
@property (nonatomic, copy) NSString *scope;

@end
