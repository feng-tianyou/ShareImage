//
//  DPhotoDetailController.h
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseViewController.h"
@class DPhotosModel;
@interface DPhotoDetailController : DBaseViewController

- (instancetype)initWithPhotoModel:(DPhotosModel *)photoModel;

- (instancetype)initWithPhotoModels:(NSArray<DPhotosModel *> *)photoModels;

@end
