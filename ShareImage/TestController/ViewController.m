//
//  ViewController.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "ViewController.h"
#import "DLoginManager.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.title = KGLOBALINFOMANAGER.accountInfo.name;
    
//    [self testLogin];
    
}

- (void)testLogin{
    DLoginManager *manager = [DLoginManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DLoginParamModel *param = [[DLoginParamModel alloc] init];
    param.userNo = @"13570385104";
    param.password = @"123456";
    [manager loginByParamModel:param];
}


- (void)requestServiceSucceedByUserInfo:(NSDictionary *)userInfo{
    DLog(@"%@", userInfo);
}

@end
