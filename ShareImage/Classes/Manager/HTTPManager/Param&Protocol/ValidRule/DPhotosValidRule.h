//
//  DPhotosValidRule.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPhotosParamProtocol.h"

@interface DPhotosValidRule : NSObject

+ (NSString *)checkParamIsValidForGetPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel;

+ (NSString *)checkParamIsValidForGetPhotoStatsByParamModel:(id<DPhotosParamProtocol>)paramModel;

@end
