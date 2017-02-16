//
//  DWebViewController.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DWebViewController.h"
#import <WebKit/WebKit.h>
#import "DShareManager.h"

@interface DWebViewController ()<WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation DWebViewController
#pragma mark - get & set
- (WKWebView *)webView{
    if (!_webView) {
        // 配置文件
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        
        if (IOS9) {
            // 允许视频播放
            configuration.allowsAirPlayForMediaPlayback = YES;
            // 允许图片播放
            configuration.allowsPictureInPictureMediaPlayback = YES;
        }
        
        // 允许在线播放
        configuration.allowsInlineMediaPlayback = YES;
        
        // 循序与网页交互
        configuration.selectionGranularity = YES;
        
        // 是否支持记忆读取
        configuration.suppressesIncrementalRendering = YES;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        
        // 设置代理
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        // 开启手势触摸
        _webView.allowsBackForwardNavigationGestures = YES;
        // 适应设定的尺寸
        [_webView sizeToFit];
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        // 设置进度条颜色
        [_progressView setTrackTintColor:[UIColor whiteColor]];
        _progressView.progressTintColor = [UIColor setHexColor:@"#76EE00"];
    }
    return _progressView;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeBtn setTitle:@"Close" forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hidden = YES;
    }
    return _closeBtn;
}

#pragma mark - 暴露方法
- (instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        self.urlStr = [url copy];
        self.type = WKWebViewLoadURLType;
        [self startLoad];
    }
    return self;
}

- (instancetype)initWithUrl:(NSString *)url type:(WKWebViewLoadType)type{
    self = [super init];
    if (self) {
        self.type = type;
        self.urlStr = [url copy];
        [self startLoad];
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
        [self.webView loadData:data MIMEType:response.MIMEType characterEncodingName:@"UTF8" baseURL:[NSURL URLWithString:@""]];
    }];
    [dataTask resume];
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.webView];
    
    self.progressView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(3);
    
    CGFloat webH = self.view.height - 3;
    self.webView.sd_layout
    .topSpaceToView(self.progressView, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(webH);
    
    // 初始化导航栏
    [self setupNav];
    
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
    
    self.navRighItemType = DNavigationItemTypeRightPoint;
    
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
        [self baseViewControllerDidClickNavigationBtn:nil isLeft:YES];
    }
}

- (void)clickCloseBtn{
    [self baseViewControllerDidClickNavigationBtn:nil isLeft:YES];
}

- (void)baseViewControllerDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (!isLeft) {
        @weakify(self);
        [DShareManager  shareUrlForAllPlatformByTitle:self.webView.title content:@"" shareUrl:self.urlStr customPlatforms:@[@{@"platformIcon":@"common_refresh", @"platformName":@"刷新"}] parentController:self eventBlock:^(NSInteger index, NSDictionary *userInfo) {
            DLog(@"index = %@, userInfo = %@", @(index), userInfo);
            @strongify(self);
            [self.webView reload];
        }];
//        UIActivity *activity = [[UIActivity alloc] init];
//        
//        UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[] applicationActivities:@[]];
        
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - WKNavigationDelegate
/*
 这个是网页加载完成，导航的变化
 主意：这个方法是当网页的内容全部显示（网页内的所有图片必须都正常显示）的时候调用（不是出现的时候就调用），，否则不显示，或则部分显示时这个方法就不调用。
 */
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    DLog(@"加载完成调用");
    // 获取加载网页的标题
    self.title = self.webView.title;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.closeBtn.hidden = !webView.canGoBack;
    
    [self removeNoNetworkAlertView];
    [self removeNetworkErrorReloadView];
}


/**
 开始加载
 */
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    DLog(@"开始加载的时候调用。。");
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
    self.title = @"正在加载...";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
/**
 内容返回时调用
 */
}
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    DLog(@"当内容返回的时候调用");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    DLog(@"加载失败--%@", error);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.title = webView.title;
    if (error.code == -999) {
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
- (void)pressNoNetworkBtnToRefresh
{
    [self removeNoNetworkAlertView];
    [self removeNetworkErrorReloadView];
    [self startLoad];
}


/**
 计算webView进度条
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect = self.webView.frame;
                rect.origin.y = 0;
                self.webView.frame = rect;
            }];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect = self.webView.frame;
                rect.origin.y = 2.5;
                self.webView.frame = rect;
            }];
        }
    }
}

// 取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}




@end
