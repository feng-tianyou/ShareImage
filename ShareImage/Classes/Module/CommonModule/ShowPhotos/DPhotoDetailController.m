//
//  DPhotoDetailController.m
//  ShareImage
//
//  Created by FTY on 2017/2/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotoDetailController.h"
#import "DPhotosModel.h"

#import "DPhotoManager.h"

#import "DPhotosAPIManager.h"
#import "DPhotosParamModel.h"


@interface DPhotoDetailController ()

@property (nonatomic, strong) DPhotosModel *photoModel;

@property (nonatomic, strong) NSArray<DPhotosModel *> *photoModels;

@property (nonatomic, strong) DPhotoManager *manager;


@end

@implementation DPhotoDetailController

- (instancetype)initWithPhotoModel:(DPhotosModel *)photoModel{
    self = [super init];
    if (self) {
        self.photoModels = [NSArray arrayWithObject:photoModel];
        self.photoModel = photoModel;
    }
    return self;
}

- (instancetype)initWithPhotoModels:(NSArray<DPhotosModel *> *)photoModels{
    self = [super init];
    if (self) {
        self.photoModels = [NSArray arrayWithArray:photoModels];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    DPhotosAPIManager *manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
    DPhotosParamModel *param = [[DPhotosParamModel alloc] init];
    param.pid = self.photoModel.pid;
    [manager fetchPhotoDetailsByParamModel:param];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
   /* self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.alpha = 1.0;
    self.navigationController.navigationBar.hidden = NO;*/
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /*self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 0;
    self.navigationController.navigationBar.hidden = YES;
    
    NSMutableArray *photoUrlsM = [NSMutableArray arrayWithCapacity:self.photoModels.count];
    [self.photoModels enumerateObjectsUsingBlock:^(DPhotosModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [photoUrlsM addObject:obj.urls.regular];
    }];
    
    [self.manager photoPreviewWithPhotoUrls:photoUrlsM currentIndex:0 currentViewController:self];*/
}

#pragma mark - navEvent
- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    //[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DPhotoManagerDelegate


#pragma mark - getter & setter
- (DPhotoManager *)manager{
    if (!_manager) {
        _manager = [[DPhotoManager alloc] init];
    }
    return _manager;
}

- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    DLog(@"%@", dataModel);
}






@end
