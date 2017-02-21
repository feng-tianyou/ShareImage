//
//  DPhotosService.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DPhotosService.h"
#import "DPhotosNetwork.h"

#import "DPhotosModel.h"
#import "DSearchPhotosModel.h"

#import "DPhotosValidRule.h"

@implementation DPhotosService

/**
 获取首页图片集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel
                  onSucceeded:(NSArrayBlock)succeededBlock
                      onError:(ErrorBlock)errorBlock{
    [self.network getPhotosByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        DLog(@"%@", arr);
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arr.count];
        for (NSDictionary *dic in arr) {
            DPhotosModel *photo = [DPhotosModel modelWithJSON:dic];
            [tmpArr addObject:photo];
        }
        
        [DBlockTool executeArrBlock:succeededBlock arrResult:[tmpArr copy]];
    } onError:errorBlock];
}

/**
 获取单张图片详情
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchPhotoDetailsByParamModel:(id<DPhotosParamProtocol>)paramModel
                   onSucceeded:(JsonModelBlock)succeededBlock
                       onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DPhotosValidRule checkPhotoIDByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getPhotoDetailsByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        DPhotosModel *photoModel = [DPhotosModel modelWithJSON:dic];
        [DBlockTool executeModelBlock:succeededBlock model:photoModel];
    } onError:errorBlock];
}


/**
 随机获取一张图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchRandomPhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                         onSucceeded:(JsonModelBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DPhotosValidRule checkPhotoIDByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getRandomPhotoByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        DPhotosModel *photoModel = [DPhotosModel modelWithJSON:dic];
        [DBlockTool executeModelBlock:succeededBlock model:photoModel];
    } onError:errorBlock];
}


/**
 获取图片的统计信息
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchPhotoStatsByParamModel:(id<DPhotosParamProtocol>)paramModel
                        onSucceeded:(JsonModelBlock)succeededBlock
                            onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DPhotosValidRule checkPhotoIDByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getPhotoStatsByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        DPhotosModel *photoModel = [DPhotosModel modelWithJSON:dic];
        [DBlockTool executeModelBlock:succeededBlock model:photoModel];
    } onError:errorBlock];
}


/**
 获取图片的下载地址
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchPhotoDownloadLinkByParamModel:(id<DPhotosParamProtocol>)paramModel
                             onSucceeded:(NSStringBlock)succeededBlock
                                 onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DPhotosValidRule checkPhotoIDByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getPhotoDownloadLinkByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        [DBlockTool executeStrBlock:succeededBlock result:[dic objectForKey:@"url"]];
    } onError:errorBlock];
}

/**
 更新图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)updatePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                    onSucceeded:(JsonModelBlock)succeededBlock
                        onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DPhotosValidRule checkPhotoIDByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network putUpdatePhotoByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        DPhotosModel *photoModel = [DPhotosModel modelWithJSON:dic];
        [DBlockTool executeModelBlock:succeededBlock model:photoModel];
    } onError:errorBlock];
}




/**
 喜欢图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)likePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                  onSucceeded:(JsonModelBlock)succeededBlock
                      onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DPhotosValidRule checkPhotoIDByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network postLikePhotoByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        NSDictionary *photoDic = [dic objectForKey:@"photo"];
        DPhotosModel *photoModel = [DPhotosModel modelWithJSON:photoDic];
        NSDictionary *userDic = [dic objectForKey:@"user"];
        DUserModel *userModel = [DUserModel modelWithJSON:userDic];
        photoModel.user = userModel;
        
        [DBlockTool executeModelBlock:succeededBlock model:photoModel];
    } onError:errorBlock];
}

/**
 取消喜欢图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)unLikePhotoByParamModel:(id<DPhotosParamProtocol>)paramModel
                    onSucceeded:(JsonModelBlock)succeededBlock
                        onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DPhotosValidRule checkPhotoIDByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network deleteUnLikePhotoByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        NSDictionary *photoDic = [dic objectForKey:@"photo"];
        DPhotosModel *photoModel = [DPhotosModel modelWithJSON:photoDic];
        NSDictionary *userDic = [dic objectForKey:@"user"];
        DUserModel *userModel = [DUserModel modelWithJSON:userDic];
        photoModel.user = userModel;
        
        [DBlockTool executeModelBlock:succeededBlock model:photoModel];
    } onError:errorBlock];
}




/**
 搜索图片
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchSearchPhotosByParamModel:(id<DPhotosParamProtocol>)paramModel
                          onSucceeded:(JsonModelBlock)succeededBlock
                              onError:(ErrorBlock)errorBlock{
    NSString *strAlert = [DPhotosValidRule checkSearchPhotoByParamModel:paramModel];
    if (strAlert.length > 0) {
        [DBlockTool executeErrorBlock:errorBlock errorText:strAlert];
        return;
    }
    [self.network getSearchPhotosByParamModel:paramModel onSucceeded:^(NSDictionary *dic) {
        DLog(@"%@", dic);
        DSearchPhotosModel *model = [DSearchPhotosModel modelWithJSON:dic];
        [DBlockTool executeModelBlock:succeededBlock model:model];
    } onError:errorBlock];
}






@end
