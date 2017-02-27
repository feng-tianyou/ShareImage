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

@interface DPhotoDetailController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) DPhotosModel *photoModel;
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
    // Do any additional setup after loading the view.
    
    self.navLeftItemType = DNavigationItemTypeBack;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.photoModel.urls.small] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        progress = receivedSize/(float)expectedSize;
        DLog(@"%f", progress);
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showProgress:progress status:@"Loading..."];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [SVProgressHUD dismiss];
        [self.view setNeedsLayout];
//        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.view addSubview:self.imageView];
    
    CGSize imageSize = self.imageView.image.size;
    CGFloat imageY = (self.view.height - imageSize.height)*0.5;
    self.imageView.sd_layout
    .topSpaceToView(self.view, imageY)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(imageSize.height);
}

#pragma mark - navEvent
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - getter & setter
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
