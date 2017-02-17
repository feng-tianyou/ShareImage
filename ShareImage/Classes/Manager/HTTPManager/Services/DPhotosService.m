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




@end
