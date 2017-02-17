//
//  ViewController.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "ViewController.h"


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
    
}


- (void)requestServiceSucceedByUserInfo:(NSDictionary *)userInfo{
    DLog(@"%@", userInfo);
}

@end
