//
//  DSearchViewCell.h
//  ShareImage
//
//  Created by FTY on 2017/3/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPhotosModel, DCollectionsModel;
@interface DSearchViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DUserModel *userModel;
@property (nonatomic, strong) DPhotosModel *photoModel;
@property (nonatomic, strong) DCollectionsModel *collectionModel;

@property (nonatomic, assign) SearchType searchType;


@end
