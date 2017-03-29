//
//  DCollectionViewCell.h
//  ShareImage
//
//  Created by FTY on 2017/2/23.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DCollectionsModel;
@interface DCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) DCollectionsModel *collection;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSIndexPathBlock clickDeleteBlock;

// 外部控制是否展示
- (void)showDeleteBtn;
- (void)hideDeleteBtn;

@end
