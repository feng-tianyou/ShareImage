//
//  DCollectionsService.m
//  ShareImage
//
//  Created by FTY on 2017/2/22.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCollectionsService.h"
#import "DCollectionsNetwork.h"

#import "DCollectionsModel.h"

@implementation DCollectionsService

/**
 获取分类集合
 
 @param paramModel 参数模型
 @param succeededBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchCollectionsByParamModel:(id<DCollectionParamProtocol>)paramModel
                         onSucceeded:(NSArrayBlock)succeededBlock
                             onError:(ErrorBlock)errorBlock{
    [self.network getCollectionsByParamModel:paramModel onSucceeded:^(NSArray *arr) {
        DLog(@"%@", arr);
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            DCollectionsModel *model = [DCollectionsModel modelWithJSON:dic];
            [tmpArr addObject:model];
        }];
        [DBlockTool executeArrBlock:succeededBlock arrResult:[tmpArr copy]];
    } onError:errorBlock];
}

@end
