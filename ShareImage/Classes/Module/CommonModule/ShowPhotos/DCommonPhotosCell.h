//
//  DCommonPhotosCell.h
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPhotosModel;
@interface DCommonPhotosCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) DPhotosModel *photoModel;

@end
