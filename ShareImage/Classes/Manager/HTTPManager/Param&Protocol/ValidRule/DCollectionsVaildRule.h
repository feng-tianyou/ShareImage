//
//  DCollectionsVaildRule.h
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCollectionParamProtocol.h"

@interface DCollectionsVaildRule : NSObject

+ (NSString *)checkCollectionIDByParamModel:(id<DCollectionParamProtocol>)paramModel;

+ (NSString *)checkCreateCollectionByParamModel:(id<DCollectionParamProtocol>)paramModel;

@end
