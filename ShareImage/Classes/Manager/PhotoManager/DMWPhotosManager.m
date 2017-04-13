//
//  DMWPhotosManager.m
//  ShareImage
//
//  Created by FTY on 2017/4/13.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DMWPhotosManager.h"

#import "DPhotosModel.h"
#import "DCollectionsModel.h"

#import "DPhotosAPIManager.h"
#import "DPhotosParamModel.h"

#import "FSActionSheet.h"
#import "DPhotoHandleTool.h"

#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import <SDWebImage/SDWebImageManager.h>
#import <SVProgressHUD/SVProgressHUD.h>


@interface DMWPhotosManager ()<MWPhotoBrowserDelegate, DBaseManagerProtocol>
/**
 MWPhoto集合
 */
@property (nonatomic, strong) NSArray<MWPhoto *> *mwPhotos;
@property (nonatomic, strong) MWPhoto *photo;
@property (nonatomic, strong) DPhotoHandleTool *handleTool;

@end

@implementation DMWPhotosManager

#pragma mark - Public
/**
 初始化
 
 @return 对象
 */
+ (instancetype)manager{
    return [[self alloc] init];
}


#pragma mark - private
- (void)presentViewControllerMWPhotoBrowser{
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = YES;
    browser.zoomPhotosToFill = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;
#endif
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:self.currentIndex];
    
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    
    // Modal
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.currentViewController presentViewController:nc animated:YES completion:nil];
}


#pragma mark - Public -> MWPhotoBrowser
/**
 浏览图片(自动关闭页面)(MWPhotoBrowser)
 
 @param photoUrls 图片路径集合
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotoUrls:(NSArray *)photoUrls
                     currentIndex:(NSInteger)currentIndex
            currentViewController:(UIViewController *)currentViewController{
    if (photoUrls.count == 0) return;
    [self photoPreviewWithPhotoUrls:photoUrls photos:nil currentIndex:currentIndex currentViewController:currentViewController];
}


/**
 浏览图片(自动关闭页面)(MWPhotoBrowser)
 
 @param photos 图片集合
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotos:(NSArray *)photos
                  currentIndex:(NSInteger)currentIndex
         currentViewController:(UIViewController *)currentViewController{
    if (photos.count == 0) return;
    [self photoPreviewWithPhotoUrls:nil photos:photos currentIndex:currentIndex currentViewController:currentViewController];
}


/**
 浏览图片(自动关闭页面)(MWPhotoBrowser)
 
 @param photoModels 图片集合
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotoModels:(NSArray<DPhotosModel *> *)photoModels
                       currentIndex:(NSInteger)currentIndex
              currentViewController:(UIViewController *)currentViewController{
    
    self.currentIndex = currentIndex;
    self.currentViewController = currentViewController;
    
    NSMutableArray *tmpPhotos = [NSMutableArray arrayWithCapacity:0];
    [photoModels enumerateObjectsUsingBlock:^(DPhotosModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MWPhoto *photo = [[MWPhoto alloc] initWithURL:[NSURL URLWithString:obj.urls.regular]];
        photo.rawImageUrl = obj.urls.raw;
        photo.liked_by_user = obj.liked_by_user;
        photo.pid = obj.pid;
        DCollectionsModel *collectionModel = [obj.current_user_collections firstObject];
        NSString *caption = nil;
        
        if (collectionModel.title.length > 0) {
            caption = collectionModel.title;
        }
        if (collectionModel.c_description.length > 0 && collectionModel.title.length == 0) {
            caption = collectionModel.c_description;
        }
        if (collectionModel.title.length > 0 && collectionModel.c_description.length > 0) {
            caption = [NSString stringWithFormat:@"%@\n%@", caption, collectionModel.c_description];
        }
        photo.caption = caption;
        
        [tmpPhotos addObject:photo];
    }];
    
    self.mwPhotos = [tmpPhotos copy];
    
    [self presentViewControllerMWPhotoBrowser];
    
}


/**
 浏览图片(自动关闭页面)(MWPhotoBrowser)
 
 @param photoUrls 图片路径集合
 @param photos 图片集合
 @param currentIndex 当前图片索引
 @param currentViewController 当前控制器
 */
- (void)photoPreviewWithPhotoUrls:(NSArray *)photoUrls
                           photos:(NSArray *)photos
                     currentIndex:(NSInteger)currentIndex
            currentViewController:(UIViewController *)currentViewController{
    self.photoUrls = photoUrls;
    self.photos = photos;
    self.currentIndex = currentIndex;
    self.currentViewController = currentViewController;
    
    NSMutableArray *tmpPhotos = [NSMutableArray arrayWithCapacity:0];
    if (photos.count > 0) {
        [photos enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * _Nonnull stop) {
            [tmpPhotos addObject:[MWPhoto photoWithImage:image]];
        }];
    } else if (photoUrls.count > 0){
        [photoUrls enumerateObjectsUsingBlock:^(NSString *imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
            [tmpPhotos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:imageUrl]]];
        }];
    }
    
    self.mwPhotos = [tmpPhotos copy];
    
    [self presentViewControllerMWPhotoBrowser];
}


#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.mwPhotos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.mwPhotos.count)
        return [self.mwPhotos objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self.currentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoBrowserLongPressGesture:(MWPhotoBrowser *)photoBrowser photo:(MWPhoto *)photo {
    self.photo = photo;
    NSString *strLike = self.photo.liked_by_user ? @"已喜欢":@"喜欢";
    
    FSActionSheet *sheet = [[FSActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" highlightedButtonTitle:nil otherButtonTitles:@[strLike, @"保存",@"保存高清图片"]];
    @weakify(self)
    [sheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
        switch (selectedIndex) {
            case 0:
            {
                @strongify(self)
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                DPhotosAPIManager *manager = nil;
                DPhotosParamModel *paramModel = [[DPhotosParamModel alloc] init];
                paramModel.pid = photo.pid;
                if (photo.liked_by_user) {
                    [dic setValue:@"unLike" forKey:@"methor"];
                    manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:dic];
                    [manager unLikePhotoByParamModel:paramModel];
                } else {
                    [dic setValue:@"like" forKey:@"methor"];
                    manager = [DPhotosAPIManager getHTTPManagerByDelegate:self info:dic];
                    [manager likePhotoByParamModel:paramModel];
                }
            }
                break;
            case 1:
            {
                [self.handleTool imageWriteToSavedPhotosAlbumWithImage:photo.underlyingImage];
            }
                break;
            case 2:
            {
                [self.handleTool downloadImageWithURL:[NSURL URLWithString:photo.rawImageUrl]];
            }
                break;
                
            default:
                break;
        }
    }];
}


#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    NSString *methor = [userInfo objectForKey:@"methor"];
    NSString *tipStr = nil;
    if ([methor isEqualToString:@"like"]) {
        tipStr = @"喜欢";
    } else {
        tipStr = @"取消喜欢";
    }
    DPhotosModel *photoModel = dataModel;
    self.photo.liked_by_user = photoModel.liked_by_user;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setMaximumDismissTimeInterval:1.0];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD showSuccessWithStatus:tipStr];
}


#pragma mark - getter & setter
- (NSArray<MWPhoto *> *)mwPhotos{
    if (!_mwPhotos) {
        _mwPhotos = [NSArray array];
    }
    return _mwPhotos;
}

- (DPhotoHandleTool *)handleTool{
    if (!_handleTool) {
        _handleTool = [[DPhotoHandleTool alloc] init];
    }
    return _handleTool;
}

@end
