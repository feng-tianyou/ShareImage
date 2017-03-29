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

- (void)showDeleteBtn;
- (void)hideDeleteBtn;

@end
