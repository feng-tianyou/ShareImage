//
//  DUserListViewCell.h
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DUserListViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DUserModel *userModel;

@end
