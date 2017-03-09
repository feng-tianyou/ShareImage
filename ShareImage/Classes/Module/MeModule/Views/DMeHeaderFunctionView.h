//
//  DMeHeaderFunctionView.h
//  ShareImage
//
//  Created by DaiSuke on 2017/3/7.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNumberButton.h"


@interface DMeHeaderFunctionView : UIView

@property (nonatomic, strong) DNumberButton *photoBtn;
@property (nonatomic, strong) DNumberButton *followersBtn;
@property (nonatomic, strong) DNumberButton *followingBtn;

- (void)reloadData;

@end
