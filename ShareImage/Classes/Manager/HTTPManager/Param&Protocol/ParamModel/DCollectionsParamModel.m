//
//  DCollectionsParamModel.m
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionsParamModel.h"

@implementation DCollectionsParamModel

#pragma mark - collections
- (NSDictionary *)getParamDicForGetCollections{
    self.page = self.page > 0 ? self.page : 1;
    self.per_page = self.per_page > 0 ? self.per_page : 10;
    return @{@"page":@(self.page),
             @"per_page":@(self.per_page)};
}


- (NSDictionary *)getParamDicForPostCollection{
    return @{@"title":ExistStringGet(self.title),
             @"description":ExistStringGet(self.description_c),
             @"private":@(self.isPrivate)};
}

@end
