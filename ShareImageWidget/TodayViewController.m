//
//  TodayViewController.m
//  DWidget
//
//  Created by DaiSuke on 2017/2/8.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "DHeaderView.h"

@interface TodayViewController () <NCWidgetProviding, DHeaderViewDelegate>

@property (nonatomic, strong) DHeaderView *headerView;


@end

@implementation TodayViewController

- (DHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[DHeaderView alloc] init];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeCompact;
    }
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.headerView];
    self.headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 110);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    //    NCUpdateResultNewData   新的内容需要重新绘制视图
    //    NCUpdateResultNoData    部件不需要更新
    //    NCUpdateResultFailed    更新过程中发生错误

    completionHandler(NCUpdateResultNewData);
}

//-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
//    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
//        
//        NSLog(@"maxSize-%@",NSStringFromCGSize(maxSize));// maxSize-{359, 110}
//    }else{
//        NSLog(@"maxSize-%@",NSStringFromCGSize(maxSize));// maxSize-{359, 616}
//    }
//}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - DHeaderViewDelegate
- (void)headerView:(DHeaderView *)headerView didSelectWithIndex:(NSInteger)index{
    NSLog(@"index = %@", @(index));
    NSString *urlStr = [NSString stringWithFormat:@"DWidgetURL://%li",index];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
    }];
}

@end
