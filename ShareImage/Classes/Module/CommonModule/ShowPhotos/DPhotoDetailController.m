//
//  DPhotoDetailController.m
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotoDetailController.h"
#import "DPhotosModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

static float progress = 0.0f;

@interface DPhotoDetailController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) DPhotosModel *photoModel;

@property (nonatomic, assign) CGRect oldFrame;
@property (nonatomic, assign) CGRect largeFrame;

@end

@implementation DPhotoDetailController

- (instancetype)initWithPhotoModel:(DPhotosModel *)photoModel{
    self = [super init];
    if (self) {
        self.photoModel = photoModel;
        self.title = photoModel.user.username;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navLeftItemType = DNavigationItemTypeBack;
    
    @weakify(self)
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.photoModel.urls.regular] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        progress = receivedSize/(float)expectedSize;
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showProgress:progress status:@"Loading..."];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [SVProgressHUD dismiss];
        @strongify(self)
        [self.view setNeedsLayout];
        
    }];
    
    [self addGestureRecognizer];
    //[self.view addSubview:self.scrollView];
    [self.view addSubview:self.imageView];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.oldFrame = self.imageView.frame;
    self.largeFrame = CGRectMake(0 - SCREEN_WIDTH, 0 - SCREEN_HEIGHT, 3 * self.oldFrame.size.width, 3 * self.oldFrame.size.height);
    
    CGSize imageSize = self.imageView.image.size;
    CGFloat imageY = (self.view.height - imageSize.height - self.navBarHeight)*0.5;
    [self.imageView setFrame:0 y:imageY w:self.view.width h:imageSize.height];

}

#pragma mark - navEvent
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private
- (void)addGestureRecognizer{
    // 旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    rotation.delegate = self;
    [self.imageView addGestureRecognizer:rotation];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    pinch.delegate = self;
    [self.imageView addGestureRecognizer:pinch];
    
    // 拖拉手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    pan.delegate = self;
    [self.imageView addGestureRecognizer:pan];
}

- (void)rotateView:(UIRotationGestureRecognizer *)rotaionGesture{
    UIView *view = rotaionGesture.view;
    if (rotaionGesture.state == UIGestureRecognizerStateBegan || rotaionGesture.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotaionGesture.rotation);
        [rotaionGesture setRotation:0];
    }
}

- (void)pinchView:(UIPinchGestureRecognizer *)pinchGesture{
    UIView *view = pinchGesture.view;
    
    //当手指离开屏幕时,将lastscale设置为1.0
    if(pinchGesture.state == UIGestureRecognizerStateEnded) {
        pinchGesture.scale = 1.0;
        return;
    }
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan || pinchGesture.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGesture.scale, pinchGesture.scale);
        /*
        if (self.imageView.frame.size.width < self.oldFrame.size.width) {
            self.imageView.frame = self.oldFrame;
            //让图片无法缩得比原图小
        }
        if (self.imageView.frame.size.width > 3 * self.oldFrame.size.width) {
            self.imageView.frame = self.largeFrame;
        }
         */
        pinchGesture.scale = 1;
    }
}

- (void)panView:(UIPanGestureRecognizer *)panGesture{
    UIView *view = panGesture.view;
    if (panGesture.state == UIGestureRecognizerStateBegan || panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGesture translationInView:view];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGesture setTranslation:CGPointZero inView:view];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - getter & setter
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.multipleTouchEnabled = YES;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

@end
