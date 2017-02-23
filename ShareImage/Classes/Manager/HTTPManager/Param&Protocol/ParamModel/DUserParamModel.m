//
//  DUserParamModel.m
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DUserParamModel.h"

@implementation DUserParamModel


- (NSDictionary *)getParamDicForPostUser{
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    if (self.username.length > 0) {
        [result setObject:self.username forKey:@"username"];
    }
    if (self.first_name.length > 0) {
        [result setObject:self.first_name forKey:@"first_name"];
    }
    if (self.last_name.length > 0) {
        [result setObject:self.last_name forKey:@"last_name"];
    }
    if (self.email.length > 0) {
        [result setObject:self.email forKey:@"email"];
    }
    if (self.url.length > 0) {
        [result setObject:self.url forKey:@"url"];
    }
    if (self.location.length > 0) {
        [result setObject:self.location forKey:@"location"];
    }
    if (self.bio.length > 0) {
        [result setObject:self.bio forKey:@"bio"];
    }
    if (self.instagram_username.length > 0) {
        [result setObject:self.instagram_username forKey:@"instagram_username"];
    }
    return result;
}


- (NSDictionary *)getParamDicForGetUserPhotos{
    self.page = self.page > 0 ? self.page : 1;
    self.per_page = self.per_page > 0 ? self.per_page : 10;
    self.order_by = self.order_by.length > 0 ? self.order_by : @"latest";
    return @{@"username":ExistStringGet(self.username),
             @"page":@(self.page),
             @"per_page":@(self.per_page),
             @"order_by":ExistStringGet(self.order_by)};
}

@end
