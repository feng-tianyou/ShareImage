//
//  DPhotosParamModel.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotosParamModel.h"

@implementation DPhotosParamModel

#pragma mark - 获取参数
- (NSDictionary *)getParamDicForGetPhotos{
    return @{@"page":@(self.page),
             @"per_page":@(self.per_page),
             @"order_by":ExistStringGet(self.order_by)};
}

- (NSDictionary *)getParamDicForGetPhoto{
    return @{@"id":ExistStringGet(self.pid),
             @"w":@(self.width),
             @"h":@(self.height),
             @"rect":ExistStringGet(self.rect),};
}

@end
