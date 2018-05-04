//
//  DSearchPhotoView.h
//  ShareImage
//
//  Created by FTY on 2018/5/3.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSearchViewController,DUITableView;
@interface DSearchPhotoView : UIView
{
    DUITableView *_tableView;
    NSMutableArray *_dataArray;
    NSInteger _page;
}

@property (nonatomic, weak) DSearchViewController *mainController;
@property (nonatomic, strong, readonly) NSMutableArray *dataArray;
@property (nonatomic, strong, readonly) DUITableView *tableView;
@property (nonatomic, assign, readonly) NSInteger page;

- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo;
- (void)hasNotMoreData;
- (void)clearData;
- (void)alertNoData;

@end
