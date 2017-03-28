//
//  DPhotosAPIManager.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotosAPIManager.h"
#import "DPhotosService.h"
#import "DSearchPhotosModel.h"
#import "DSearchCollectionsModel.h"
#import "DSearchUsersModel.h"
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDWebImageOperation.h>
#import <SVProgressHUD/SVProgressHUD.h>

@implementation DPhotosAPIManager

/**
 获取首页图片集合
 
 参数模型：DPhotosParamModel
 page：页数（Optional; default: 1）
 per_page：每页多少条（Optional; default: 10）
 order_by：排序（Valid values: latest, oldest, popular; default: latest）
 
 回调：requestServiceSucceedBackArray:(DPhotosModel)
 
 @param paramModel 参数模型
 */
- (void)fetchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel{
    
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self);
    [self.service fetchPhotosByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        @strongify(self)
        //分页处理:当start为0时需要做clearData处理，当获取的arr数据为空时，调用相关方法告知页面没有数据
        if([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:arr]){
            return;
        }
        
        [self requestServiceSucceedBackArray:arr];
        
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 获取单张图片详情
 
 参数模型：DPhotosParamModel
 pid：图片id (Required)
 w：图片宽度
 h：图片高度
 rect:裁剪矩形
 
 回调：requestServiceSucceedWithModel:(DPhotosModel)
 
 @param paramModel 参数模型
 */
- (void)fetchPhotoDetailsByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service fetchPhotoDetailsByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 随机获取一张图片
 
 参数模型：DPhotosParamModel
 根据分类id，collections;
 根据特色，featured;
 根据昵称，username;
 根据匹配，query;
 w	Image width in pixels.
 h	Image height in pixels.
 根据方向，orientation;
 获取张数 (Default: 1; max: 30)，count;（暂时不开放）
 
 回调：requestServiceSucceedWithModel:(DPhotosModel)
 
 @param paramModel 参数模型
 */
- (void)fetchRandomPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service fetchRandomPhotoByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 获取图片的统计信息
 
 参数模型：DPhotosParamModel
 pid：图片id (Required)
 
 回调：requestServiceSucceedWithModel:(DPhotosModel)
 
 @param paramModel 参数模型
 */
- (void)fetchPhotoStatsByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service fetchPhotoStatsByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 获取图片的下载地址
 
 参数模型：DPhotosParamModel
 pid：图片id (Required)
 
 回调：requestServiceSucceedBackString:(NSString)
 
 @param paramModel 参数模型
 */
- (void)fetchPhotoDownloadLinkByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service fetchPhotoDownloadLinkByParamModel:paramModel onSucceeded:^(NSString *str) {
        @strongify(self)
        [self requestServiceSucceedBackString:str];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

static float progress = 0.0f;
/**
 下载图片
 
 参数模型：DPhotosParamModel
 pid：图片id (Required)
 
 回调：requestServiceSucceedBackString:(NSString)
 
 @param paramModel 参数模型
 */
- (void)downloadPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel{
    /*
    [self addLoadingView];
    @weakify(self);
    [self.service fetchPhotoDownloadLinkByParamModel:paramModel onSucceeded:^(NSString *str) {
        @strongify(self)
        
        [self removeLoadingView];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:str] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            progress = receivedSize/(float)expectedSize;
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD showProgress:progress status:@"Downloading..."];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (finished) {
                [SVProgressHUD dismiss];
                @strongify(self)
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
        }];
        
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
     */
    @weakify(self);
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:paramModel.photoUrl] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        progress = receivedSize/(float)expectedSize;
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showProgress:progress status:@"Downloading..."];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished) {
            [SVProgressHUD dismiss];
            @strongify(self)
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }];
}




