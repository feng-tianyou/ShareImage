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

+ (NSString *)checkPhotoIDByParamModel:(id<DPhotosParamProtocol>)paramModel;


+ (NSString *)checkSearchPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel;

@end
