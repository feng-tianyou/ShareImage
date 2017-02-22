//
//  DCollectionsVaildRule.m
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionsVaildRule.h"

@implementation DCollectionsVaildRule
+ (NSString *)checkCollectionIDByParamModel:(id<DCollectionParamProtocol>)paramModel{
    if (paramModel.collection_id == 0) {
        return @"分类的ID必须有";
    }
    return @"";
}
@end
