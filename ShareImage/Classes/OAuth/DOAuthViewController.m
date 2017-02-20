//
//  DOAuthViewController.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DOAuthViewController.h"
#import "DUserAPIManager.h"

#define kOAuthAppKey        @"61c8eb646bea05c96445b2a26d23aa64b7605002243a030f561ac923a08d8497"
#define kOAuthAppSecret        @"f43ac4f36ff9349ea366ef3b9f4714f231e51084282bd698e0ec8a6cb1397fb8"
#define kOAuthRedirectUrl        @"http://daisuke.cn"
#define kOAuthWebUrl        @"https://unsplash.com/oauth/authorize?client_id=%@&redirect_uri=%@&response_type=code&scope=public+read_user+write_user+read_photos+write_photos+write_likes+write_followers+read_collections+write_collections"


@interface DOAuthViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation DOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navLeftItemType = DNavigationItemTypeBack;
    
    [self.view addSubview:self.webView];
    
    self.webView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
    // 开始加载
    [self startLoad];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

    
#pragma mark - private
- (void)startLoad{
    // 获取文件路径
    NSURL *lineFileURL = [NSURL URLWithString:[NSString stringWithFormat:kOAuthWebUrl, kOAuthAppKey, kOAuthRedirectUrl]];
    
    // 建立连接
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:lineFileURL];
    [self.webView loadRequest:request];
}
    
    
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
    self.title = @"正在加载...";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    // 获取code
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length) {
        unsigned long los = range.location + range.length;
        NSString *code = [url substringFromIndex:los];
        
        // post请求code换取accesstoken
        [self accessTokenWithCode:code];
        
        // 不显示回调页面
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
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
    
#pragma mark - pravite
- (void)accessTokenWithCode:(NSString *)code{
    
    DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DOAuthParamModel *paramModel = [[DOAuthParamModel alloc] init];
    paramModel.client_id = kOAuthAppKey;
    paramModel.client_secret = kOAuthAppSecret;
    paramModel.redirect_uri = kOAuthRedirectUrl;
    paramModel.grant_type = @"authorization_code";
    paramModel.code = code;
    
    [manager oauthAccountByModel:paramModel];
    
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


#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    
    // 授权成功
    DLog(@"授权成功");
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - get & set
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        // 适应设定的尺寸
        [_webView sizeToFit];
    }
    return _webView;
}

    
@end
