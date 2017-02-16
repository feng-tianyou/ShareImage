//
//  DTestTableViewCell.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/11.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface testModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *project;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *content;

@end

@interface DTestTableViewCell : UITableViewCell

@property (nonatomic, strong) testModel *model;

@end
