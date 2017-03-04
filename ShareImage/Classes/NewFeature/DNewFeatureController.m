//
//  DNewFeatureController.m
//  ShareImage
//
//  Created by FTY on 2017/3/4.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DNewFeatureController.h"
#import "DTabBarViewController.h"

#define MENewFeatureImageCount 3

@interface DNewFeatureController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation DNewFeatureController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    // 添加UIScrollView
    [self setupScrollview];
    
    // 添加PageControl
    [self setupPageControl];
}

/**添加PageControl*/
- (void)setupPageControl{
    
    // 添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = MENewFeatureImageCount;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    
    // 设置颜色
    pageControl.currentPageIndicatorTintColor = DColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = DColor(189, 189, 189);
    
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
}

/**添加UIScrollView*/
- (void)setupScrollview{
    
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    
    scrollview.frame = self.view.bounds;
    [self.view addSubview:scrollview];
    scrollview.delegate = self;
    
    CGFloat imageH = self.view.frame.size.height;
    CGFloat imageW = self.view.frame.size.width;
    for (int index = 0; index < MENewFeatureImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = nil;
//        if (is4inch) {
//            
//            name = [NSString stringWithFormat:@"new_feature_%d-568h", index+1];
//        } else {
//            name = [NSString stringWithFormat:@"new_feature_%d", index+1];
//        }
        imageView.image = [UIImage getImageWithName:name];
        
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollview addSubview:imageView];
        
        if (index == (MENewFeatureImageCount - 1)) {
            // 最后一张添加按钮
            [self setupLastImageView:imageView];
        }
        
    }
    
    // 设置滚动的内容尺寸
    scrollview.contentSize = CGSizeMake(imageW * MENewFeatureImageCount, 0);
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.bounces = NO;
}

- (void)setupLastImageView:(UIImageView *)imageView{
    
    // 可以交互
    imageView.userInteractionEnabled = YES;
    
    // 创建按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setBackgroundImage:[UIImage getImageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage getImageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    // 监听,切换控制器
    [startButton addTarget:self action:@selector(startWeiBo) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加checkbox
    UIButton *checkbox = [[UIButton alloc] init];
    checkbox.selected = YES;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setImage:[UIImage getImageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage getImageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat checkboxCenterX = centerX;
    CGFloat checkboxCenterY = imageView.frame.size.height * 0.5;
    checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    //    checkbox.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    //    checkbox.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [imageView addSubview:checkbox];
    
    
    [imageView addSubview:startButton];
}

- (void)startWeiBo{
    
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    // 切换窗口的跟控制器
    self.view.window.rootViewController = [[DTabBarViewController alloc] init];
}

- (void)checkboxClick:(UIButton *)checkbox{

}


#pragma mark - UIScrollViewDelegate方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 取出水平方向的X值
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 算出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}

@end
