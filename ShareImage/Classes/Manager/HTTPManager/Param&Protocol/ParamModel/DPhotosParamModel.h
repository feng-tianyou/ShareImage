//
//  DPhotosParamModel.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPhotosParamProtocol.h"

@interface DPhotosParamModel : NSObject<DPhotosParamProtocol>
// 页数，默认1
@property (nonatomic, assign) NSInteger page;
// 每页多少条，默认10
@property (nonatomic, assign) NSInteger per_page;
// 排序：(Valid values: latest, oldest, popular; default: latest)
@property (nonatomic, copy) NSString *order_by;

@end
