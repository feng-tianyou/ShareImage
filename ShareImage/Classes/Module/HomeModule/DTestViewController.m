//
//  DTestViewController.m
//  ShareImage
//
//  Created by FTY on 2018/5/5.
//  Copyright © 2018年 DaiSuke. All rights reserved.
//

#import "DTestViewController.h"
#import <WebKit/WebKit.h>
#import "DWebView.h"

@interface DTestViewController ()<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) DWebView *webView;
@end

@implementation DTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.navigationController.navigationBar setTranslucent:NO];
//    self.navLeftItemType = DNavigationItemTypeBack;
    
    DWebView *view = [[DWebView alloc] init];
    view.scrollView.backgroundColor = [UIColor greenColor];
    view.backgroundColor = [UIColor redColor];
    view.UIDelegate = self;
    view.navigationDelegate = self;
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self.view addSubview:view];
    self.webView = view;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.webView setFrame:0 y:88 w:self.view.width h:self.view.height - 88];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    DLogSize(webView.scrollView.contentSize);
//    DLogPoint(webView.scrollView.contentOffset);
//    DLogEdgeInsets(webView.scrollView.contentInset);
    
//    [self.webView setFrame:0 y:88 w:self.view.width h:self.view.height - 88];
//    [self.webView setNeedsLayout];
}

@end
