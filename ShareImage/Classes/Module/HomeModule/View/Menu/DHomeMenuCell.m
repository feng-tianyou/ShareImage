//
//  DHomeMenuCell.m
//  ShareImage
//
//  Created by FTY on 2017/2/28.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DHomeMenuCell.h"

static NSString *const cellID = @"homeMenuCell";

@implementation DHomeMenuCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DHomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DHomeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

#pragma mark - 私有方法
- (void)setupSubViews{
    self.imageView.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 20)
    .widthIs(20)
    .heightIs(20);
    
    self.textLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.imageView, 10)
    .rightEqualToView(self.contentView)
    .heightIs(20);
    
}

@end
