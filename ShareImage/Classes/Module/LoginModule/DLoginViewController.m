//
//  DLoginViewController.m
//  DFrame
//
//  Created by DaiSuke on 16/8/23.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DLoginViewController.h"
#import "DFingerPrintManager.h"
#import "DTestViewController.h"

@interface DLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation DLoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self setupSubviews];
    
}

- (void)setupSubviews{
    
    UIButton *closebutton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 100, 40)];
    [closebutton setBackgroundColor:[UIColor redColor]];
    [closebutton setTitle:@"关闭" forState:UIControlStateNormal];
    [self.view addSubview:closebutton];
    [closebutton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *wxbutton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [wxbutton setBackgroundColor:[UIColor redColor]];
    [wxbutton setTitle:@"微信登录" forState:UIControlStateNormal];
    [self.view addSubview:wxbutton];
    [wxbutton addTarget:self action:@selector(wxlogin) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *qqbutton = [[UIButton alloc] initWithFrame:CGRectMake(100, 160, 100, 40)];
    [qqbutton setBackgroundColor:[UIColor redColor]];
    [qqbutton setTitle:@"qq登录" forState:UIControlStateNormal];
    [self.view addSubview:qqbutton];
    [qqbutton addTarget:self action:@selector(qqlogin) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *wbbutton = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 100, 40)];
    [wbbutton setBackgroundColor:[UIColor redColor]];
    [wbbutton setTitle:@"微博登录" forState:UIControlStateNormal];
    [self.view addSubview:wbbutton];
    [wbbutton addTarget:self action:@selector(wblogin) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *twobutton = [[UIButton alloc] initWithFrame:CGRectMake(100, 260, 100, 40)];
//    [twobutton setBackgroundColor:[UIColor redColor]];
//    [twobutton setTitle:@"第二个控制器" forState:UIControlStateNormal];
//    [self.view addSubview:twobutton];
//    [twobutton addTarget:self action:@selector(twoController) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [iconView.layer setCornerRadius:25.0];
    [iconView.layer setMasksToBounds:YES];
    [self.view addSubview:iconView];
    self.iconView = iconView;
    [iconView setFrame:100 y:320 w:50 h:50];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [nameLabel setFrame:0 y:350 w:self.view.width h:30];
    self.nameLabel = nameLabel;
    [self.view addSubview:nameLabel];
    
//    [self.iconView setImageWithURL:[NSURL URLWithString:KGLOBALINFOMANAGER.accountInfo.iconurl] placeholder:nil];
    [self.nameLabel setText:KGLOBALINFOMANAGER.accountInfo.name];
    
    
    
}

- (void)close{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)twoController{
    [self lottiePresentViewController:[[DTestViewController alloc] init] animated:YES completion:nil];
}


- (void)wxlogin{
    
}

- (void)qqlogin{
    
}

- (void)wblogin{
    
}

- (void)requestServiceSucceedByUserInfo:(NSDictionary *)userInfo{
//    [self.iconView setImageWithURL:[NSURL URLWithString:KGLOBALINFOMANAGER.accountInfo.iconurl] placeholder:nil];
    [self.nameLabel setText:KGLOBALINFOMANAGER.accountInfo.name];
}

@end
