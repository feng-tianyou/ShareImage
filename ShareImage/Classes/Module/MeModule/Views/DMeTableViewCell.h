//
//  DMeTableViewCell.h
//  ShareImage
//
//  Created by FTY on 2017/3/10.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPhotosModel;
@interface DMeTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DPhotosModel *photosModel;


@end
