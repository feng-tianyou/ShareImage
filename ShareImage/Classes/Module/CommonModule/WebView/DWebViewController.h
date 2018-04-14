//
//  DWebViewController.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//


#import "DBaseViewController.h"

typedef NS_ENUM(NSInteger, WKWebViewLoadType) {
    WKWebViewLoadFileHTMLType, // 本地HTML语言
    WKWebViewLoadLineHTMLType, // 网上HTML语言
    WKWebViewLoadFileType, // 加载本地文件，格式：txt, PDF, doc, excel, gif, 图片等
    WKWebViewLoadURLType, // 加载路径
    WKWebViewLoadDataType // 加载数据
};
#warning 出现白屏问题，查找了相关资料也不行，哪位大佬能解决的，告知一声，谢谢
@interface DWebViewController : DBaseViewController

- (instancetype)initWithUrl:(NSString *)url;

- (instancetype)initWithUrl:(NSString *)url type:(WKWebViewLoadType)type;

@property (nonatomic, assign) WKWebViewLoadType type;
@property (nonatomic, copy) NSString *htmlstring;
@property (nonatomic, copy) NSString *urlStr;

@end
