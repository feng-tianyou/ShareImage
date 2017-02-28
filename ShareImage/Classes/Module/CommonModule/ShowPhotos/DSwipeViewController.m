//
//  DSwipeViewController.m
//  ShareImage
//
//  Created by FTY on 2017/2/28.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSwipeViewController.h"
#import "DPhotosModel.h"

#import <ZLSwipeableView/ZLSwipeableView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "DPhotoDetailController.h"

static float progress = 0.0f;

@interface DSwipeViewController ()<ZLSwipeableViewDataSource>
@property (nonatomic, strong) NSArray *photoModels;
@property (nonatomic, assign) NSInteger photoIndex;
@property (nonatomic, strong) ZLSwipeableView *swipeableView;
@end

@implementation DSwipeViewController

- (instancetype)initWithTitle:(NSString *)title photoModels:(NSArray *)photoModels index:(NSInteger)index{
    self = [super init];
    if (self) {
        self.photoModels = photoModels;
        self.title = title;
        self.photoIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navLeftItemType = DNavigationItemTypeBack;
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.view addSubview:self.swipeableView];
    self.swipeableView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.swipeableView discardAllViews];
    [self.swipeableView loadViewsIfNeeded];
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private
- (void)tapImageView:(UITapGestureRecognizer *)tap{
    DPhotoDetailController *detail = nil;
    if (self.photoIndex < 4) {
        NSInteger index = self.photoModels.count - (4 - self.photoIndex);
        detail = [[DPhotoDetailController alloc] initWithPhotoModel:self.photoModels[index]];
    } else {
        detail = [[DPhotoDetailController alloc] initWithPhotoModel:self.photoModels[self.photoIndex - 4]];
    }
    
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    if (self.photoIndex >= self.photoModels.count) {
        self.photoIndex = 0;
    }
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    
    UIImageView *imageView = [[UIImageView alloc] init];
//    [imageView addGestureRecognizer:tap];
    [imageView.layer setCornerRadius:10.0];
    [imageView.layer setMasksToBounds:YES];
    CGRect swipFrame = swipeableView.frame;
    [imageView setFrame:swipFrame.origin.x+40 y:swipFrame.origin.y+50 w:swipFrame.size.width - 80 h:swipFrame.size.height - 100];
    DPhotosModel *photoModel = self.photoModels[self.photoIndex];
    [imageView sd_setImageWithURL:[NSURL URLWithString:photoModel.urls.regular] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        progress = receivedSize/(float)expectedSize;
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showProgress:progress status:@"Loading..."];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [SVProgressHUD dismiss];
    }];
    
    
    self.photoIndex++;
    return imageView;
}

#pragma mark - setter & getter
- (ZLSwipeableView *)swipeableView{
    if (!_swipeableView) {
        _swipeableView = [[ZLSwipeableView alloc] init];
        _swipeableView.dataSource = self;
    }
    return _swipeableView;
}

@end
