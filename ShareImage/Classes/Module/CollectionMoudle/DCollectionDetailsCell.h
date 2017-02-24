//
//  DCollectionDetailsCell.h
//  ShareImage
//
//  Created by FTY on 2017/2/24.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPhotosModel;
@interface DCollectionDetailsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DPhotosModel *photosModel;
@property (nonatomic, copy) VoidBlock clickIconBlock;

@end
