//
//  DAboutViewController.m
//  ShareImage
//
//  Created by FTY on 2017/3/15.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DAboutViewController.h"
#import "DWebViewController.h"

#import <MessageUI/MessageUI.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface DAboutViewController ()<MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) UILabel *developLabel;

@property (nonatomic, strong) UILabel *agreeLabel;
@property (nonatomic, strong) UILabel *reservedLabel;

@end

@implementation DAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kLocalizedLanguage(@"abAbout");
    self.navLeftItemType = DNavigationItemTypeBack;
    self.view.backgroundColor = DSystemColorGrayF3F3F3;
    
    [self setupData];
    [self setupSubViews];
    
}

- (void)setupData{
    NSString *key = @"CFBundleShortVersionString";
    // 获取当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    self.versionLabel.text = [NSString stringWithFormat:@"%@ %@", @"图享", currentVersion];
    
    self.emailLabel.text = [NSString stringWithFormat:@"%@ %@", kLocalizedLanguage(@"abContact"), @"feng.daisuke@gmail.com"];
    [self.emailLabel addKeyword:@"feng.daisuke@gmail.com" keywordColor:DSystemColorBlue33AACC];
    
    self.developLabel.text = [NSString stringWithFormat:@"%@ %@", kLocalizedLanguage(@"abDeveloperWebsite"), @"http://daisuke.cn"];
    [self.developLabel addKeyword:@"http://daisuke.cn" keywordColor:DSystemColorBlue33AACC];
    
    self.agreeLabel.text = kLocalizedLanguage(@"abUseAgreement");
    [self.agreeLabel addKeyword:kLocalizedLanguage(@"abUseAgreement") keywordColor:DSystemColorBlue33AACC];
    
    self.reservedLabel.text = @"Copyright© 2017 DaiSuke All Rights Reserved.";
    
}

- (void)setupSubViews{
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.emailLabel];
    [self.view addSubview:self.developLabel];
    [self.view addSubview:self.agreeLabel];
    [self.view addSubview:self.reservedLabel];
    
    CGSize imgSize = self.iconView.image.size;
    self.iconView.sd_layout
    .topSpaceToView(self.view, 50+self.navBarHeight)
    .leftSpaceToView(self.view, (self.view.width - imgSize.width)*0.5)
    .widthIs(imgSize.width)
    .heightIs(imgSize.height);
    

    self.versionLabel.sd_layout
    .topSpaceToView(self.iconView, 20)
    .leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .heightIs(20);
    
    self.emailLabel.sd_layout
    .topSpaceToView(self.versionLabel, 10)
    .leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .heightIs(20);
    
    self.developLabel.sd_layout
    .topSpaceToView(self.emailLabel, 10)
    .leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .heightIs(20);
    
    // ---
    
    self.reservedLabel.sd_layout
    .bottomSpaceToView(self.view, 10)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .heightIs(20);
    
    self.agreeLabel.sd_layout
    .bottomSpaceToView(self.reservedLabel, 10)
    .leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .heightIs(20);
    
}


- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - event
- (void)tapEmail{
    DLog(@"tapEmail");
    if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
        // 调用发送邮件的代码
        MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
        mailCompose.mailComposeDelegate = self;
        // 邮件主题
        [mailCompose setSubject:@"TestTitle"];
        // 收件人
        [mailCompose setToRecipients:@[@"1123047669@qq.com"]];
        
        // 设置内容
        [mailCompose setMessageBody:@"测试测试测试" isHTML:NO];
        // 弹出邮件发送视图
        [self presentViewController:mailCompose animated:YES completion:nil];
    } else {
        [SVProgressHUD setMaximumDismissTimeInterval:1.5];
        [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
        [SVProgressHUD showErrorWithStatus:@"Mail does not have an account！"];
    }
}


- (void)tapDevelop{
    DLog(@"tapDevelop");
    DWebViewController *webView = [[DWebViewController alloc] initWithUrl:@"http://daisuke.cn" type:WKWebViewLoadURLType];
    [self.navigationController pushViewController:webView animated:YES];
}


- (void)tapAgree{
    DLog(@"tapAgree");
    DWebViewController *webView = [[DWebViewController alloc] initWithUrl:@"https://www.baidu.com" type:WKWebViewLoadURLType];
    [self.navigationController pushViewController:webView animated:YES];
}


#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultSent:
        {
            
        }
            break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - getter & setter 
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage getImageWithName:@"common_no_data_image"];
    }
    return _iconView;
}

- (UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.textColor = [UIColor blackColor];
        _versionLabel.font = DSystemFontText;
        _versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLabel;
}

- (UILabel *)emailLabel{
    if (!_emailLabel) {
        _emailLabel = [[UILabel alloc] init];
        _emailLabel.textColor = [UIColor blackColor];
        _emailLabel.font = DSystemFontText;
        _emailLabel.textAlignment = NSTextAlignmentCenter;
        _emailLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEmail)];
        [_emailLabel addGestureRecognizer:tap];
    }
    return _emailLabel;
}

- (UILabel *)developLabel{
    if (!_developLabel) {
        _developLabel = [[UILabel alloc] init];
        _developLabel.textColor = [UIColor blackColor];
        _developLabel.font = DSystemFontText;
        _developLabel.textAlignment = NSTextAlignmentCenter;
        _developLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDevelop)];
        [_developLabel addGestureRecognizer:tap];
    }
    return _developLabel;
}

- (UILabel *)agreeLabel{
    if (!_agreeLabel) {
        _agreeLabel = [[UILabel alloc] init];
        _agreeLabel.textColor = [UIColor blackColor];
        _agreeLabel.font = DSystemFontText;
        _agreeLabel.textAlignment = NSTextAlignmentCenter;
        _agreeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAgree)];
        [_agreeLabel addGestureRecognizer:tap];
    }
    return _agreeLabel;
}

- (UILabel *)reservedLabel{
    if (!_reservedLabel) {
        _reservedLabel = [[UILabel alloc] init];
        _reservedLabel.textColor = DSystemColorBlackBBBBBB;
        _reservedLabel.font = DSystemFontDate;
        _reservedLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _reservedLabel;
}




@end
