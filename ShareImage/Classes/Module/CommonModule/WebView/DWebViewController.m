//
//  DWebViewController.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DWebViewController.h"
#import "DShareManager.h"

@interface DWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation DWebViewController


#pragma mark - 暴露方法
- (instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        self.urlStr = [url copy];
        self.type = WKWebViewLoadURLType;
    }
    return self;
}

- (instancetype)initWithUrl:(NSString *)url type:(WKWebViewLoadType)type{
    self = [super init];
    if (self) {
        self.type = type;
        self.urlStr = [url copy];
    }
    return self;
}


- (void)startLoad{
    switch (self.type) {
        case WKWebViewLoadFileHTMLType:
        {
            // 加载本地HTML语言
            [self loadFileHTML];
        }
            break;
        case WKWebViewLoadLineHTMLType:
        {
            // 加载网络上HTML语言
            [self loadLineHTML];
        }
            break;
        case WKWebViewLoadFileType:
        {
            // 加载文本地件
            [self loadFile];
        }
            break;
        case WKWebViewLoadURLType:
        {
            // 加载URL
            [self loadURL];
        }
            break;
        case WKWebViewLoadDataType:
        {
            // 以数据形式加载文件
            [self loadData];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 加载方法
/**
 加载HTML语言
 *  应用场景：只加载网页的某一部分
 *  例如：完整的网页可能包含广告部分，但是又不想要广告，所以我们可以加载整个网页，然后截取想要的部分，再加载
 */
- (void)loadFileHTML{
    
    if (self.htmlstring.length > 0) {
        [self.webView loadHTMLString:self.htmlstring baseURL:[NSURL URLWithString:[[NSBundle mainBundle] bundlePath]]];
    }
}

/**
 加载网上HTML语言
 *  应用场景：只加载网页的某一部分
 *  例如：完整的网页可能包含广告部分，但是又不想要广告，所以我们可以加载整个网页，然后截取想要的部分，再加载
 */
- (void)loadLineHTML{
    if (self.urlStr.length > 0) {
        NSString *lineHtmlStr = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:self.urlStr] encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:lineHtmlStr baseURL:[NSURL URLWithString:self.urlStr]];
    }
}

/**
 文件有很多格式，常见的有：txt, PDF, doc, excel, gif, 图片等
 */
- (void)loadFile{
    
    // 获取文件路径
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:self.urlStr withExtension:nil];
    // 建立连接
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:fileURL];
    [self.webView loadRequest:request];
}

/**
 应用场景：加载从服务器上下载的文件，例如PDF、Word、txt、图片等文件
 文件有很多格式，常见的有：txt, PDF, doc, excel, gif, 图片等
 */
- (void)loadURL{
    // 获取文件路径
    NSURL *lineFileURL = [NSURL URLWithString:self.urlStr];
    
    // 建立连接
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:lineFileURL];
    [self.webView loadRequest:request];
}

/**
 应用场景：加载从服务器上下载的文件，例如PDF、Word、txt、图片等文件
 文件有很多格式，常见的有：txt, PDF, doc, excel, gif, 图片等
 */
- (void)loadData{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:self.urlStr withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    @weakify(self)
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        @strongify(self)
        [self.webView loadData:data MIMEType:response.MIMEType textEncodingName:@"UTF8" baseURL:[NSURL URLWithString:@""]];
    }];
    [dataTask resume];
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DSystemColorWhite;
    // 初始化导航栏
    [self setupNav];
    
    [self.view addSubview:self.webView];
    
    self.webView.sd_layout
    .topSpaceToView(self.navigationController.navigationBar, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
    [self startLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - 导航栏相关
/**
 初始化导航栏
 */
- (void)setupNav{
    
    self.navRighItemType = DNavigationItemTypeRightMenu;
    
    UIImage *image = [UIImage getImageWithName:@"navigationbar_btn_left"];
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setBackgroundImage:image forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setFrame:0 y:0 w:image.size.width h:image.size.height];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self.closeBtn setFrame:0 y:0 w:60 h:40];
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithCustomView:self.closeBtn];
    
    //创建UIBarButtonSystemItemFixedSpace
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -7;
    
    [self.navigationItem setLeftBarButtonItems:@[spaceItem,backBtnItem, closeBtn]];
}

- (void)clickBackBtn{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self navigationBarDidClickNavigationBtn:nil isLeft:YES];
    }
}

- (void)clickCloseBtn{
    [self navigationBarDidClickNavigationBtn:nil isLeft:YES];
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (!isLeft) {
        @weakify(self);
        [DShareManager  shareUrlForAllPlatformByTitle:[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"] content:@"" shareUrl:self.urlStr image:nil customPlatforms:@[@{@"platformIcon":@"common_refresh", @"platformName":@"刷新"}] parentController:self eventBlock:^(NSInteger index, NSDictionary *userInfo) {
            DLog(@"index = %@, userInfo = %@", @(index), userInfo);
            @strongify(self);
            [self.webView reload];
        }];
        
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - WKNavigationDelegate
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.title = @"正在加载...";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.closeBtn.hidden = !webView.canGoBack;
    
    [self removeNoNetworkAlertView];
    [self removeNetworkErrorReloadView];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (error.code == -999 || error.code == 102) {
        return;
    }
    [self proccessWebViewLoadFail];
}


- (void)proccessWebViewLoadFail{
    // 添加刷新页面
    [self addNotNetworkAlertViewAddInView:self.view];
    [self addnetworkErrorReloadViewAddInView:self.view];
    self.noNetworkDelegate = self;
}

/**
 点击刷新
 */
- (void)pressNoNetworkBtnToRefresh{
    [self removeNoNetworkAlertView];
    [self removeNetworkErrorReloadView];
    [self startLoad];
}


#pragma mark - get & set
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = DSystemColorWhite;
        _webView.delegate = self;
        // 适应设定的尺寸
        [_webView sizeToFit];
    }
    return _webView;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeBtn setTitle:@"Close" forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hidden = YES;
    }
    return _closeBtn;
}


@end
