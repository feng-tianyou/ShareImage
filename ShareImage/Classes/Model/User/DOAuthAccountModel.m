//
//  DOAuthAccountModel.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DOAuthAccountModel.h"

@implementation DOAuthAccountModel

// 归档
- (instancetype)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@""];
        self.created_at = [decoder decodeInt64ForKey:@"created_at"];
        self.refresh_token = [decoder decodeObjectForKey:@"refresh_token"];
        self.scope = [decoder decodeObjectForKey:@"scope"];
        self.token_type = [decoder decodeObjectForKey:@"token_type"];
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeInt64:self.created_at forKey:@"created_at"];
    [encoder encodeObject:self.refresh_token forKey:@"refresh_token"];
    [encoder encodeObject:self.scope forKey:@"scope"];
    [encoder encodeObject:self.token_type forKey:@"token_type"];
    [encoder encodeObject:self.expiresTime forKey:@"expiresTime"];
}

@end
