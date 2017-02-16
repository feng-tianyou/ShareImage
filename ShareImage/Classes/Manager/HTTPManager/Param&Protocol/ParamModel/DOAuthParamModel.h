//
//  DOAuthParamModel.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOAuthParamProtocol.h"

@interface DOAuthParamModel : NSObject<DOAuthParamProtocol>

@property (nonatomic, copy) NSString *client_id;
@property (nonatomic, copy) NSString *client_secret;
@property (nonatomic, copy) NSString *redirect_uri;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *grant_type;

@end
