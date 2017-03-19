//
//  DHomeTableViewCell.h
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPhotosModel;
@interface DHomeTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DPhotosModel *photosModel;
@property (nonatomic, copy) VoidBlock clickIconBlock;
@property (nonatomic, copy) VoidBlock clickLikeBlock;

@end
