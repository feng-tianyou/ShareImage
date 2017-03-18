//
//  DBaseViewController.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+DNetwork.h"
#import "UIViewController+DNavigation.h"

@interface DBaseViewController : UIViewController

/**
 附带信息
 */
@property (nonatomic, strong) NSMutableDictionary *networkUserInfo;
/**
 导航栏的高度
 */
@property (nonatomic, assign) CGFloat navBarHeight;


/**
 刷新语言文字
 */
- (void)refreshLanguage;



@end
