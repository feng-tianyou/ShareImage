//
//  DPhotosValidRule.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotosValidRule.h"
//#import "DPhotosParamModel.h"

@implementation DPhotosValidRule

+ (NSString *)checkParamIsValidForGetPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel{
    if (paramModel.pid) {
        return @"图片的ID必须有";
    }
    return @"";
}

@end
