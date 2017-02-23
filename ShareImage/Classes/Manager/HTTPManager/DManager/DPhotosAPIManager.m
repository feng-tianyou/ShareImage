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
 pid：图片id（必须）
 
 回调：requestServiceSucceedWithModel:
 
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
 
 @param paramModel 参数模型
 */
- (void)downloadPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
    @weakify(self);
    [self.service fetchPhotoDownloadLinkByParamModel:paramModel onSucceeded:^(NSString *str) {
        @strongify(self)
        
        [self removeLoadingView];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:str] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            progress = receivedSize/(float)expectedSize;
            DLog(@"%f", progress);
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD showProgress:progress status:@"Loading..."];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            DLog(@"%@--%@", image, @(finished));
            if (finished) {
                [SVProgressHUD dismiss];
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
        }];
        
    } onError:^(DError *error) {
        @strongify(self)
        [self proccessNetwordError:error];
    }];
}




/**
 更新图片
 
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
 
 @param paramModel 参数模型
 */
- (void)fetchSearchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
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
 
 @param paramModel 参数模型
 */
- (void)fetchSearchCollectionsPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
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
 
 @param paramModel 参数模型
 */
- (void)fetchSearchUsersByParamModel:(id<DPhotosParamProtocol>)paramModel{
    [self addLoadingView];
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
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}


@end