/**
 更新图片（没有权限）
 
 参数模型：DPhotosParamModel
 pid：图片id（必须）
 
 纬度,latitude;
 经度,longitude;
 城市,city;
 国家,country;
 城市名称,name;
 confidential;
 光圈,perture_value;
 曝光,exposure_time;
 焦距,focal_length;
 iso,iso_speed_ratings;
 相机名称,make;
 相机型号,model;
 
 回调：requestServiceSucceedWithModel:
 
 @param paramModel 参数模型
 */
- (void)updatePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service updatePhotoByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 喜欢图片
 
 参数模型：DPhotosParamModel
 pid：图片id (Required)
 
 回调：requestServiceSucceedWithModel:(DPhotosModel)
 
 @param paramModel 参数模型
 */
- (void)likePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service likePhotoByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}

/**
 取消喜欢图片
 
 参数模型：DPhotosParamModel
 pid：图片id (Required)
 
 回调：requestServiceSucceedWithModel:(DPhotosModel)
 
 @param paramModel 参数模型
 */
- (void)unLikePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service unLikePhotoByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 搜索图片
 
 参数模型：DPhotosParamModel
 query：关键字 (Required)
 page: 页数（Optional; default: 1）
 per_page: 每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedWithModel:(DSearchPhotosModel)
 
 @param paramModel 参数模型
 */
- (void)fetchSearchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self);
    [self.service fetchSearchPhotosByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        DSearchPhotosModel *photoModel = model;
        
        //分页处理:当start为0时需要做clearData处理，当获取的arr数据为空时，调用相关方法告知页面没有数据
        if([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:photoModel.photos]){
            return;
        }
        
        if (paramModel.page >= photoModel.total_pages) {
            [self hasNotMoreData];
            [self requestServiceSucceedWithModel:model];
            return;
        }
        
        [self requestServiceSucceedWithModel:model];
        
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 搜索分类
 
 参数模型：DPhotosParamModel
 query：关键字 (Required)
 page: 页数（Optional; default: 1）
 per_page: 每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedWithModel:(DSearchCollectionsModel)
 
 @param paramModel 参数模型
 */
- (void)fetchSearchCollectionsPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self);
    [self.service fetchSearchCollectionsPhotosByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        DSearchCollectionsModel *photoModel = model;
        
        //分页处理:当start为0时需要做clearData处理，当获取的arr数据为空时，调用相关方法告知页面没有数据
        if([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:photoModel.collections]){
            return;
        }
        
        if (paramModel.page >= photoModel.total_pages) {
            [self hasNotMoreData];
            [self requestServiceSucceedWithModel:model];
            return;
        }
        
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


/**
 搜索用户
 
 参数模型：DPhotosParamModel
 query：关键字 (Required)
 page: 页数（Optional; default: 1）
 per_page: 每页多少条（Optional; default: 10）
 
 回调：requestServiceSucceedWithModel:(DSearchUsersModel)
 
 @param paramModel 参数模型
 */
- (void)fetchSearchUsersByParamModel:(id<DPhotosParamProtocol>)paramModel{
    if (paramModel.page == 1) {
        [self addLoadingView];
    }
    @weakify(self);
    [self.service fetchSearchUsersByParamModel:paramModel onSucceeded:^(__kindof DJsonModel *model) {
        @strongify(self)
        DSearchUsersModel *photoModel = model;
        
        //分页处理:当start为0时需要做clearData处理，当获取的arr数据为空时，调用相关方法告知页面没有数据
        if([self needExecuteClearAndHasNoDataOperationByStart:paramModel.page arrData:photoModel.users]){
            return;
        }
        
        if (paramModel.page >= photoModel.total_pages) {
            [self hasNotMoreData];
            [self requestServiceSucceedWithModel:model];
            return;
        }
        
        [self requestServiceSucceedWithModel:model];
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}


#pragma mark - 私有方法
/**
 *  写入图片后执行的操作
 *
 *  @param image       写入的图片
 *  @param error       错误信息
 *  @param contextInfo UIImageWriteToSavedPhotosAlbum第三个参数
*/
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        
    } else {
        [self requestServiceSucceedByUserInfo];
    }
}



@end
