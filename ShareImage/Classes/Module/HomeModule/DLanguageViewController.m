//
//  DLanguageViewController.m
//  ShareImage
//
//  Created by FTY on 2017/3/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DLanguageViewController.h"

@interface DLanguageViewController ()

@end

@implementation DLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Language";
    self.navRighItemType = DNavigationItemTypeRightSave;
    self.navLeftItemType = DNavigationItemTypeRightCancel;
    
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (isLeft) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
