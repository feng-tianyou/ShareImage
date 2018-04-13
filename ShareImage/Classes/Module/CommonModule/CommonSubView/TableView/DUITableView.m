//
//  DUITableView.m
//  ShareImage
//
//  Created by FTY on 2018/4/13.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import "DUITableView.h"

@implementation DUITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}

@end
